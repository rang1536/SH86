package kr.co.sh86.user.domain;

public class Mms {
	private int msgId;
	private String userId;
	private int scheduleType;
	private String subject;
	private String nowDate;
	private String sendDate;
	private String callback;
	private int destCount;
	private String destInfo;
	private String mmsMsg;
	private String reserved1;
	private String reserved2;
	
	public int getMsgId() {
		return msgId;
	}
	public void setMsgId(int msgId) {
		this.msgId = msgId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getScheduleType() {
		return scheduleType;
	}
	public void setScheduleType(int scheduleType) {
		this.scheduleType = scheduleType;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getNowDate() {
		return nowDate;
	}
	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getCallback() {
		return callback;
	}
	public void setCallback(String callback) {
		this.callback = callback;
	}
	public int getDestCount() {
		return destCount;
	}
	public void setDestCount(int destCount) {
		this.destCount = destCount;
	}
	public String getDestInfo() {
		return destInfo;
	}
	public void setDestInfo(String destInfo) {
		this.destInfo = destInfo;
	}
	public String getMmsMsg() {
		return mmsMsg;
	}
	public void setMmsMsg(String mmsMsg) {
		this.mmsMsg = mmsMsg;
	}
	public String getReserved1() {
		return reserved1;
	}
	public void setReserved1(String reserved1) {
		this.reserved1 = reserved1;
	}
	public String getReserved2() {
		return reserved2;
	}
	public void setReserved2(String reserved2) {
		this.reserved2 = reserved2;
	}
	@Override
	public String toString() {
		return "Mms [msgId=" + msgId + ", userId=" + userId + ", scheduleType=" + scheduleType + ", subject=" + subject
				+ ", nowDate=" + nowDate + ", sendDate=" + sendDate + ", callback=" + callback + ", destCount="
				+ destCount + ", destInfo=" + destInfo + ", mmsMsg=" + mmsMsg + ", reserved1=" + reserved1
				+ ", reserved2=" + reserved2 + "]";
	}
	
	
	
}
