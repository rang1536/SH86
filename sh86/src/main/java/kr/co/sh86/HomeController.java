package kr.co.sh86;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

/**
 * Handles requests for the application home page.
 */
@Controller
@SessionAttributes("sessionId")
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model,
			@RequestParam(value="userId", defaultValue="none") String userId,
			HttpServletResponse response) {
		logger.info("Welcome home! The client locale is {}.", locale);
		/*System.out.println(userId);*/
	
		if(!userId.equals("none")) {
			model.addAttribute("sessionId", userId);
			/*System.out.println("세션값 확인 : "+userId);*/
			
			Cookie cookie = new Cookie("cookieId",userId);
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*30);
			
			response.addCookie(cookie);
		}
		
		return "redirect:userList?userId="+userId;
		
	}
	
}
