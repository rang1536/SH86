package kr.co.sh86.user.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.sh86.user.dao.UserDao;
import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.Mms;
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
		
		if(key.equals("name")) {
			params.put("userName", value);
			userList = userDao.selectUserForMms(params);
			System.out.println("이름으로 조회값 확인 : "+ userList);
		}else if(key.equals("hp")) {
			params.put("userHp", value);
			userList = userDao.selectUserForMms(params);
			System.out.println("핸드폰으로 조회값 확인 : "+ userList);
		}else if(key.equals("local")){
			params.put("userAddress", value);
			userList = userDao.selectUserForMms(params);
			System.out.println("주소로 조회값 확인 : "+ userList);
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
	public int sendMmsServ(String key, String value, String msg, String sendTel) {
		final int scheduleType = 0;
		final String subject = "신흥고 86회 동문회";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		String destInfo = null;
		int destCount = 0; // 수신자목록 개수 최대:100
		int result = 0;
		
		Mms mms = new Mms();
		
		List<User> userList = readUserForMmsServ(key, value); // 문자 보낼 회원조회
		if(userList.size() < 100) {
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
		System.out.println("문자전송 확인 : "+result);
		
		return result;
	}
	
	//문자 - 직접입력
	public int sendMmsDirectServ(String userHp ,String msg, String sendTel) {
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
	public int sendMmsAllServ(String msg, String sendTel) {
		final int scheduleType = 0;
		final String subject = "신흥고 86회 동문회";
		final String callback = "0632880488"; //발송번호는 등록된 번호만 가능. 추후 대표님 폰등은 필요하면 따로 등록.
		String destInfo = null;
		int destCount = 0; // 수신자목록 개수 최대:100
		int result = 0;
		List<User> userList = userDao.selectAllUserForMms();
		
		Mms mms = new Mms();
		
		if(userList.size() > 300) { //DB에 휴대폰번호 있는 회원 수가 322명임
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
		
		return result;
	}
	
	// 공지 - 부의공지 등록
	public int addNoticeContentServ(Notice notice, Content content, String writerHp, String sangseAdd) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		/*System.out.println(first+" ,"+second+", "+last);*/
		
		writerHp = first+"-"+second+"-"+last; //입력받은 중간에 하이픈 삽입하기
		
		User user = userDao.selectWriter(writerHp);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		
		int result = userDao.insertNotice(notice);
		/*System.out.println("공지입력 후 입력된 데이터 pk값 확인 : "+notice.getNoNum());*/
		
		//3. 공지테이블에 인서트한 pk가져와서 컨텐트(부의)테이블에 인서트
		content.setNoNum(notice.getNoNum());
		content.setCoPlace(content.getCoPlace()+" "+sangseAdd);
		
		result = userDao.insertContent(content);
		
		//4. 입력한 부의테이블pk 가져와서 공지테이블에 컨텐츠넘버 수정.
		notice.setNoContentNum(content.getCoNum());
		result = userDao.updateNoticeContentNum(notice);
		
		return result;
	}
	
	// 공지 - 행사공지 등록
	public int addNoticeEventServ(Notice notice, Event event, String writerHp, String sangseAdd) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		/*System.out.println(first+" ,"+second+", "+last);*/
		
		writerHp = first+"-"+second+"-"+last; //입력받은 중간에 하이픈 삽입하기
		
		User user = userDao.selectWriter(writerHp);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		
		int result = userDao.insertNotice(notice);
		/*System.out.println("공지입력 후 입력된 데이터 pk값 확인 : "+notice.getNoNum());*/
		
		//3. 공지테이블에 인서트한 pk가져와서 컨텐트(부의)테이블에 인서트
		event.setNoNum(notice.getNoNum());
		event.setCoPlace(event.getCoPlace()+" "+sangseAdd);
		
		result = userDao.insertEvent(event);
		
		//4. 입력한 부의테이블pk 가져와서 공지테이블에 컨텐츠넘버 수정.
		notice.setNoContentNum(event.getCoNum());
		result = userDao.updateNoticeContentNum(notice);
		
		return result;
	}
	
	// 공지 - 행사공지 등록
	public int addNoticeServ(Notice notice, String writerHp) {
		//1. 작성자 휴대폰으로 작성자 정보조회
		String first = writerHp.substring(0,3);
		String second = writerHp.substring(3,7);
		String last = writerHp.substring(7,11);
		/*System.out.println(first+" ,"+second+", "+last);*/
		
		writerHp = first+"-"+second+"-"+last; //입력받은 중간에 하이픈 삽입하기
		
		User user = userDao.selectWriter(writerHp);
		/*System.out.println("조회된 유저정보 확인 : "+user);*/
		
		//2. 작성자 정보 포함 공지테이블에 인서트
		notice.setNoWriter(user.getUserName());
		notice.setUserId(user.getUserId());
		
		int result = userDao.insertNotice(notice);
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
			}else if(noticeList.get(i).getNoType() == 2) {
				noticeView = userDao.selectNoticeEvent(noticeList.get(i).getNoContentNum());
			}else if(noticeList.get(i).getNoType() == 3) {
				noticeView = noticeList.get(i);
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
	public int addJoinCheckServ(int noNum, String joJoinShape, String payType, String sessionId) {
		NoticeView noticeView = userDao.selectNoticeEventForJoin(noNum);
		Join join = new Join();
		
		if(joJoinShape.equals("참여")) {
			join.setJoDate(noticeView.getCoEventDate());
			join.setJoMoney(noticeView.getCoMoney());
			join.setJoPayType(payType);
		}
		join.setJoJoinShape(joJoinShape);
		join.setNoNum(noNum);
		join.setUserId(sessionId);
		
		int result = userDao.insertJoin(join);
		return result;
	}
	
	// 포토 - 사진업로드
	public int addPhotoServ(MultipartHttpServletRequest request, String userId) {
		UtilFile utilFile = new UtilFile();
		UploadFileDTO uploadFile = utilFile.singleUploadFile(request, userId.substring(0,1));
		User user = new User();
		
		return 0;
	}
	
	// 마이페이지 - 새로운사진업로드(사진둘다 없을때)
	public int addUserNewImgServ(MultipartHttpServletRequest request, String userId) {
		UtilFile utilFile = new UtilFile();
		UploadFileDTO uploadFile = utilFile.singleUploadFile(request, userId.substring(0,1));
		User user = new User();
		user.setUserImgNew(uploadFile.getFileName());
		user.setUserId(userId);
		
		int result = userDao.updateUserImgNew(user);
		return result;
	}
	
	// 마이페이지 - 정보업데이트
	public int modifyUserInfoServ(User user, String userId) {
		user.setUserId(userId);
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
			System.out.println(i+" 번째 문자전송 결과확인 : "+result);
		}
		
		return result;
	}
	
	// 옛날사진파일명 업로드
	public int modifyOldImgServ() {
		List<User> userList = userDao.selectUserIdAll();
		for(int i=0; i<userList.size();i++) {
			String oldImgName = "3"+userList.get(i).getUserId().toString()+".jpg";
			System.out.println(i+ " 번째 파일풀네임 확인 : "+oldImgName);
			
			userList.get(i).setUserImgOld(oldImgName);
			int result = userDao.updateOldImg(userList.get(i));
			System.out.println(i+" 번째 파일네임변경 확인 : "+result);
		}
		return 0;
	}
	
	// 접속시 유저테이블 접속카운팅 ++
	public int modifyJoinCountServ(String userId) {
		User user = userDao.selectUserById(userId);
		user.setUserJoinCheck(user.getUserJoinCheck()+1);
		
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
	
	//마이페이지 - 개인정보조회
	public User readUserByCookieIdServ(String userId) {
		return userDao.selectUserByCookieId(userId);
	}
}
