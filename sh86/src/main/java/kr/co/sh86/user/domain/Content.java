package kr.co.sh86.user.domain;

//부의공지
public class Content {
	private int coNum;
	private String coPlace;
	private String coHanddate;
	private String coContent;
	private String coUserId;
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
	public String getCoHanddate() {
		return coHanddate;
	}
	public void setCoHanddate(String coHanddate) {
		this.coHanddate = coHanddate;
	}
	public String getCoContent() {
		return coContent;
	}
	public void setCoContent(String coContent) {
		this.coContent = coContent;
	}
	public String getCoUserId() {
		return coUserId;
	}
	public void setCoUserId(String coUserId) {
		this.coUserId = coUserId;
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
		return "Content [coNum=" + coNum + ", coPlace=" + coPlace + ", coHanddate=" + coHanddate + ", coContent="
				+ coContent + ", coUserId=" + coUserId + ", coPayName=" + coPayName + ", coPayAccount=" + coPayAccount
				+ ", noNum=" + noNum + "]";
	}
	
	
}
