package kr.co.sh86.util;

public class UtilMms {
	
	public boolean Send_mms(String type, String subject, String send_date, String sender_name, String callback,
			int dest_count, String dest_info, String sms_msg){
		
		send_date = "to_char(sysdate,'YYYYMMDDHH24MISS')";
		dest_info = "";
		
		return false;
	}
}
