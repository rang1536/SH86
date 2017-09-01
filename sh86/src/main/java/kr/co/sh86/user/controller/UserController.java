package kr.co.sh86.user.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.User;
import kr.co.sh86.user.service.UserService;

@Controller
@SessionAttributes("sessionId")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	//풀주소만 입력된 회원정보 풀주소에서 도,시 이름 분리하여 수정
	@RequestMapping(value="/dbAddDivision", method = RequestMethod.GET)
	public String dbAddDivisionCtrl() {
		userService.createAddServ();
		return "index";
	}
	
	@RequestMapping(value="/userList", method = RequestMethod.GET)
	public String userListCtrl(Model model) {	
		List<User> userList = userService.readAllUser();
		List<NoticeView> noticeList = userService.readAllNoticeServ();
		
		model.addAttribute("userList", userList);
		model.addAttribute("noticeList", noticeList);
		
		return "index";
	}
	
	/*@RequestMapping(value="/photoList", method = RequestMethod.GET)
	public String photoListCtrl() {
		System.out.println("사진목록 컨트롤러~!!");
		
		return "/photo/photo_list";
	}
	
	@RequestMapping(value="/smsSendForm", method = RequestMethod.GET)
	public String smsSendFormCtrl() {
		System.out.println("문자 전송 폼 컨트롤러~!!");
		
		return "/sms/sms_sendForm";
	}
	
	@RequestMapping(value="/noticeList", method = RequestMethod.GET)
	public String noticeListCtrl() {
		System.out.println("공지목록 컨트롤러~!!");
		
		return "/notice/notice_list";
	}*/
	
	@RequestMapping(value="/sinbo", method=RequestMethod.GET)
	public String sinboDb() {
		int result = userService.sinboServ();
		return null;
	}
}
