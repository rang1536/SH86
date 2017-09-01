package kr.co.sh86.user.domain;

public class Event {
	private int coNum;
	private String coPlace;
	private String coEventDate;
	private String coContent;
	private int coMoney;
	private String coPayName;
	private String coPayAccount;
	private int noNum;
	public int getCoNum() {
		return coNum;
	}
	public void setCoNum(int coNum) {
		this.coNum = coNum;
	}
	public String getCoPlace() {
		return coPlace;
	}
	public void setCoPlace(String coPlace) {
		this.coPlace = coPlace;
	}
	public String getCoEventDate() {
		return coEventDate;
	}
	public void setCoEventDate(String coEventDate) {
		this.coEventDate = coEventDate;
	}
	public String getCoContent() {
		return coContent;
	}
	public void setCoContent(String coContent) {
		this.coContent = coContent;
	}
	public int getCoMoney() {
		return coMoney;
	}
	public void setCoMoney(int coMoney) {
		this.coMoney = coMoney;
	}
	public String getCoPayName() {
		return coPayName;
	}
	public void setCoPayName(String coPayName) {
		this.coPayName = coPayName;
	}
	public String getCoPayAccount() {
		return coPayAccount;
	}
	public void setCoPayAccount(String coPayAccount) {
		this.coPayAccount = coPayAccount;
	}
	public int getNoNum() {
		return noNum;
	}
	public void setNoNum(int noNum) {
		this.noNum = noNum;
	}
	@Override
	public String toString() {
		return "Event [coNum=" + coNum + ", coPlace=" + coPlace + ", coEventDate=" + coEventDate + ", coContent="
				+ coContent + ", coMoney=" + coMoney + ", coPayName=" + coPayName + ", coPayAccount=" + coPayAccount
				+ ", noNum=" + noNum + "]";
	}
	
	
}
