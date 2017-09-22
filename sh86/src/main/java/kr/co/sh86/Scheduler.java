package kr.co.sh86;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import kr.co.sh86.user.service.UserService;


@Component
public class Scheduler {
	
	@Autowired
	private UserService userService;
	
	// 매일 11시 55분에 생일자 조회하여 앨범등록하는 스케줄러
	@Scheduled(cron = "00 55 23 * * *")
	public void birthDayAddAlbum() {
		try {
			userService.addAlbumSchedulerServ();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
}
