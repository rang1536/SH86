package kr.co.sh86.user.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.sh86.user.domain.Album;
import kr.co.sh86.user.domain.Comment;
import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.GoodCheck;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.MmsReport;
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.PhotoList;
import kr.co.sh86.user.domain.UploadFileDTO;
import kr.co.sh86.user.domain.User;
import kr.co.sh86.user.service.UserService;

@CrossOrigin(origins="*")
@RestController
@SessionAttributes("sessionId")

public class UserRestController {
	@Autowired
	private UserService userService;
	
	//문자 - 수신자 검색
	@RequestMapping(value="/searchList", method=RequestMethod.POST)
	public Map<String, Object> searchUserCtrl(@RequestParam("searchKey") String key,
			@RequestParam("searchValue") String value){
		System.out.println("수신자검색 : "+key+value);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 검색키값으로 해당값 조회하여 뷰로 리턴하고 상세입력창 세팅해주기
		List<User> userList = userService.readUserForMmsServ(key, value);
		
		resultMap.put("userList", userList);
		resultMap.put("count", userList.size());
		
		return resultMap;
	}

	//문자 > 회원검색 > 검색된 회원에게 전송하기
	@RequestMapping(value="/mmsSend", method=RequestMethod.POST)
	public Map<String, Object> mmsSendCtrl(@RequestParam(value="searchKey", defaultValue="none") String key,
			@RequestParam(value="searchValue", defaultValue="none") String value,
			@RequestParam(value="mmsMsg") String msg){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 검색키값으로 해당값 조회하여 뷰로 리턴하고 상세입력창 세팅해주기
		int result = userService.sendMmsServ(key, value, msg);
		
		if(result > 0) {
			resultMap.put("check", "성공");
			
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//문자 > 전체발송 > 휴대폰번호가 입력되어진 전체 회원에게 문자발송
	@RequestMapping(value="/mmsSendAll", method=RequestMethod.POST)
	public Map<String, Object> mmsSendAllCtrl(@RequestParam(value="mmsMsg") String msg){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 전체회원문자발송
		int result = userService.sendMmsAllServ(msg);
		
		if(result > 0) {
			resultMap.put("check", "성공");
			
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//소식 > 공지등록 > 부의공지등록
	@RequestMapping(value="/noticeContentAdd", method=RequestMethod.POST)
	public Map<String, String> noticeContentAdd(Notice notice, Content content){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 부의정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		
		result = userService.addNoticeContentServ(notice, content, "632");	
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지등록 > 행사공지등록
	@RequestMapping(value="/noticeEventAdd", method=RequestMethod.POST)
	public Map<String, String> noticeEventAdd(Notice notice, Event event){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 행사정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		result = userService.addNoticeEventServ(notice, event, "632");
		
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지등록 > 일반공지등록
	@RequestMapping(value="/noticeAdd", method=RequestMethod.POST)
	public Map<String, String> noticeAdd(Notice notice){
		
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		result = userService.addNoticeServ(notice, "632");
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지목록 > 부의참여체크
	@RequestMapping(value="/joinAdd", method=RequestMethod.POST)
	public Map<String, String> joinAdd(@CookieValue(value="cookieId")Cookie cookie,
			@RequestParam(value="noNum") int noNum,
			@RequestParam(value="joJoinShape")String joJoinShape,
			@RequestParam(value="joDate", defaultValue="none")String joDate,
			@RequestParam(value="joMoney", defaultValue="0")int joMoney){
		// 세션아이디값으로 작성자 아이디 넣고 등록일은 현재시간으로 해서 db저장하면됨.
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addJoinCheckServ(noNum, joJoinShape,joDate,joMoney, cookie.getValue());
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//소식 > 공지목록 > 행사참여체크
	@RequestMapping(value="/joinEventAdd", method=RequestMethod.POST)
	public Map<String, String> joinEventAdd(@RequestParam(value="localUserId")String userId,
			@RequestParam(value="noNum") int noNum,
			@RequestParam(value="joJoinShape")String joJoinShape){
		// 세션아이디값으로 작성자 아이디 넣고 등록일은 현재시간으로 해서 db저장하면됨.
		System.out.println(joJoinShape);
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addJoinCheckServ(noNum, joJoinShape, userId);
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//포토 > 사진등록
	@RequestMapping(value="/photoAdd", method=RequestMethod.POST)
	public Map<String, String> photoAddCtrl(MultipartHttpServletRequest request){
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addPhotoServ(request, "photolist");
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//친구 > 회원검색(이름)
	@RequestMapping(value="/searchUserByName", method= {RequestMethod.GET, RequestMethod.POST})
	public List<User> searchUserByNameCtrl(@RequestParam(value="userName") String userName){
		/*System.out.println("외부접속 회원검색");
		System.out.println("값확인 : "+userName);
		System.out.println(URLDecoder.decode(userName));*/
		
		List<User> userList = userService.readUserByUserNameServ(URLDecoder.decode(userName));
		/*System.out.println("조회목록 : "+userList);*/
		return userList;
	}
	
	//친구 > 반별목록검색
	@RequestMapping(value="/searchUserByClass", method= {RequestMethod.GET, RequestMethod.POST})
	public List<User> searchUserByClassCtrl(@RequestParam(value="classNum") String classNum){
		System.out.println("외부접속 반별목록");
		List<User> userList = userService.readUserByClassServ(classNum);
		System.out.println(userList);
		return userList;
	}
	
	//마이페이지 > 회원정보수정.
	@RequestMapping(value="/userModify", method=RequestMethod.POST)
	public Map<String, String> userModifyCtrl(MultipartHttpServletRequest request,
			@CookieValue(value="cookieId")Cookie cookie){
		String userId = cookie.getValue();
		int result = userService.addUserNewImgServ(request, userId);
		System.out.println("사진등록 확인 : "+result);
		Map<String, String> check = new HashMap<String, String>();
		
		if(result > 0) check.put("check", "true");
		else check.put("check", "false");
		
		return check;
	}
	
	//마이페이지 > 회원정보수정.
	@RequestMapping(value="/userModifyText", method=RequestMethod.POST)
	public Map<String, String> userModifyCtrl(User user,
			@CookieValue(value="cookieId")Cookie cookie){
		String userId = cookie.getValue();
		
		Map<String, String> check = new HashMap<String, String>();
		int result = userService.modifyUserInfoServ(user, userId);
		
		if(result > 0) check.put("check", "true");
		else check.put("check", "false");
		
		return check;
	}
	
	//일상 > 글등록
	@RequestMapping(value="/addAlbum", method=RequestMethod.POST)
	public Map<String, String> addAlbumCtrl(MultipartHttpServletRequest request){
		String userId = request.getParameter("localUserId");
		Map<String, String> check = new HashMap<String, String>();
		
		int result = userService.addAlbumServ(request, userId);
		
		if(result > 0) check.put("check", "true");
		else check.put("check", "false");
		
		return check;
	}
	
	//일상 > 좋아요
	@RequestMapping(value="/addAlbumGood", method=RequestMethod.POST)
	public Map<String, String> addAlbumGoodCtrl(@RequestParam(value="localUserId")String userId,
			GoodCheck goodCheck,
			@RequestParam(value="albumGood", defaultValue="0")int albumGood){
		/*String userId = cookie.getValue();*/
		Map<String, String> check = new HashMap<String, String>();
		
		int result = userService.addAlbumGoodServ(goodCheck, userId, albumGood);
		
		if(result == 0) check.put("check", "false");
		else check.put("check", "true");
		
		return check;
	}
	
	//일상 > 댓글등록 addAlbumComment
	@RequestMapping(value="/addAlbumComment", method=RequestMethod.POST)
	public Map<String, Object> addAlbumCommentCtrl(@RequestParam(value="localUserId")String userId,
			Comment comment){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		comment.setUserId(userId);
		resultMap = userService.addAlbumCommentServ(comment);
		
		return resultMap;
	}
	
	//일상 > 글삭제
	@RequestMapping(value="/removeAlbum", method=RequestMethod.POST)
	public Map<String, String> removeAlbumCtrl(@RequestParam(value="localUserId")String userId,
			@RequestParam(value="albumNo")int albumNo){
		Map<String, String> resultMap = userService.removeAlbumByAlbumNo(albumNo);
		return resultMap;
	}
	
	//일상 > 글수정
	@RequestMapping(value="/modifyAlbum", method=RequestMethod.POST)
	public Map<String, String> modifyAlbumCtrl(Album album){
		Map<String, String> resultMap = userService.modifyAlbumServ(album);
		return resultMap;
	}
	
	//공지 > 글삭제
	@RequestMapping(value="/deleteNotice", method=RequestMethod.POST)
	public Map<String, String> deleteNoticeCtrl(@RequestParam(value="noNum")int noNum){
		Map<String, String> resultMap = userService.removeNoticeServ(noNum);
		return resultMap;
	}
	
	//공지 > 글수정 > 수정할 글조회
	@RequestMapping(value="/readNoticeForModify", method=RequestMethod.POST)
	public NoticeView readNoticeForModifyCtrl(@RequestParam(value="noNum")int noNum,
			@RequestParam(value="noType")int noType){
		NoticeView noticeView = userService.readNoticeByTypeServ(noNum, noType);
		return noticeView;
	}
	
	//공지 > 글수정 > 수정할 글조회
	@RequestMapping(value="/modifyNotice", method=RequestMethod.POST)
	public Map<String, String> modifyNoticeCtrl(NoticeView noticeView){
		System.out.println(noticeView);
		Map<String, String> resultMap = userService.modifyNoticeByTypeServ(noticeView);
		return resultMap;
	}
	
	//일상 > 등록자이름으로 해당 앨범목록검색
	@RequestMapping(value="/searchAlbumByUser", method=RequestMethod.POST)
	public List<Album> searchAlbumByUserCtrl(@RequestParam(value="userName")String userName){
		List<Album> albumList = userService.readAlbumByUserNameServ(userName);
		return albumList;
	}
	
	//포토 > 댓글등록 addPhotoComment
	@RequestMapping(value="/addPhotoComment", method=RequestMethod.POST)
	public Map<String, Object> addPhotoCommentCtrl(@RequestParam(value="localUserId")String userId,
			Comment comment){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		comment.setUserId(userId);
		System.out.println(comment);
		resultMap = userService.addAlbumCommentServ(comment);
		
		return resultMap;
	}
	
	//포토 좋아요++ addPhotoGood
	@RequestMapping(value="/addPhotoGood", method=RequestMethod.POST)
	public Map<String, String> addPhotoGoodCtrl(@RequestParam(value="localUserId")String userId,
			GoodCheck goodCheck,
			@RequestParam(value="photoGoods", defaultValue="0")int photoGoods){
		/*System.out.println("좋아요 체크 컨트롤러~!!");
		System.out.println("값확인 : "+photoGoods);*/
		
		Map<String, String> check = new HashMap<String, String>();
		
		int result = userService.addPhotoGoodServ(goodCheck, userId, photoGoods);
		
		if(result == 0) check.put("check", "false");
		else check.put("check", "true");
		
		return check;
	}
	
	//일상 > 댓글삭제 removeComment
	@RequestMapping(value="/removeComment", method=RequestMethod.POST)
	public Map<String, String> removeCommentCtrl(@RequestParam(value="comNum")int comNum){
		Map<String, String> check = userService.removeCommentByComNumServ(comNum);
		return check;
	}
	
	//공지 - 참여자목록 조회 readJoinUserList
	@RequestMapping(value="/readJoinUserList", method=RequestMethod.POST)
	public List<User> readJoinUserListCtrl(@RequestParam(value="noNum")int noNum){
		List<User> userList = userService.readUserByEventJoinServ(noNum);
		return userList;
	}
	
	//포토 - 사진확대
	@RequestMapping(value="/readPhotoBig", method=RequestMethod.POST)
	public UploadFileDTO readPhotoBigCtrl(@RequestParam(value="fileNo")int fileNo,
			@RequestParam(value="photoType")int photoType){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		UploadFileDTO uploadFileDto = userService.readPhotoBiggerServ(fileNo);
		UploadFileDTO photo = userService.readPhotoCommentByfileNoServ(photoType, uploadFileDto);
		
		return photo;
	}
	
	// 포토 - 사진삭제 removePhoto
	@RequestMapping(value="/removePhoto", method=RequestMethod.POST)
	public Map<String, String> removePhotoCtrl(@RequestParam(value="fileNo")int fileNo,
			@RequestParam(value="photoType")int photoType){
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("fileNo", fileNo);
		params.put("photoType",photoType);
		Map<String,String> resultMap = userService.removePhotoAndCommentServ(params);
		
		return resultMap;
	}
	
	//문자 > 개인별 상세발송내역 성공여부 체크 mmsSuccessList
	@RequestMapping(value="/mmsSuccessList", method=RequestMethod.POST)
	public List<User> mmsSuccessListCtrl(@RequestParam(value="mmsSendDate")String mmsSendDate){
		List<User> mmsSuccessList = userService.readUserSuccessByDateTimeServ(mmsSendDate);
		return mmsSuccessList;
	}
	
	//imgNameSearch
	@RequestMapping(value="/imgNameSearch", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String,String> imgNameSearchCtrl(@RequestParam(value="userId")String userId){
		System.out.println("외부접속 이미지 확대 값 : "+userId);
		String userImgNew = userService.readUserImgNewServ(userId);
		Map<String, String> map = new HashMap<String,String>();
		map.put("userImgNew", userImgNew);
		return map;
	}
	
	//addPhotoList
	@RequestMapping(value="/addPhotoList", method=RequestMethod.POST)
	public Map<String,Object> addPhotoListCtrl(PhotoList photoList){
		Map<String,Object> map = userService.addPhotoListServ(photoList);
		return map;
	}
	
	//deletePhotoList
	@RequestMapping(value="/deletePhotoList", method=RequestMethod.POST)
	public Map<String,String> deletePhotoListCtrl(@RequestParam(value="shListNo")int shListNo){		
		Map<String, String> map = userService.removePhotoListServ(shListNo);
		return map;
	}
	
	//회원정보검색
	@RequestMapping(value="/readUser", method=RequestMethod.POST)
	public User readUserCtrl(@RequestParam(value="userId")String userId){		
		User user = userService.readUserServ(userId);
		return user;
	}
	
	//modifyUserHp
	@RequestMapping(value="/modifyUserHp", method=RequestMethod.POST)
	public Map<String,String> modifyUserHpCtrl(User user){
		System.out.println("외부접속 값 확인 : "+user);
		Map<String, String> map = userService.modifyUserHpServ(user);
		return map;
	}
	
	//deletePhoto
	@RequestMapping(value="/deletePhoto", method=RequestMethod.POST)
	public Map<String,String> deletePhotoCtrl(@RequestParam(value="fileNo")int fileNo){		
		Map<String, String> map = userService.removePhotoServ(fileNo);
		return map;
	}
	
	//mmsRetry
	@RequestMapping(value="/mmsRetry", method=RequestMethod.POST)
	public Map<String, Object> mmsRetryCtrl(@RequestParam(value="mmsNo")int mmsNo){		
		Map<String, Object> map = userService.sendMmsRetryServ(mmsNo);
		
		return map;
	}
	
	//사진목록 불러오기 List<PhotoList> photoList = userService.readPhotoListServ();
	@RequestMapping(value="/getPhotoList", method= {RequestMethod.GET, RequestMethod.POST})
	public List<PhotoList> getPhotoListCtrl(){	
		System.out.println("외부접속 사진목록 !!");
		List<PhotoList> photoList = userService.readPhotoListServ();
		
		return photoList;
	}
	
	//포토상세보기
	@RequestMapping(value="/photoSangseList", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> photoSangseListCtrl(@RequestParam(value="shListType")int photoType,
			@RequestParam(value="folderName", defaultValue="30th01")String folderName) {
		System.out.println("외부접속 사진목록!");
		Map<String, Object> map = new HashMap<String, Object>();
		if(photoType == 3 || photoType == 7) { //30주년 기념
			List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeAndFolderServ(photoType, folderName);
			List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
			map.put("list", list);
			map.put("folderName", folderName);
		}else {
			List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
			List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
			map.put("list", list);
		}	
		
		return map;
	}
	
	//공지목록 불러오기 
	@RequestMapping(value="/getNoticeList", method= {RequestMethod.GET, RequestMethod.POST})
	public List<NoticeView> getNoticeListCtrl(){	
		System.out.println("외부접속 공지목록 !!");
		List<NoticeView> noticeList = userService.readAllNoticeServ();
		return noticeList;
	}
	
	//일상목록 불러오기 
	@RequestMapping(value="/getAlbumList", method= {RequestMethod.GET, RequestMethod.POST})
	public List<Album> getAlbumListCtrl(){	
		System.out.println("외부접속 일상목록 !!");
		List<Album> albumList = userService.readAlbumAllServ();
		return albumList;
	}
	
	//월별 문자 목록 불러오기 
	@RequestMapping(value="/getMmsList", method= {RequestMethod.GET, RequestMethod.POST})
	public List<Integer> getMmsListCtrl(){	
		System.out.println("외부접속 문자목록 !!");
		List<Integer> mmsCountList = userService.readCountMmsByMonthServ();
		return mmsCountList;
	}
	
	//문자 단체발송 이력 상세조회showMmsList
	@RequestMapping(value="/getMmsDetail", method={RequestMethod.GET, RequestMethod.POST})
	public List<MmsReport> getMmsDetailCtrl(@RequestParam(value="month")String month) {
		String sendDate = null;
		if(Integer.parseInt(month) < 10) {
			sendDate = "20170"+month;
		}else if(Integer.parseInt(month) > 9) {
			sendDate = "2017"+month;
		}
		List<MmsReport> reportList = userService.readReportByMonth(sendDate);
	
		return reportList;
	}
	
	//회비 합계 목록 불러오기 
	@RequestMapping(value="/getSumList", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> getSumListCtrl(){	
		System.out.println("외부접속 합계목록 !!");
		Map<String, Object> resultMap = userService.readUserSumAllServ();
		return resultMap;
	}
	
	//이용 통계 목록 불러오기 
	@RequestMapping(value="/getStatList", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> getStatListCtrl(){	
		System.out.println("외부접속 합계목록 !!");
		Map<String, Object> resultMap = userService.readCountByJoinPhoneGapServ();
		return resultMap;
	}
	
	//이용 통계 상세정보 불러오기 
	@RequestMapping(value="/getStatDetail", method= {RequestMethod.GET, RequestMethod.POST})
	public List<User> getStatDetailCtrl(@RequestParam(value="classNum", defaultValue="1")String classNum){	
		System.out.println("외부접속 합계목록 !!");
		List<User> userList = userService.readUserConnectionServ(classNum);
		return userList;
	}
	
	//개인정보조회 
	@RequestMapping(value="/getMyPage", method= {RequestMethod.GET, RequestMethod.POST})
	public User getMyPageCtrl(@RequestParam(value="userId", defaultValue="0")String userId){	
		System.out.println("외부접속 개인정보 !!"+userId);
		User user = userService.readUserByCookieIdServ(userId);
		return user;
	}
	
	//로그인
	@RequestMapping(value="/login", method= {RequestMethod.GET, RequestMethod.POST})
	public Map<String, Object> loginCtrl(@RequestParam(value="userClass")String userClass,
			@RequestParam(value="userName")String userName, 
			HttpServletResponse response){	
		System.out.println("외부접속 로그인!!");
		Map<String, Object> map = userService.loginServ(userClass, userName);
		
		if(map.get("loginCheck").equals("login")) {
			Cookie cookie = new Cookie("cookieId",((String) map.get("userId")));
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*30);
			
			response.addCookie(cookie);
		}
		return map;
	}
	
	//preViewPhoto
	@RequestMapping(value="/preViewPhoto", method=RequestMethod.POST)
	public UploadFileDTO preViewPhotoCtrl(MultipartHttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		
		UploadFileDTO upload = userService.previewPhotoServ(request);
		
		
		return upload;
	}
	
	//makeCookie
	@RequestMapping(value="/makeCookie", method=RequestMethod.POST)
	public Map<String, Object> makeCookieCtrl(@RequestParam(value="userId")String userId,
			HttpServletResponse response, HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		Cookie cookie = new Cookie("cookieId",((String) map.get("userId")));
		cookie.setPath("/");
		cookie.setMaxAge(60*60*24*30);
		
		response.addCookie(cookie);
		
		map.put("result", "success");
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				System.out.println("쿠키저장 확인 : "+cookies[i].getValue());
			}
		}
		
		
		return map;
	}
	
	//토큰저장
	@RequestMapping(value="/tokenAdd", method=RequestMethod.POST)
	public Map<String, Object> tokenAddCtrl(@RequestParam(value="userId")String userId,
			@RequestParam(value="userToken")String token){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("유저넘버 확인 : "+userId);
		System.out.println("토큰 확인 : "+token);
		
		map = userService.modifyTokenServ(userId, token);
		return map;
	}
	
	//푸쉬발송
	@RequestMapping(value="/pushMsg", method=RequestMethod.POST)
	public Map<String, Object> pushMsgCtrl(@RequestParam(value="msg")String msg,
			@RequestParam(value="badge", defaultValue="0")int badge){
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("푸쉬메세지 확인 : "+msg);
		System.out.println("뱃지카운트 : "+badge);
		map = userService.sendPush(msg, badge);
		return map;
	}
}
