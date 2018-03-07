package kr.co.sh86.user.domain;

import java.util.List;

public class MmsReport {
	private int mmsNo;
	private String mmsSendDate;
	private int mmsTotalCount;
	private int mmsSuccess;
	private String mmsSender;
	private String mmsMsg;
	private int connectCount;
	private List<String> noConnectList;
	
	
	public List<String> getNoConnectList() {
		return noConnectList;
	}
	public void setNoConnectList(List<String> noConnectList) {
		this.noConnectList = noConnectList;
	}
	public int getConnectCount() {
		return connectCount;
	}
	public void setConnectCount(int connectCount) {
		this.connectCount = connectCount;
	}
	public int getMmsNo() {
		return mmsNo;
	}
	public void setMmsNo(int mmsNo) {
		this.mmsNo = mmsNo;
	}
	public String getMmsSendDate() {
		return mmsSendDate;
	}
	public void setMmsSendDate(String mmsSendDate) {
		this.mmsSendDate = mmsSendDate;
	}
	
	public int getMmsTotalCount() {
		return mmsTotalCount;
	}
	public void setMmsTotalCount(int mmsTotalCount) {
		this.mmsTotalCount = mmsTotalCount;
	}
	public int getMmsSuccess() {
		return mmsSuccess;
	}
	public void setMmsSuccess(int mmsSuccess) {
		this.mmsSuccess = mmsSuccess;
	}
	public String getMmsSender() {
		return mmsSender;
	}
	public void setMmsSender(String mmsSender) {
		this.mmsSender = mmsSender;
	}
	public String getMmsMsg() {
		return mmsMsg;
	}
	public void setMmsMsg(String mmsMsg) {
		this.mmsMsg = mmsMsg;
	}
	@Override
	public String toString() {
		return "MmsReport [mmsNo=" + mmsNo + ", mmsSendDate=" + mmsSendDate + ", mmsTotalCount=" + mmsTotalCount
				+ ", mmsSuccess=" + mmsSuccess + ", mmsSender=" + mmsSender + ", mmsMsg=" + mmsMsg + "]";
	}
	
	
}
