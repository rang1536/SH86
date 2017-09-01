package kr.co.sh86.user.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.Notice;
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
		System.out.println("레스트컨트롤러~ 유저 검색!");
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 검색키값으로 해당값 조회하여 뷰로 리턴하고 상세입력창 세팅해주기
		System.out.println("넘어온 값확인 : "+key+", "+value);
		List<User> userList = userService.readUserForMmsServ(key, value);
		
		resultMap.put("userList", userList);
		resultMap.put("count", userList.size());
		
		return resultMap;
	}

	//문자 > 회원검색 > 검색된 회원에게 전송하기
	@RequestMapping(value="/mmsSend", method=RequestMethod.POST)
	public Map<String, String> mmsSendCtrl(@RequestParam(value="searchKey", defaultValue="none") String key,
			@RequestParam(value="searchValue", defaultValue="none") String value,
			@RequestParam(value="mmsMsg") String msg,
			@RequestParam(value="sendTel") String sendTel){
		System.out.println("레스트컨트롤러~ 문자발송!");
		Map<String, String> resultMap = new HashMap<String, String>();
		
		// 검색키값으로 해당값 조회하여 뷰로 리턴하고 상세입력창 세팅해주기
		System.out.println("넘어온 값확인 : "+key+", "+value+", "+msg+", "+sendTel);
		int result = userService.sendMmsServ(key, value, msg, sendTel);
		
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
			@RequestParam(value="mmsMsg") String msg,
			@RequestParam(value="sendTel") String sendTel){
		System.out.println("레스트컨트롤러~ 직접입력 문자발송!");
		Map<String, String> resultMap = new HashMap<String, String>();
		
		// 입력받은 번호로 문자발송하기
		int result = userService.sendMmsDirectServ(userHp, msg, sendTel);
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//문자 > 전체발송 > 휴대폰번호가 입력되어진 전체 회원에게 문자발송
	@RequestMapping(value="/mmsSendAll", method=RequestMethod.POST)
	public Map<String, String> mmsSendAllCtrl(@RequestParam(value="mmsMsg") String msg,
			@RequestParam(value="sendTel") String sendTel){
		Map<String, String> resultMap = new HashMap<String, String>();
		
		// 전체회원문자발송
		int result = userService.sendMmsAllServ(msg, sendTel);
		
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
			@RequestParam(value="writerHp") String writerHp,
			@RequestParam(value="sangseAdd") String sangseAdd){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 부의정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userService.addNoticeContentServ(notice, content, writerHp, sangseAdd);
		
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
			@RequestParam(value="writerHp") String writerHp,
			@RequestParam(value="sangseAdd") String sangseAdd){
		
		/* 작성자휴대폰번호는 - 없으므로 인덱스 계산하여 - 삽입해서 써야함. -> DB에 -포함된 핸드폰번호 정보만 저장되있슴.
		 * 상세주소는 컨텐트테이블의 주소정보에 합쳐서 입력하는 걸로 사용해야함.
		 * 공지정보 - 작성자정보를 입력받은 핸드폰번호로 조회하여 아이디, 이름세팅, 입력시간으로 작성일 세팅, 부의정보 입력후 pk값 가져와서 noContentNum세팅
		 * 행사정보 - 공지정보 입력 후 pk값 가져와서 noNum값 세팅*/
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userService.addNoticeEventServ(notice, event, writerHp, sangseAdd);
		
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
			@RequestParam(value="writerHp") String writerHp){
		
		Map<String, String> resultMap = new HashMap<String, String>();
		
		int result = userService.addNoticeServ(notice, writerHp);
		
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		
		return resultMap;
	}
	
	//소식 > 공지목록 > 부의참여체크
	@RequestMapping(value="/joinAdd", method=RequestMethod.POST)
	public Map<String, String> joinAdd(@ModelAttribute(value="sessionId") String sessionId,
			@RequestParam(value="noNum") int noNum,
			@RequestParam(value="joJoinShape")String joJoinShape,
			@RequestParam(value="joDate", defaultValue="none")String joDate,
			@RequestParam(value="joMoney", defaultValue="0")int joMoney){
		System.out.println("세션값확인 : "+sessionId);
		System.out.println("폼 전송값 확인 :"+noNum+","+joJoinShape+","+joDate+","+joMoney);
		
		// 세션아이디값으로 작성자 아이디 넣고 등록일은 현재시간으로 해서 db저장하면됨.
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addJoinCheckServ(noNum, joJoinShape,joDate,joMoney, sessionId);
		if(result > 0) {
			resultMap.put("check", "성공");
		}else {
			resultMap.put("check", "실패");
		}
		return resultMap;
	}
	
	//소식 > 공지목록 > 행사참여체크
	@RequestMapping(value="/joinEventAdd", method=RequestMethod.POST)
	public Map<String, String> joinEventAdd(@ModelAttribute(value="sessionId") String sessionId,
			@RequestParam(value="noNum") int noNum,
			@RequestParam(value="joJoinShape")String joJoinShape,
			@RequestParam(value="payType", defaultValue="none")String payType){
		System.out.println("세션값확인 : "+sessionId);
		System.out.println("폼 전송값 확인 :"+noNum+","+joJoinShape+","+payType);
		
		// 세션아이디값으로 작성자 아이디 넣고 등록일은 현재시간으로 해서 db저장하면됨.
		Map<String, String> resultMap = new HashMap<String, String>();
		int result = userService.addJoinCheckServ(noNum, joJoinShape, payType, sessionId);
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
		int result = userService.addPhotoServ(request);
		
		return null;
	}
}
