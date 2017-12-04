package kr.co.sh86.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.sh86.user.dao.UserDao;
import kr.co.sh86.user.domain.Album;
import kr.co.sh86.user.domain.Comment;
import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.GoodCheck;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.Mms;
import kr.co.sh86.user.domain.MmsReport;
import kr.co.sh86.user.domain.MmsStat;
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.Sinbo;
import kr.co.sh86.user.domain.SinboDb;
import kr.co.sh86.user.domain.UploadFileDTO;
import kr.co.sh86.user.domain.User;
import kr.co.sh86.util.UtilDate;
import kr.co.sh86.util.UtilFile;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	//주소 분할을 위한 주소와 회원아이디 조회
	public void createAddServ() {
		List<User> list = userDao.selectAddAll();
		
		// 풀주소,도,시 저장할 변수선언
		String fullAdd;
		String addDo = null;
		String cityName = null; 
		
		//풀주소에서 도, 시 이름 추출.
		for(int i=0; i<list.size() ; i++) {
			if(list.get(i).getUserAddress() != "" && list.get(i).getUserAddress() != null) {
				User user = new User();
				fullAdd = list.get(i).getUserAddress(); //풀주소
				
				if(fullAdd.equals("서울") || fullAdd.equals("대전")) {
					addDo = fullAdd; //도
				}else {
					addDo = fullAdd.substring(0, 2); //도
					
				}
				
				
				if(addDo.equals("서울") || addDo.equals("제주")) { //시
					cityName = addDo;
				}else if(fullAdd.length() > 2){
					cityName = fullAdd.substring(3,6);
				}else if(fullAdd.length() < 3){
					cityName = addDo;
				}
				user.setUserDo(addDo);
				user.setUserCityName(cityName);;
				user.setUserId(list.get(i).getUserId());
				
				// 기존회원정보에서 도명, 시명을 수정처리한다.
				userDao.updateDoAndCity(user);
			}
		}		
	}
	
	// 모든회원정보 조회
	public List<User> readAllUser(){
		return userDao.selectAllUser();
	}
	
	//신보
	public int sinboServ() {
		List<SinboDb> list = userDao.selectSinboRes();
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(i+" 번째 아이디값 확인 : "+list.get(i).getMemId());
			Sinbo sinbo = new Sinbo();
			sinbo = userDao.selectSinbo(list.get(i).getMemId());
			int result = userDao.updateSinbo(sinbo);
		}
		return 0;
	}
	
	// 문자 -수신자조회
	public List<User> readUserForMmsServ(String key, String value){
		Map<String,String> params = new HashMap<String,String>();
		List<User> userList = new ArrayList<User>();
		
		if(key.equals("class")) {
			params.put("userId", value);
			userList = userDao.selectUserForMms(params);
			/*System.out.println("반으로 조회값 확인 : "+ userList);*/
		}else if(key.equals("local")){
			params.put("userAddress", value);
			userList = userDao.selectUserForMms(params);
			/*System.out.println("주소로 조회값 확인 : "+ userList);*/
		}
		
		return userList;
	}
	
	//문자 변수 세팅해주는 메서드
	public Mms setMms(int scheduleType, String subject, String callback, String destInfo, int destCount, String msg) {
		Mms mms = new Mms();
		mms.setCallback(callback);
		mms.setDestCount(destCount);
		mms.setDestInfo(destInfo);
		mms.setSubject(subject);
		mms.setScheduleType(scheduleType);
		mms.setMmsMsg(msg);
		
		return mms;
	}
	//문자 - mms발송
	public int sendMmsServ(String key, String value, String msg) {
		final int scheduleType = 0;
		final String subject = "신흥고86회 동문회";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		msg += "\n http://sh86.kr/?userId=";
		String destInfo = null;
		int destCount = 0; // 수신자목록 개수 최대:100
		int result = 0;
		String mmsMsg = null;
		
		UtilDate utilDate = new UtilDate();
		Mms mms = new Mms();
		
		String sendDate = utilDate.getCurrentDateTime().substring(0,11) + "000";
		/*System.out.println("전송시간 조회값 확인 : "+sendDate);*/
		
		List<User> userList = readUserForMmsServ(key, value); // 문자 보낼 회원조회
		for(int i=0; i<userList.size(); i++) {
			mmsMsg = null;
			destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
			mmsMsg = msg + userList.get(i).getUserId();
			destCount = 1;
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, mmsMsg);
			result = userDao.sendMmsToSelected(mms);
		}
		
		/*List<User> sendCheckUserList = userDao.selectUserMmsTaken(sendDate);
		System.out.println(sendCheckUserList);*/
		
		MmsReport mmsReport = new MmsReport();
		mmsReport.setMmsMsg(mmsMsg.substring(0, 10)+"..");
		mmsReport.setMmsSendDate(utilDate.getCurrentDateTime());
		mmsReport.setMmsSender("오민권");
		/*mmsReport.setMmsSuccess(userDao.selectUserMmsTakenSuccess(sendDate));*/
		mmsReport.setMmsTotalCount(userList.size());
		
		System.out.println("문자 전송후 값 세팅 확인 : "+mmsReport);
		int insertResult = userDao.insertMmsReport(mmsReport);
		
		System.out.println("문자 전송후 입력확인 : "+insertResult);
		/*System.out.println("전송결과 확인 : "+sendCheckUserList);*/
		/* 뒤에 url안붙여도 되는 문자 로직 100건씩 컷해서 보냄.
		 * if(userList.size() < 100) {
			for(int i=0; i<userList.size(); i++) {
				if(i == 0) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size();
			// insert 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
		}else if(userList.size() > 100 && userList.size() < 200) {
			for(int i=0; i<100; i++) {
				if(i == 0) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=100; i<userList.size(); i++) {
				if(i == 100) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 100 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
		}else if(userList.size() > 200 && userList.size() < 300) {
			for(int i=0; i<100; i++) {
				if(i == 0) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=100; i<200; i++) {
				if(i == 100) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=200; i<userList.size(); i++) {
				if(i == 200) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 200 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
		}else if(userList.size() > 300) { //DB에 휴대폰번호 있는 회원 수가 322명임
			for(int i=0; i<100; i++) {
				if(i == 0) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=100; i<200; i++) {
				if(i == 100) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=200; i<300; i++) {
				if(i == 200) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 200 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=300; i<userList.size(); i++) {
				if(i == 300) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 300 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
		}
		System.out.println("문자전송 확인 : "+result);*/
		
		return insertResult;
	}
	
	//문자 - 직접입력
	public int sendMmsDirectServ(String userHp ,String msg) {
		final int scheduleType = 0;
		final String subject = "신흥고 86회 동문회";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		String destInfo = null;
		int destCount = 1; // 수신자목록 개수 최대:100
		int result = 0;
		
		Mms mms = new Mms();
		destInfo = "신흥고"+"^"+userHp;
		mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
		
		result = userDao.sendMmsToSelected(mms);
		
		return result;
	}
	
	//문자 > 전체발송
	public int sendMmsAllServ(String msg) {
		final int scheduleType = 0;
		final String subject = "신흥고 86회 동문회";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		String destInfo = null;
		msg += "\n http://sh86.kr/?userId=";
		int destCount = 1; // 수신자목록 개수 최대:100
		int result = 0;
		String mmsMsg = null;
		UtilDate utilDate = new UtilDate();
		String sendDate = utilDate.getCurrentDateTime().substring(0,11) + "000";
		
		List<User> userList = userDao.selectAllUserForMms();
		
		Mms mms = new Mms();
		for(int i=0; i<userList.size(); i++) {
			mmsMsg = null;
			destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
			mmsMsg = msg + userList.get(i).getUserId();
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, mmsMsg);
			result = userDao.sendMmsToSelected(mms);
		}
		/*List<User> sendCheckUserList = userDao.selectUserMmsTaken(sendDate);*/
		
		MmsReport mmsReport = new MmsReport();
		mmsReport.setMmsMsg(mmsMsg.substring(0, 10)+"..");
		mmsReport.setMmsSendDate(utilDate.getCurrentDateTime());
		mmsReport.setMmsSender("오민권");
		/*mmsReport.setMmsSuccess(userDao.selectUserMmsTakenSuccess(sendDate));*/
		mmsReport.setMmsTotalCount(userList.size());
		
		System.out.println("문자 전송후 값 세팅 확인 : "+mmsReport);
		int insertResult = userDao.insertMmsReport(mmsReport);
		
		System.out.println("문자 전송후 입력확인 : "+insertResult);
		
		/* 문자내용에 url첨부 아닐때 로직
		 * if(userList.size() > 300) { //DB에 휴대폰번호 있는 회원 수가 322명임
			for(int i=0; i<100; i++) {
				if(i == 0) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=100; i<200; i++) {
				if(i == 100) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = 100 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=200; i<300; i++) {
				if(i == 200) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 200 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
			for(int i=300; i<userList.size(); i++) {
				if(i == 300) {
					destInfo = userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}else {
					destInfo += "|"+userList.get(i).getUserName() + "^" + userList.get(i).getUserHp().replaceAll("-", "");
				}
				System.out.println(destInfo);
			}
			destCount = userList.size() - 300 ;
			//인서트 쿼리 호출
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
		}*/
		
		return insertResult;
	}
	
	// 공지 - 부의공지 등록
	public int addNoticeContentServ(Notice notice, Content content, String userId) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		/*String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		
		writerHp = first+"-"+second+"-"+last;*/ //입력받은 중간에 하이픈 삽입하기
		
		User user = userDao.selectWriter(userId);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		
		int result = userDao.insertNotice(notice);
		/*System.out.println("공지입력 후 입력된 데이터 pk값 확인 : "+notice.getNoNum());*/
		
		//3. 공지테이블에 인서트한 pk가져와서 컨텐트(부의)테이블에 인서트
		content.setNoNum(notice.getNoNum());
		content.setCoUserHp(userDao.selectUserInfoByContent(content));
		result = userDao.insertContent(content);
		
		//4. 입력한 부의테이블pk 가져와서 공지테이블에 컨텐츠넘버 수정.
		notice.setNoContentNum(content.getCoNum());
		result = userDao.updateNoticeContentNum(notice);
		
		//등록 후 단체문자발송
		/*if(result > 0) {
			String msg = "부의공지 알림 \n " + content.getCoContent() +"\n 자세한내용은 링크를 클릭하여 확인해주세요.";
			sendMmsAllServ(msg);
		}*/
		
		return result;
	}
	
	// 공지 - 행사공지 등록
	public int addNoticeEventServ(Notice notice, Event event, String userId) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		/*String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		
		writerHp = first+"-"+second+"-"+last; //입력받은 중간에 하이픈 삽입하기*/		
		User user = userDao.selectWriter(userId);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		
		int result = userDao.insertNotice(notice);
		/*System.out.println("공지입력 후 입력된 데이터 pk값 확인 : "+notice.getNoNum());*/
		
		//3. 공지테이블에 인서트한 pk가져와서 컨텐트(부의)테이블에 인서트
		event.setNoNum(notice.getNoNum());
		
		result = userDao.insertEvent(event);
		
		//4. 입력한 부의테이블pk 가져와서 공지테이블에 컨텐츠넘버 수정.
		notice.setNoContentNum(event.getCoNum());
		result = userDao.updateNoticeContentNum(notice);
		
		//등록 후 단체문자발송
		/*if(result > 0) {
			String msg = "행사공지 알림 \n " + event.getCoContent() +"\n 자세한내용은 링크를 클릭하여 확인해주세요.";
			sendMmsAllServ(msg);
		}*/
		
		return result;
	}
	
	// 공지 - 축하공지 등록
	public int addNoticeServ(Notice notice, String userId) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		/*String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		
		writerHp = first+"-"+second+"-"+last; //입력받은 중간에 하이픈 삽입하기
*/		
		User user = userDao.selectWriter(userId);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		notice.setNoUserHp(userDao.selectUserInfoByNotice(notice));
		
		int result = userDao.insertNoticeCong(notice);
		/*System.out.println("공지입력 후 입력된 데이터 pk값 확인 : "+notice.getNoNum());*/		
		
		return result;
	}
	
	//공지 > 모든공지사항조회
	public List<NoticeView> readAllNoticeServ(){
		List<NoticeView> noticeList = userDao.selectAllNotice();
		List<NoticeView> resultList = new ArrayList<NoticeView>();
		UtilDate utilDate = new UtilDate();
		
		for(int i=0; i<noticeList.size(); i++) {
			NoticeView noticeView = new NoticeView();
			
			if(noticeList.get(i).getNoType() == 1) {
				noticeView = userDao.selectNoticeContent(noticeList.get(i).getNoContentNum());
				User user = userDao.selectUserImgByContent(noticeView);
				noticeView.setUserImgOld(user.getUserImgOld());
				noticeView.setUserImgNew(user.getUserImgNew());
			}else if(noticeList.get(i).getNoType() == 2) {
				noticeView = userDao.selectNoticeEvent(noticeList.get(i).getNoContentNum());
				Join join = new Join();
				join.setNoNum(noticeView.getNoNum());
				join.setJoDate("참여");
				int joinCount = userDao.selectEventJoinCount(join);
				int notJoinCount = userDao.selectEventNotJoinCount(join);
				noticeView.setJoinCount(joinCount);
				noticeView.setNotJoinCount(notJoinCount);
			}else if(noticeList.get(i).getNoType() == 3) {
				noticeView = noticeList.get(i);
				User user = userDao.selectUserImgByCong(noticeView);
				noticeView.setUserImgOld(user.getUserImgOld());
				noticeView.setUserImgNew(user.getUserImgNew());
			}
			noticeView.setNoRegDateAfter(utilDate.getAfterDate(noticeView.getNoRegDate(),1));
			resultList.add(noticeView);
		}
		
		return resultList;
	}
	
	// 공지> 공지목록 > 부의공지 참여체크
	public int addJoinCheckServ(int noNum, String joJoinShape, String joDate, int joMoney, String sessionId) {
		Join join = new Join();
		
		if(joJoinShape.equals("참여")) {
			join.setJoDate(joDate);
		}else if(joJoinShape.equals("불참")) {
			join.setJoMoney(joMoney);
		}
		join.setJoJoinShape(joJoinShape);
		join.setNoNum(noNum);
		join.setUserId(sessionId);
		
		int result = userDao.insertJoin(join);
		return result;
	}
	
	// 공지> 공지목록 > 행사공지 참여체크
	public int addJoinCheckServ(int noNum, String joJoinShape, String userId) {
		Join join = new Join();
		int result = 0;
		
		join.setNoNum(noNum);
		join.setUserId(userId);
		
		int joinResult = userDao.selectEventJoinCount(join);
		if(joinResult == 0) {
			NoticeView noticeView = userDao.selectNoticeEventForJoin(noNum);
			
			join.setJoDate(noticeView.getCoEventDate());
			join.setJoMoney(noticeView.getCoMoney());
			join.setJoJoinShape(joJoinShape);
			result = userDao.insertJoin(join);
		}else {
			result = 0;
		}
		
		return result;
	}
	
	// 포토 - 사진업로드
	/*public int addPhotoServ(MultipartHttpServletRequest request, String userId) {
		UtilFile utilFile = new UtilFile();
		UploadFileDTO uploadFile = utilFile.singleUploadFile(request, userId.substring(0,1));
		User user = new User();
		
		return 0;
	}*/
	
	// 마이페이지 - 새로운사진업로드(사진둘다 없을때)
	public int addUserNewImgServ(MultipartHttpServletRequest request, String userId) {
		UtilFile utilFile = new UtilFile();
		UploadFileDTO uploadFile = utilFile.singleUploadFile(request, userId.substring(0,1), "myPage");
		User user = new User();
		user.setUserImgNew(uploadFile.getFileName());
		user.setUserId(userId);
		
		int result = userDao.updateUserImgNew(user);
		return result;
	}
	
	// 마이페이지 - 정보업데이트
	public int modifyUserInfoServ(User user, String userId) {
		user.setUserId(userId);
		if(user.getUserBirthMonth() != null && user.getUserBirthDay() != null) {
			user.setUserBirth(user.getUserBirthMonth()+user.getUserBirthDay());
		}
		if(user.getUserAddress() != null && user.getUserAddress() != "") {
			user.setUserDo(user.getUserAddress().trim().substring(0, 2));
			user.setUserCityName(user.getUserAddress().trim().substring(3, 6));
		}
		return userDao.updateUserInfo(user);
	}
	
	//문자 - mms발송
	public int sendMmsServ1() {
		final int scheduleType = 0;
		final String subject = "신용보증재단";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		String destInfo = null;
		int destCount = 1; // 수신자목록 개수 최대:100
		int result = 0;
		String msg = "전북신용보증재단 서비스 만족도 조사입니다.\r\n" + 
				"아래 링크를 눌러 조사에 응답해 주시면 더욱 좋은 서비스로 보답 하겠습니다.\r\n" + 
				"편하신 시간에 응답해 주시기 바랍니다.\r\n" + 
				"http://bestpoll.kr/19/0726.jsp?sbNum=";
		
		Mms mms = new Mms();
		List<Sinbo> userList = userDao.sinboLast(); // 문자 보낼 회원조회
		
		for(int i=3; i<userList.size(); i++) {
			destInfo = userList.get(i).getSbCeo() + "^" + userList.get(i).getSbHp();
			msg += userList.get(i).getSbNum();
			mms = setMms(scheduleType, subject, callback, destInfo, destCount, msg);
			result = userDao.sendMmsToSelected(mms);
			
		}
		
		return result;
	}
	
	// 옛날사진파일명 업로드
	public int modifyOldImgServ() {
		List<User> userList = userDao.selectUserIdAll();
		for(int i=0; i<userList.size();i++) {
			String oldImgName = "3"+userList.get(i).getUserId().toString()+".jpg";
			
			userList.get(i).setUserImgOld(oldImgName);
			int result = userDao.updateOldImg(userList.get(i));
			
		}
		return 0;
	}
	
	// 접속시 유저테이블 접속카운팅 ++
	public int modifyJoinCountServ(String userId) {
		User user = userDao.selectUserById(userId);
		int plusCount = user.getUserJoinCheck()+1;
		user.setUserJoinCheck(plusCount);
		int result = userDao.updateUserConnection(user);
		
		return result;
	}
	
	// 반별 휴대폰 보유자 수 카운팅
	public List<Integer> readCountByHpServ(){
		String[] classList = {"1","2","3","4","5","6","7","8"};
		List<Integer> countList = new ArrayList<Integer>();
		int count = 0;
		
		for(int i=0; i<classList.length; i++) {
			count = userDao.selectCountByHp(classList[i]);
			countList.add(count);
		}
		
		return countList;
	}
	
	//1번이라도 접속했던 유저수 카운팅
	public List<Integer> readCountByJoinServ(){
		String[] classList = {"1","2","3","4","5","6","7","8"};
		List<Integer> joinCountList = new ArrayList<Integer>();
		int count = 0;
		
		for(int i=0; i<classList.length; i++) {
			count = userDao.selectCountByJoin(classList[i]);
			joinCountList.add(count);
		}
		return joinCountList;
	}
	
	// 친구 - 회원조회(이름)
	public List<User> readUserByUserNameServ(String userName){
		return userDao.selectUserByUserName(userName);
	}
	
	// 친구 - 회원조회(반)
	public List<User> readUserByClassServ(String classNum){
		return userDao.selectUserByClass(classNum);
	}
	
	//마이페이지 - 개인정보조회
	public User readUserByCookieIdServ(String userId) {
		return userDao.selectUserByCookieId(userId);
	}
	
	//일상등록
	public int addAlbumServ(MultipartHttpServletRequest request, String userId) {
		String albumMsg = request.getParameter("albumMsg");
		Album album = new Album();
		album.setAlbumMsg(albumMsg);
		album.setUserId(userId);
		
		int result = userDao.insertAlbum(album);
		int uploadResult = 0;
		
		UtilFile utilFile = new UtilFile();
		if(result > 0) {
			UploadFileDTO uploadFile = utilFile.singleUploadFile(request, userId.substring(0,1), "album");
			uploadFile.setAlbumNo(album.getAlbumNo());
			
			uploadResult = userDao.insertAlbumPhoto(uploadFile);
		}
		
		return uploadResult;
	}
	
	//일상조회
	public List<Album> readAlbumAllServ(){
		List<Album> albumList = userDao.selectAllAlbum();
		
		for(int i=0; i<albumList.size();i++) {
			List<UploadFileDTO> photoList = userDao.selectPhotoForAlbum(albumList.get(i).getAlbumNo()); //사진조회
			List<Comment> commentList = userDao.selectAllAlbumComment(albumList.get(i).getAlbumNo()); //댓글조회
			albumList.get(i).setFileList(photoList);
			albumList.get(i).setCommentList(commentList);
		}
		
		return albumList;
	}
	
	// 일상 > 좋아요등록
	public int addAlbumGoodServ(GoodCheck goodCheck, String userId, int albumGood) {
		goodCheck.setUserId(userId);
		
		int count = userDao.selectGoodCheckByUser(goodCheck);
		System.out.println("좋아요 카운트확인 : "+count);
		int result = 0;
		
		if(count == 0) {
			result = userDao.insertGoodByAlbum(goodCheck);
			albumGood += 1;
		}else if(count >= 1){
			result = 0;
		}
		
		Album album = new Album();
		album.setAlbumGood(albumGood);
		album.setAlbumNo(goodCheck.getAlbumNo());
		
		int updateResult = userDao.updateAlbumGoodCount(album);
	
		return result;
	}
	
	//일상 > 댓글등록
	public Map<String, Object> addAlbumCommentServ(Comment comment) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = userDao.insertAlbumComment(comment);
		int comNum = comment.getComNum();
		if(result > 0) {
			/*comment = new Comment();
			comment = userDao.selectAlbumComment(comNum);
			resultMap.put("comment", comment);*/
			
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}				
		return resultMap;
	}
	
	//일상 > 글삭제, 글삭제후 댓글삭제
	public Map<String, String> removeAlbumByAlbumNo(int albumNo){
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userDao.deleteAlbumByAlbumNo(albumNo);
		if(result > 0) {
			result = userDao.deleteCommentByAlbumNo(albumNo);
			resultMap.put("check", "true");
			
		}else {
			resultMap.put("check", "false");
		}
		return resultMap;
	}
	
	//일상 > 글삭제, 글삭제후 댓글삭제
	public Map<String, String> modifyAlbumServ(Album album){
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userDao.updateAlbum(album);
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}
		return resultMap;
	}
	
	//일상조회(등록자이름으로)
	public List<Album> readAlbumByUserNameServ(String userName){
		List<Album> albumList = userDao.selectAlbumByUserName(userName);
		
		for(int i=0; i<albumList.size();i++) {
			List<UploadFileDTO> photoList = userDao.selectPhotoForAlbum(albumList.get(i).getAlbumNo()); //사진조회
			List<Comment> commentList = userDao.selectAllAlbumComment(albumList.get(i).getAlbumNo()); //댓글조회
			albumList.get(i).setFileList(photoList);
			albumList.get(i).setCommentList(commentList);
		}
		
		return albumList;
	}
	
	//공지 > 글삭제
	public Map<String, String> removeNoticeServ(int noNum){
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userDao.deleteNotice(noNum);
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}
		return resultMap;
	}
	
	//공지 > 글수정 > 수정할글 조회
	public NoticeView readNoticeByTypeServ(int noNum, int noType) {
		NoticeView noticeView = new NoticeView();
		if(noType == 1) {
			noticeView = userDao.selectNoticeContentByNoNum(noNum);
		}else if(noType == 2) {
			noticeView = userDao.selectNoticeEventByNoNum(noNum);
		}else if(noType == 3) {
			noticeView = userDao.selectNoticeByNoNum(noNum);
			System.out.println(noticeView);
		}
		return noticeView;
	}
	
	//공지 > 공지글수정
	public Map<String, String> modifyNoticeByTypeServ(NoticeView noticeView) {
		Map<String, String> resultMap = new HashMap<String, String>();
		int noType = noticeView.getNoType();
		int result = 0;
		
		if(noType == 1) {
			//부의
			result = userDao.updateNotice(noticeView);
			if(result > 0) result = userDao.updateContentNotice(noticeView);
		}else if(noType == 2) {
			//행사
			result = userDao.updateNotice(noticeView);
			if(result > 0) result = userDao.updateEventNotice(noticeView);
		}else if(noType == 3) {
			//축하
			result = userDao.updateNotice(noticeView);
		}
		
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}
		return resultMap;
	}
	
	//포토 > 포토타입별 사진조회
	public List<UploadFileDTO> readFileInfoByPhotoTypeServ(int photoType){
		return userDao.selectFileInfoByPhotoType(photoType);
	}
	
	//포토 > 포토타입별 사진조회2 > 30주년 기념식
	public List<UploadFileDTO> readFileInfoByPhotoTypeAndFolderServ(int photoType, String folderName){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("photoType", photoType);
		params.put("folderName", folderName);
		return userDao.selectFileInfoByPhotoTypeAndFolder(params);
	}
		
	//포토 > 포토타입별 댓글조회
	public List<UploadFileDTO> readPhotoCommentByPhotoTypeServ(int photoType, List<UploadFileDTO> photoList){
		Map<String, Integer> params = new HashMap<String, Integer>();
		for(int i=0; i<photoList.size(); i++) {
			params.put("photoType", photoType);
			params.put("fileNo", photoList.get(i).getFileNo());
			
			List<Comment> commentList = userDao.selectPhotoCommentByPhotoType(params);
			photoList.get(i).setCommentList(commentList);
			/*System.out.println(photoList.get(i));*/
		}
		
		return photoList;
	}
	
	//포토 > 댓글등록
	public Map<String, Object> addPhotoCommentServ(Comment comment) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		int result = userDao.insertAlbumComment(comment);
		
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}				
		return resultMap;
	}
	
	// 포토 > 좋아요등록
	public int addPhotoGoodServ(GoodCheck goodCheck, String userId, int photoGoods) {
		goodCheck.setUserId(userId);
		
		int count = userDao.selectGoodCheckByUser(goodCheck);
		System.out.println("좋아요 카운트확인 : "+count);
		System.out.println("값확인 : "+photoGoods);
		int result = 0;
		
		if(count == 0) {
			result = userDao.insertGoodByAlbum(goodCheck);
			System.out.println("+된 좋아요 카운트 확인 : "+photoGoods);
			
			UploadFileDTO uploadFileDto = new UploadFileDTO();
			uploadFileDto.setPhotoGoods(photoGoods+1);
			uploadFileDto.setFileNo(goodCheck.getFileNo());
			
			int updateResult = userDao.updatePhotoGoodCount(uploadFileDto);
		}else if(count >= 1){
			result = 0;
		}
	
		return result;
	}
	
	
	//관리 - 이용현황
	public List<User> readUserConnectionServ(String classNum){
		return userDao.selectUserConnection(classNum);
	}
	
	//관리 - 회비합계
	public Map<String, Object> readUserSumAllServ(){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		List<Integer> duesList = new ArrayList<Integer>();
		List<Integer> thirtyList = new ArrayList<Integer>();
		List<Integer> kibuList = new ArrayList<Integer>();
		int sum = 0;
		
		for(int i=1; i<9; i++) {
			sum = userDao.selectUserDuesSum(String.valueOf(i));
			duesList.add(sum);
		}
		
		for(int i=1; i<9; i++) {
			sum = userDao.selectUser30thSum(String.valueOf(i));
			thirtyList.add(sum);
		}
		
		for(int i=1; i<9; i++) {
			sum = userDao.selectUser30thKibuSum(String.valueOf(i));
			kibuList.add(sum);
		}
		resultMap.put("duesList", duesList);
		resultMap.put("thirtyList", thirtyList);
		resultMap.put("kibuList", kibuList);
		return resultMap;
	}
	
	//관리 - 회비합계(오버로딩)
	public Map<String, Object> readUserSumAllServ(String classNum){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int duesSum = userDao.selectUserDuesSum(classNum);
		int thirtySum = userDao.selectUser30thSum(classNum);
		int kibuSum = userDao.selectUser30thKibuSum(classNum);
		
		resultMap.put("duesSum", duesSum);
		resultMap.put("thirtySum", thirtySum);
		resultMap.put("kibuSum", kibuSum);
		
		return resultMap;
	}
	
	//일상 > 생일자 자동 일상에 생축글 올리는 스케줄러
	public void addAlbumSchedulerServ() {
		//오늘날짜 월일을 확인하여 조건에 맞는 생일인 사람이 있는지 db조회 하고 있으면 일상글 인서트 하면됨.
		UtilDate utilDate = new UtilDate();
		String today = utilDate.getAfterDate(utilDate.getCurrentDate(), 1).replace("-", "");
		
		String birthDay = today.substring(4,today.length());
		
		User user = userDao.selectUserBirthday(birthDay);
		
		if(user != null) {
			Album album = new Album();
			album.setAlbumMsg(user.getUserId().substring(0, 1)+"반 "+user.getUserName()+" 님 생일을 축하합니다~!!");
			album.setUserId("632");
			
			int result = userDao.insertAlbum(album);
			if(result > 0) {
				UploadFileDTO uploadFileDto = new UploadFileDTO();
				uploadFileDto.setFileOriginalName("birthday.jpg");
				uploadFileDto.setFileName("birthday.jpg");
				uploadFileDto.setFilePath("img");
				uploadFileDto.setAlbumNo(album.getAlbumNo());
				
				int uploadResult = userDao.insertAlbumPhoto(uploadFileDto);
			}
		}
	}
	
	//일상 > 댓글삭제
	public Map<String,String> removeCommentByComNumServ(int comNum){
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userDao.deleteCommentByComNum(comNum);
		
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}				
		return resultMap;
	}
	
	//공지 > 행사참여자 조회
	public List<User> readUserByEventJoinServ(int noNum){
		List<User> userList = userDao.selectUserByEventJoin(noNum);
		return userList;
	}
	
	//포토 - 사진확대보기
	public UploadFileDTO readPhotoBiggerServ(int fileNo) {
		return userDao.selectPhotoBigger(fileNo);
	}
	
	//포토 > 사진확대 > 댓글조회
	public UploadFileDTO readPhotoCommentByfileNoServ(int photoType, UploadFileDTO uploadFileDto){
		Map<String, Integer> params = new HashMap<String, Integer>();
		
		params.put("photoType", photoType);
		params.put("fileNo", uploadFileDto.getFileNo());
		
		List<Comment> commentList = userDao.selectPhotoCommentByPhotoType(params);
		uploadFileDto.setCommentList(commentList);
		/*System.out.println(photoList.get(i));*/
		
		
		return uploadFileDto;
	}
	
	//포토 > 사진삭제
	public Map<String, String> removePhotoAndCommentServ(Map<String, Integer> params){
		int result = userDao.deletePhoto(params.get("fileNo"));
		Map<String, String> resultMap = new HashMap<String, String>();
		
		if(result > 0) {
			List<Comment> commentList = userDao.selectPhotoCommentByPhotoType(params);
			for(int i=0; i<commentList.size(); i++) {
				userDao.deleteCommentByComNum(commentList.get(i).getComNum());
			}
		}
		if(result > 0) {
			resultMap.put("check", "true");
		}else {
			resultMap.put("check", "false");
		}	
		return resultMap;
	}
	
	// 문자 -월별 전송건수 조회
	public List<Integer> readCountMmsByMonthServ() {
		String sendDate = "201709";
		int count = userDao.selectCountMmsByMonth(sendDate);
		List<Integer> countList = new ArrayList<Integer>();
		/*System.out.println("1차확인 : "+count);*/
		countList.add(count);
		
		sendDate = "201710";
		count = userDao.selectCountMmsByMonth(sendDate);
		/*System.out.println("2차확인 : "+count);*/
		countList.add(count);
		
		/*System.out.println(countList);*/
		return countList;
	}
	
	//문자 - 월별 발송이력조회
	public List<MmsReport> readReportByMonth(String sendDate){
		/*System.out.println("날짜확인 : "+sendDate);*/
		List<MmsReport> mmsList = userDao.selectReportByMonth(sendDate);
		for(int i=0; i<mmsList.size(); i++) {
			/*System.out.println("시간확인 : "+mmsList.get(i).getMmsSendDate());*/
			mmsList.get(i).setMmsSuccess(userDao.selectUserMmsTakenSuccess(mmsList.get(i).getMmsSendDate()));
		}
		return mmsList;
	}
	
	//문자 - 성공여부조회 건별
	public List<User> readUserSuccessByDateTimeServ(String sendDate){
		return userDao.selectUserSuccessByDateTime(sendDate);
	}
}
