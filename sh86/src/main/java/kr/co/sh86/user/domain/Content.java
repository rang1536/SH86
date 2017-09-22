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
	private String coTargetName;
	private String coTargetClass;
	private String coVisitDate;
	private String coVisitHour;
	private String coVisitMinute;
	private String coUserHp;
	
	public String getCoUserHp() {
		return coUserHp;
	}
	public void setCoUserHp(String coUserHp) {
		this.coUserHp = coUserHp;
	}
	public String getCoVisitHour() {
		return coVisitHour;
	}
	public void setCoVisitHour(String coVisitHour) {
		this.coVisitHour = coVisitHour;
	}
	public String getCoVisitMinute() {
		return coVisitMinute;
	}
	public void setCoVisitMinute(String coVisitMinute) {
		this.coVisitMinute = coVisitMinute;
	}
	public String getCoVisitDate() {
		return coVisitDate;
	}
	public void setCoVisitDate(String coVisitDate) {
		this.coVisitDate = coVisitDate;
	}
	public String getCoTargetName() {
		return coTargetName;
	}
	public void setCoTargetName(String coTargetName) {
		this.coTargetName = coTargetName;
	}
	public String getCoTargetClass() {
		return coTargetClass;
	}
	public void setCoTargetClass(String coTargetClass) {
		this.coTargetClass = coTargetClass;
	}
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
				+ ", noNum=" + noNum + ", coTargetName=" + coTargetName + ", coTargetClass=" + coTargetClass
				+ ", coVisitDate=" + coVisitDate + ", coVisitHour=" + coVisitHour + ", coVisitMinute=" + coVisitMinute
				+ ", coUserHp=" + coUserHp + "]";
	}

	
}
