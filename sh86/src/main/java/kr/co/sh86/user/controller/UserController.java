package kr.co.sh86.user.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import kr.co.sh86.user.domain.Album;
import kr.co.sh86.user.domain.Comment;
import kr.co.sh86.user.domain.MmsReport;
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.PhotoList;
import kr.co.sh86.user.domain.UploadFileDTO;
import kr.co.sh86.user.domain.User;
import kr.co.sh86.user.service.UserService;
import kr.co.sh86.util.UtilDate;

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
	public String userListCtrl(Model model,
			@CookieValue(value="cookieId", required=false)Cookie cookie,
			@RequestParam(value="userId", defaultValue="none")String userId,
			@RequestParam(value="type", defaultValue="none")String type,
			HttpServletResponse response) {	
		if(!userId.equals("none")) {
			System.out.println("쿠키생성?");
			cookie = new Cookie("cookieId",userId);
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*30);
			
			response.addCookie(cookie);
		}
		
		List<User> userList = userService.readAllUser();
		List<NoticeView> noticeList = userService.readAllNoticeServ();
		
		if(cookie != null) {
			int result = userService.modifyJoinCountServ(cookie.getValue());
			if(result > 0) {
				User user = userService.readUserByCookieIdServ(cookie.getValue());
				model.addAttribute("user", user);
			}
		}else if(userId.equals("none")) {
			
		}
		List<Integer> countList = userService.readCountByHpServ(); //핸드폰보유자
		List<Integer> joinCountList = userService.readCountByJoinServ(); //1번이상 접속한 유저수 카운팅
		
		List<Album> albumList = userService.readAlbumAllServ();
		Map<String, Object> resultMap = userService.readUserSumAllServ();
		UtilDate utilDate = new UtilDate();
		List<Integer> mmsCountList = userService.readCountMmsByMonthServ();
		List<PhotoList> photoList = userService.readPhotoListServ();
		
		/*System.out.println("type 확인 : "+type);*/
		if(type.equals("sms")) model.addAttribute("type", type);
		
		model.addAttribute("mmsCountList", mmsCountList);
		model.addAttribute("duesList", resultMap.get("duesList"));
		model.addAttribute("thirtyList", resultMap.get("thirtyList"));
		model.addAttribute("kibuList", resultMap.get("kibuList"));
		model.addAttribute("albumList", albumList);
		model.addAttribute("joinCountList", joinCountList);
		model.addAttribute("countList", countList);
		model.addAttribute("userList", userList);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("photoList", photoList);
		
		String token = "dd6iJ_Bquvc:APA91bHUREMvqR2t7OMYfY0VUavbmpzZM4Dq0lLkTydDWMjHrFWeNoOo-s1F-_ijT_a3PPqNWyGZQm4EovkL_PIuBzCnRb742exNTYdg8WHGJhDXcmKZrxFkmcR86jsxVTykv8i1vXSp"; 
		userService.sendPush2(token);		
		return "index";
	}
	
	@RequestMapping(value="/userListForMms", method = RequestMethod.GET)
	public String userListForMmsCtrl(Model model,
			@CookieValue(value="cookieId")Cookie cookie) {	
		List<User> userList = userService.readAllUser();
		List<NoticeView> noticeList = userService.readAllNoticeServ();
		
		if(cookie != null) {
			User user = userService.readUserByCookieIdServ(cookie.getValue());
			model.addAttribute("user", user);
			
		}
		List<Integer> countList = userService.readCountByHpServ(); //핸드폰보유자
		List<Integer> joinCountList = userService.readCountByJoinServ(); //1번이상 접속한 유저수 카운팅
		
		List<Album> albumList = userService.readAlbumAllServ();
		Map<String, Object> resultMap = userService.readUserSumAllServ();
		UtilDate utilDate = new UtilDate();
		List<Integer> mmsCountList = userService.readCountMmsByMonthServ();
		
		model.addAttribute("type", "sms");
		model.addAttribute("mmsCountList", mmsCountList);
		model.addAttribute("duesList", resultMap.get("duesList"));
		model.addAttribute("thirtyList", resultMap.get("thirtyList"));
		model.addAttribute("kibuList", resultMap.get("kibuList"));
		model.addAttribute("albumList", albumList);
		model.addAttribute("joinCountList", joinCountList);
		model.addAttribute("countList", countList);
		model.addAttribute("userList", userList);
		model.addAttribute("noticeList", noticeList);
		
		return "index";
	}
	
	@RequestMapping(value="/sinbo", method=RequestMethod.GET)
	public String sinboDb() {
		int result = userService.sinboServ();
		return null;
	}
	
	//교가
	@RequestMapping(value="/songList", method=RequestMethod.GET)
	public String songListCtrl(@RequestParam(value="num")String num) {
		String url = "/photo/song";
		return url+num;
	}
	
	//무주2016
	@RequestMapping(value="/muju2016List", method=RequestMethod.GET)
	public String muju2016ListCtrl(Model model) {
		int photoType= 1;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		return "/photo/muju2016";
	}
		
	//30주년준비
	@RequestMapping(value="/before30thList", method=RequestMethod.GET)
	public String before30thListCtrl(Model model) {
		int photoType= 2;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		return "/photo/30thBefore";
	}
	
	//30주년 기념 - after30thList
	@RequestMapping(value="/after30thList", method=RequestMethod.GET)
	public String after30thListCtrl(Model model,
			@RequestParam(value="folderName", defaultValue="30th01")String folderName) {
		int photoType= 3;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeAndFolderServ(photoType, folderName);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		model.addAttribute("folderName", folderName);
		return "/photo/30thAfter";
	}
		
	//임원취임
	@RequestMapping(value="/adminList", method=RequestMethod.GET)
	public String adminListCtrl(Model model) {
		int photoType= 4;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		return "/photo/admin";
	}
	
	//무주동문회 2017
	@RequestMapping(value="/muju2017List", method=RequestMethod.GET)
	public String muju2017ListCtrl(Model model) {
		int photoType= 5;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		return "/photo/muju2017";
	}
	
	//추억 및 졸업앨범 - after30thList
	@RequestMapping(value="/albumList", method=RequestMethod.GET)
	public String albumListCtrl(Model model,
			@RequestParam(value="folderName", defaultValue="school01")String folderName) {
		int photoType= 7;
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeAndFolderServ(photoType, folderName);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		model.addAttribute("photoList", list);
		model.addAttribute("folderName", folderName);
		return "/photo/album";
	}
	
	//신규등록된 포토리스트 - after30thList
	@RequestMapping(value="/photoList", method=RequestMethod.GET)
	public String photoListCtrl(Model model,
			@RequestParam(value="photoType", defaultValue="8")int photoType) {
		List<UploadFileDTO> photoList = userService.readFileInfoByPhotoTypeServ(photoType);
		List<UploadFileDTO> list = userService.readPhotoCommentByPhotoTypeServ(photoType, photoList);
		
		System.out.println("사진타입확인 : "+photoType);
		model.addAttribute("photoList", list);
		model.addAttribute("photoType", photoType);
		
		return "/photo/photo_list";
	}
	
	//관리 - 이용 statDetail
	@RequestMapping(value="/statDetail", method=RequestMethod.GET)
	public String statDetailCtrl(Model model,
			@RequestParam(value="classNum", defaultValue="1")String classNum) {
		List<User> userList = userService.readUserConnectionServ(classNum);
		List<Integer> joinCountList = userService.readCountByJoinServ(); //1번이상 접속한 유저수 카운팅
		
		model.addAttribute("userList", userList);
		model.addAttribute("joinCountList", joinCountList);
		
		return "/admin/stat_list";
	}
	
	//관리 - 회비 duesDetail
	@RequestMapping(value="/duesDetail", method=RequestMethod.GET)
	public String duesDetailCtrl(Model model,
			@RequestParam(value="classNum", defaultValue="1")String classNum) {
		List<User> userList = userService.readUserConnectionServ(classNum);
		Map<String, Object> resultMap = userService.readUserSumAllServ(classNum);
		
		model.addAttribute("userList", userList);
		model.addAttribute("duesSum", resultMap.get("duesSum"));
		model.addAttribute("thirtySum", resultMap.get("thirtySum"));
		model.addAttribute("kibuSum", resultMap.get("kibuSum"));
		
		return "/admin/dues_list";
	}
	
	//문자 단체발송 이력 상세조회showMmsList
	@RequestMapping(value="/showMmsList", method=RequestMethod.GET)
	public String showMmsListCtrl(Model model,
			@RequestParam(value="month")String month) {
		String sendDate = null;
		if(Integer.parseInt(month) < 10) {
			sendDate = "20170"+month;
		}else if(Integer.parseInt(month) > 9) {
			sendDate = "2017"+month;
		}
		List<MmsReport> reportList = userService.readReportByMonth(sendDate);
		
		model.addAttribute("reportList", reportList);
		return "admin/mms_list";
	}
}
