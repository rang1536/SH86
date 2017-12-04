package kr.co.sh86.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CookieValue;
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
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.UploadFileDTO;
import kr.co.sh86.user.domain.User;
import kr.co.sh86.user.service.UserService;

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
	
	//문자 > 직접입력 > 입력받은 번호로 전송하기
	@RequestMapping(value="/mmsSendDirect", method=RequestMethod.POST)
	public Map<String, String> mmsSendDirectCtrl(@RequestParam(value="userHp") String userHp,
			@RequestParam(value="mmsMsg") String msg){
		Map<String, String> resultMap = new HashMap<String, String>();
		
		// 입력받은 번호로 문자발송하기
		int result = userService.sendMmsDirectServ(userHp, msg);
		
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
	public Map<String, String> noticeContentAdd(Notice notice, Content content,
			@CookieValue(value="cookieId")Cookie cookie){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 부의정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		
		if(cookie.getValue() == null) {
			result = userService.addNoticeContentServ(notice, content, "632");
		}else {
			result = userService.addNoticeContentServ(notice, content, cookie.getValue());
		}
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지등록 > 행사공지등록
	@RequestMapping(value="/noticeEventAdd", method=RequestMethod.POST)
	public Map<String, String> noticeEventAdd(Notice notice, Event event,
			@CookieValue(value="cookieId")Cookie cookie){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 행사정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		if(cookie.getValue() == null) {
			result = userService.addNoticeEventServ(notice, event, "632");
		}else {
			result = userService.addNoticeEventServ(notice, event, cookie.getValue());
		}
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지등록 > 일반공지등록
	@RequestMapping(value="/noticeAdd", method=RequestMethod.POST)
	public Map<String, String> noticeAdd(Notice notice,
			@CookieValue(value="cookieId")Cookie cookie){
		
		Map<String, String> resultMap = new HashMap<String, String>();
		int result =0;
		if(cookie.getValue() == null) {
			result = userService.addNoticeServ(notice, "632");
		}else {
			result = userService.addNoticeServ(notice, cookie.getValue());
		}
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
	public Map<String, String> joinEventAdd(@CookieValue(value="cookieId")Cookie cookie,
			@RequestParam(value="noNum") int noNum,
			@RequestParam(value="joJoinShape")String joJoinShape){
		// 세션아이디값으로 작성자 아이디 넣고 등록일은 현재시간으로 해서 db저장하면됨.
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addJoinCheckServ(noNum, joJoinShape, cookie.getValue());
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//포토 > 사진등록
	/*@RequestMapping(value="/photoAdd", method=RequestMethod.POST)
	public Map<String, String> photoAddCtrl(MultipartHttpServletRequest request){
		int result = userService.addPhotoServ(request);
		
		return null;
	}*/
	
	//친구 > 회원검색(이름)
	@RequestMapping(value="/searchUserByName", method=RequestMethod.POST)
	public List<User> searchUserByNameCtrl(@RequestParam(value="userName") String userName){
		List<User> userList = userService.readUserByUserNameServ(userName);
		
		return userList;
	}
	
	//친구 > 반별목록검색
	@RequestMapping(value="/searchUserByClass", method=RequestMethod.POST)
	public List<User> searchUserByClassCtrl(@RequestParam(value="classNum") String classNum){
		List<User> userList = userService.readUserByClassServ(classNum);
		
		return userList;
	}
	
	//마이페이지 > 회원정보수정.
	@RequestMapping(value="/userModify", method=RequestMethod.POST)
	public Map<String, String> userModifyCtrl(MultipartHttpServletRequest request,
			@CookieValue(value="cookieId")Cookie cookie){
		String userId = cookie.getValue();
		int result = userService.addUserNewImgServ(request, userId);
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
	public Map<String, String> addAlbumCtrl(MultipartHttpServletRequest request,
			@CookieValue(value="cookieId")Cookie cookie){
		String userId = cookie.getValue();
		Map<String, String> check = new HashMap<String, String>();
		
		int result = userService.addAlbumServ(request, userId);
		
		if(result > 0) check.put("check", "true");
		else check.put("check", "false");
		
		return check;
	}
	
	//일상 > 좋아요
	@RequestMapping(value="/addAlbumGood", method=RequestMethod.POST)
	public Map<String, String> addAlbumGoodCtrl(@CookieValue(value="cookieId")Cookie cookie,
			GoodCheck goodCheck,
			@RequestParam(value="albumGood", defaultValue="0")int albumGood){
		String userId = cookie.getValue();
		Map<String, String> check = new HashMap<String, String>();
		
		int result = userService.addAlbumGoodServ(goodCheck, userId, albumGood);
		
		if(result == 0) check.put("check", "false");
		else check.put("check", "true");
		
		return check;
	}
	
	//일상 > 댓글등록 addAlbumComment
	@RequestMapping(value="/addAlbumComment", method=RequestMethod.POST)
	public Map<String, Object> addAlbumCommentCtrl(@CookieValue(value="cookieId")Cookie cookie,
			Comment comment){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		comment.setUserId(cookie.getValue());
		resultMap = userService.addAlbumCommentServ(comment);
		
		return resultMap;
	}
	
	//일상 > 글삭제
	@RequestMapping(value="/removeAlbum", method=RequestMethod.POST)
	public Map<String, String> removeAlbumCtrl(@CookieValue(value="cookieId")Cookie cookie,
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
	public Map<String, Object> addPhotoCommentCtrl(@CookieValue(value="cookieId")Cookie cookie,
			Comment comment){
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		comment.setUserId(cookie.getValue());
		System.out.println(comment);
		resultMap = userService.addAlbumCommentServ(comment);
		
		return resultMap;
	}
	
	//포토 좋아요++ addPhotoGood
	@RequestMapping(value="/addPhotoGood", method=RequestMethod.POST)
	public Map<String, String> addPhotoGoodCtrl(@CookieValue(value="cookieId")Cookie cookie,
			GoodCheck goodCheck,
			@RequestParam(value="photoGoods", defaultValue="0")int photoGoods){
		/*System.out.println("좋아요 체크 컨트롤러~!!");
		System.out.println("값확인 : "+photoGoods);*/
		String userId = cookie.getValue();
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
	
	
	
}
