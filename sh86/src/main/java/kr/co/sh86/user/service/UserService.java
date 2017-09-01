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
		
		for(int i=0; i<noticeList.size(); i++) {
			NoticeView noticeView = new NoticeView();
			
			if(noticeList.get(i).getNoType() == 1) {
				noticeView = userDao.selectNoticeContent(noticeList.get(i).getNoContentNum());				
			}else if(noticeList.get(i).getNoType() == 2) {
				noticeView = userDao.selectNoticeEvent(noticeList.get(i).getNoContentNum());
			}else if(noticeList.get(i).getNoType() == 3) {
				noticeView = noticeList.get(i);
			}
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
	public int addPhotoServ(MultipartHttpServletRequest request) {
		UtilFile utilFile = new UtilFile();
		UploadFileDTO uploadFile = utilFile.singleUploadFile(request);
		
		return 0;
	}
}
