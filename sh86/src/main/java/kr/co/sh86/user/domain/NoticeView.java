package kr.co.sh86.user.domain;

public class NoticeView {
	//공지테이블 -일반포함
	private int noNum;
	private String noSubject;
	private int noContentNum;
	private String noWriter;
	private String noRegDate;
	private String noRegDateAfter;
	private String noImgPass;
	private String noImgName;
	private int noType;
	private String userId;
	private String noContents;
	private int joinCount;
	private int notJoinCount;
	private String noTargetClass;
	private String noTargetName;
	private String noUserHp;
	private String userImgOld;
	private String userImgNew;
	
	//부의 및 행사
	private int coNum;
	private String coPlace;
	private String coHanddate;
	private String coContent;
	private String coUserId;
	private String coPayName;
	private String coPayAccount;
	private String coTargetName;
	private String coTargetClass;
	private String coVisitDate;
	private String coVisitHour;
	private String coVisitMinute;
	private String coUserHp;
	
	private String coEventDate;
	private int coMoney;
	
	
	public String getUserImgOld() {
		return userImgOld;
	}
	public void setUserImgOld(String userImgOld) {
		this.userImgOld = userImgOld;
	}
	public String getUserImgNew() {
		return userImgNew;
	}
	public void setUserImgNew(String userImgNew) {
		this.userImgNew = userImgNew;
	}
	public String getNoUserHp() {
		return noUserHp;
	}
	public void setNoUserHp(String noUserHp) {
		this.noUserHp = noUserHp;
	}
	public String getCoUserHp() {
		return coUserHp;
	}
	public void setCoUserHp(String coUserHp) {
		this.coUserHp = coUserHp;
	}
	public String getNoTargetClass() {
		return noTargetClass;
	}
	public void setNoTargetClass(String noTargetClass) {
		this.noTargetClass = noTargetClass;
	}
	public String getNoTargetName() {
		return noTargetName;
	}
	public void setNoTargetName(String noTargetName) {
		this.noTargetName = noTargetName;
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
	public String getCoVisitDate() {
		return coVisitDate;
	}
	public void setCoVisitDate(String coVisitDate) {
		this.coVisitDate = coVisitDate;
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
	public int getJoinCount() {
		return joinCount;
	}
	public void setJoinCount(int joinCount) {
		this.joinCount = joinCount;
	}
	public int getNotJoinCount() {
		return notJoinCount;
	}
	public void setNotJoinCount(int notJoinCount) {
		this.notJoinCount = notJoinCount;
	}
	public String getNoRegDateAfter() {
		return noRegDateAfter;
	}
	public void setNoRegDateAfter(String noRegDateAfter) {
		this.noRegDateAfter = noRegDateAfter;
	}
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
				+ ", noWriter=" + noWriter + ", noRegDate=" + noRegDate + ", noRegDateAfter=" + noRegDateAfter
				+ ", noImgPass=" + noImgPass + ", noImgName=" + noImgName + ", noType=" + noType + ", userId=" + userId
				+ ", noContents=" + noContents + ", joinCount=" + joinCount + ", notJoinCount=" + notJoinCount
				+ ", noTargetClass=" + noTargetClass + ", noTargetName=" + noTargetName + ", noUserHp=" + noUserHp
				+ ", userImgOld=" + userImgOld + ", userImgNew=" + userImgNew + ", coNum=" + coNum + ", coPlace="
				+ coPlace + ", coHanddate=" + coHanddate + ", coContent=" + coContent + ", coUserId=" + coUserId
				+ ", coPayName=" + coPayName + ", coPayAccount=" + coPayAccount + ", coTargetName=" + coTargetName
				+ ", coTargetClass=" + coTargetClass + ", coVisitDate=" + coVisitDate + ", coVisitHour=" + coVisitHour
				+ ", coVisitMinute=" + coVisitMinute + ", coUserHp=" + coUserHp + ", coEventDate=" + coEventDate
				+ ", coMoney=" + coMoney + "]";
	}
	
	
}
