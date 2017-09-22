package kr.co.sh86.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class UtilDate {
	public static List<String> getDateList(String startDate, String endDate, int day) {
		List<String> dateList = new ArrayList<String>();
		if(day==1||day==0){
			day = 0;
		}else{
			day = day-1;
		}
		int date_cnt = getDiffDay(startDate, endDate);
		date_cnt -= day;
		for (int i = 0; i < date_cnt+1; i++) {
			dateList.add(getAfterDate(startDate, i));
		}
		return dateList;
	}

	/**
	 * 두 날짜의 차이를 리턴한다.
	 * 
	 * @param startDate
	 *            yyy-MM-dd
	 * @param endDate
	 *            yyy-MM-dd
	 * @return 두날짜의 차이
	 */
	public static int getDiffDay(String startDate, String endDate) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date sDate;
		Date eDate;
		try {
			sDate = sdf.parse(startDate);
			eDate = sdf.parse(endDate);
			return (int) ((eDate.getTime() - sDate.getTime()) / 1000 / 60 / 60 / 24);
		} catch (Exception e) {
			return 0;
		}
	}

	// 20일 후 날짜 구하기
	public String getNextTwenty() {
		Calendar cal = Calendar.getInstance();
		Date date = new Date();
		cal.setTime(date);

		cal.add(Calendar.DATE, 20);

		return (new SimpleDateFormat("yyyy-MM-dd")).format(cal.getTime());
	}

	/**
	 * 입력받은 날짜에 해달 일수를 증가한다.
	 * 
	 * @param str
	 *            yyyy-MM-dd 형식
	 * @param i
	 *            증가시킬 날
	 * @return yyyy-MM-dd 증가된 날짜
	 * @throws Exception
	 */
	public static String getAfterDate(String str, int i) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date sDate;
		String year =null;
		String month =null;
		String date =null;
		try {
			sDate = (java.util.Date) formatter.parse(str);
			java.util.Calendar cal = java.util.Calendar.getInstance();
			cal.setTime(sDate);
			cal.add(Calendar.DATE, i);
			year = Integer.toString(cal.get(Calendar.YEAR));
			month = cal.get(Calendar.MONTH) < 9 ? "0" + Integer.toString(cal.get(Calendar.MONTH) + 1)
					: Integer.toString(cal.get(Calendar.MONTH) + 1);
			;
			date = cal.get(Calendar.DAY_OF_MONTH) < 10 ? "0" + Integer.toString(cal.get(Calendar.DAY_OF_MONTH))
					: Integer.toString(cal.get(Calendar.DAY_OF_MONTH));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return year + "-" + month + "-" + date;
	}
	
	// 오늘 날짜 리턴
	public String getCurrentDate() {
		return (new SimpleDateFormat("yyyy-MM-dd")).format(new Date());
	}
	
	// 오늘 날짜 리턴
	public String getNowDate() {
		return (new SimpleDateFormat("MM-dd")).format(new Date());
	}
	
	// 오늘 날짜+시간 리턴
	public String getCurrentDateTime() {

		return (new SimpleDateFormat("yyyyMMddHHmm")).format(new Date());
	}
	
	// 현재 시간 리턴
	public String getCurrentTime() {

		return (new SimpleDateFormat("HH")).format(new Date());
	}
	
	// 날짜 비교
	public int compareDate(String date1, String date2){
		// compare값이 0보다 크면 date1이 더 크고 , 0보다 작으면 date2가 크다. 0이면 같은 날짜
		int compare = date1.compareTo(date2);
		
		return compare;
	}
	
	// 시간 및 휴일 체크 (true : 휴일 및 6시 이후 , false : 평일 및 6시 이전)
	/*public boolean checkDate(){
		boolean check = true;
		HolidayCheck holidayCheck = new HolidayCheck();
		String date = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String day = holidayCheck.isHoliday(date);
		//System.out.println("day : "+ day);
		if(day.equals("weekday")){
			String time = new SimpleDateFormat("HH").format(new Date());
			int hour = Integer.parseInt(time);
			//System.out.println("time : "+ time);
			if(hour>=18){
				check = false;
			}
		}else{
			check = false;
		}
		return check;
	}*/
	
	public int getDayDate(String date){
		//String day = "";
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date nDate;
        int dayNum = 0;
		try {
			nDate = dateFormat.parse(date);
			Calendar cal = Calendar.getInstance();
	        cal.setTime(nDate);
	        dayNum = cal.get(Calendar.DAY_OF_WEEK);
	        /*switch (dayNum) {
	        case 1:
	            day = "일";
	            break;
	        case 2:
	            day = "월";
	            break;
	        case 3:
	            day = "화";
	            break;
	        case 4:
	            day = "수";
	            break;
	        case 5:
	            day = "목";
	            break;
	        case 6:
	            day = "금";
	            break;
	        case 7:
	            day = "토";
	            break;
	 
	        }*/
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return dayNum;
	}
}
