package kr.co.sh86.user.domain;

public class NoticeView {
	//공지테이블 -일반포함
	private int noNum;
	private String noSubject;
	private int noContentNum;
	private String noWriter;
	private String noRegDate;
	private String noImgPass;
	private String noImgName;
	private int noType;
	private String userId;
	private String noContents;
	
	//부의 및 행사
	private int coNum;
	private String coPlace;
	private String coHanddate;
	private String coContent;
	private String coUserId;
	private String coPayName;
	private String coPayAccount;
	
	private String coEventDate;
	private int coMoney;
	
	public int getNoNum() {
		return noNum;
	}
	public void setNoNum(int noNum) {
		this.noNum = noNum;
	}
	public String getNoSubject() {
		return noSubject;
	}
	public void setNoSubject(String noSubject) {
		this.noSubject = noSubject;
	}
	public int getNoContentNum() {
		return noContentNum;
	}
	public void setNoContentNum(int noContentNum) {
		this.noContentNum = noContentNum;
	}
	public String getNoWriter() {
		return noWriter;
	}
	public void setNoWriter(String noWriter) {
		this.noWriter = noWriter;
	}
	public String getNoRegDate() {
		return noRegDate;
	}
	public void setNoRegDate(String noRegDate) {
		this.noRegDate = noRegDate;
	}
	public String getNoImgPass() {
		return noImgPass;
	}
	public void setNoImgPass(String noImgPass) {
		this.noImgPass = noImgPass;
	}
	public String getNoImgName() {
		return noImgName;
	}
	public void setNoImgName(String noImgName) {
		this.noImgName = noImgName;
	}
	public int getNoType() {
		return noType;
	}
	public void setNoType(int noType) {
		this.noType = noType;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getNoContents() {
		return noContents;
	}
	public void setNoContents(String noContents) {
		this.noContents = noContents;
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
	public String getCoEventDate() {
		return coEventDate;
	}
	public void setCoEventDate(String coEventDate) {
		this.coEventDate = coEventDate;
	}
	public int getCoMoney() {
		return coMoney;
	}
	public void setCoMoney(int coMoney) {
		this.coMoney = coMoney;
	}
	@Override
	public String toString() {
		return "NoticeView [noNum=" + noNum + ", noSubject=" + noSubject + ", noContentNum=" + noContentNum
				+ ", noWriter=" + noWriter + ", noRegDate=" + noRegDate + ", noImgPass=" + noImgPass + ", noImgName="
				+ noImgName + ", noType=" + noType + ", userId=" + userId + ", noContents=" + noContents + ", coNum="
				+ coNum + ", coPlace=" + coPlace + ", coHanddate=" + coHanddate + ", coContent=" + coContent
				+ ", coUserId=" + coUserId + ", coPayName=" + coPayName + ", coPayAccount=" + coPayAccount
				+ ", coEventDate=" + coEventDate + ", coMoney=" + coMoney + "]";
	}
		
	
}
