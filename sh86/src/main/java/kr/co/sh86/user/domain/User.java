package kr.co.sh86.user.domain;

//유저테이블 도메인객체
public class User {
	private String userId; 
	private String userName;
	private String userJob;
	private String userCompanyTel; //회사전화
	private String userHp; //휴대폰
	private String userTel; //집전화
	private String userEmail;
	private String userAddress; //풀주소
	private String userDo; //도
	private String userCityName; //시
	private String userDong; //동
	private String userSangse; //상세주소
	private String userImgPass; //이미지경로
	private String userImgOld; //옛사진 파일이름
	private String userImgNew; //최신사진 파일이름
	private String userLevel; //회원등급
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserJob() {
		return userJob;
	}
	public void setUserJob(String userJob) {
		this.userJob = userJob;
	}
	public String getUserCompanyTel() {
		return userCompanyTel;
	}
	public void setUserCompanyTel(String userCompanyTel) {
		this.userCompanyTel = userCompanyTel;
	}
	public String getUserHp() {
		return userHp;
	}
	public void setUserHp(String userHp) {
		this.userHp = userHp;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserAddress() {
		return userAddress;
	}
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}
	public String getUserDo() {
		return userDo;
	}
	public void setUserDo(String userDo) {
		this.userDo = userDo;
	}
	public String getUserCityName() {
		return userCityName;
	}
	public void setUserCityName(String userCityName) {
		this.userCityName = userCityName;
	}
	public String getUserDong() {
		return userDong;
	}
	public void setUserDong(String userDong) {
		this.userDong = userDong;
	}
	public String getUserSangse() {
		return userSangse;
	}
	public void setUserSangse(String userSangse) {
		this.userSangse = userSangse;
	}
	public String getUserImgPass() {
		return userImgPass;
	}
	public void setUserImgPass(String userImgPass) {
		this.userImgPass = userImgPass;
	}
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
	public String getUserLevel() {
		return userLevel;
	}
	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}
	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", userJob=" + userJob + ", userCompanyTel="
				+ userCompanyTel + ", userHp=" + userHp + ", userTel=" + userTel + ", userEmail=" + userEmail
				+ ", userAddress=" + userAddress + ", userDo=" + userDo + ", userCityName=" + userCityName
				+ ", userDong=" + userDong + ", userSangse=" + userSangse + ", userImgPass=" + userImgPass
				+ ", userImgOld=" + userImgOld + ", userImgNew=" + userImgNew + ", userLevel=" + userLevel + "]";
	}
	
	
}
