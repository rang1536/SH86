package kr.co.sh86.user.domain;

public class MmsStat {
	private String sendDate;
	private String msgId;
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getMsgId() {
		return msgId;
	}
	public void setMsgId(String msgId) {
		this.msgId = msgId;
	}
	@Override
	public String toString() {
		return "MmsStat [sendDate=" + sendDate + ", msgId=" + msgId + "]";
	}
	
	
}
