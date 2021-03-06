package kr.co.sh86.user.domain;

//공지 vo
public class Notice {
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
	private String noTargetName;
	private String noTargetClass;
	private String noUserHp;
	private String userImgOld;
	private String userImgNew;
	
	
	
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
	public String getNoTargetName() {
		return noTargetName;
	}
	public void setNoTargetName(String noTargetName) {
		this.noTargetName = noTargetName;
	}
	public String getNoTargetClass() {
		return noTargetClass;
	}
	public void setNoTargetClass(String noTargetClass) {
		this.noTargetClass = noTargetClass;
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
	@Override
	public String toString() {
		return "Notice [noNum=" + noNum + ", noSubject=" + noSubject + ", noContentNum=" + noContentNum + ", noWriter="
				+ noWriter + ", noRegDate=" + noRegDate + ", noImgPass=" + noImgPass + ", noImgName=" + noImgName
				+ ", noType=" + noType + ", userId=" + userId + ", noContents=" + noContents + ", noTargetName="
				+ noTargetName + ", noTargetClass=" + noTargetClass + ", noUserHp=" + noUserHp + ", userImgOld="
				+ userImgOld + ", userImgNew=" + userImgNew + "]";
	}
	
}
