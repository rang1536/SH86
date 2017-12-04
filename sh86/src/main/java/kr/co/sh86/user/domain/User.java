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
	private int userJoinCheck; //접속체크
	private String userBirthType;
	private String userBirth;
	private String userLastDate;//최근접속일
	private int userDues2017;
	private int user30th;
	private int user30thKibu;
	private String userBirthMonth;
	private String userBirthDay;
	private String joJoinShape;
	private String userSangseAdd;
	private String destName;
	private String phoneNumber;
	private int result;
	private String sendDate;
	
	
	
	public String getSendDate() {
		return sendDate;
	}
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	public String getDestName() {
		return destName;
	}
	public void setDestName(String destName) {
		this.destName = destName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public int getResult() {
		return result;
	}
	public void setResult(int result) {
		this.result = result;
	}
	public String getUserSangseAdd() {
		return userSangseAdd;
	}
	public void setUserSangseAdd(String userSangseAdd) {
		this.userSangseAdd = userSangseAdd;
	}
	public String getJoJoinShape() {
		return joJoinShape;
	}
	public void setJoJoinShape(String joJoinShape) {
		this.joJoinShape = joJoinShape;
	}
	public String getUserBirthMonth() {
		return userBirthMonth;
	}
	public void setUserBirthMonth(String userBirthMonth) {
		this.userBirthMonth = userBirthMonth;
	}
	public String getUserBirthDay() {
		return userBirthDay;
	}
	public void setUserBirthDay(String userBirthDay) {
		this.userBirthDay = userBirthDay;
	}
	public int getUserDues2017() {
		return userDues2017;
	}
	public void setUserDues2017(int userDues2017) {
		this.userDues2017 = userDues2017;
	}
	public int getUser30th() {
		return user30th;
	}
	public void setUser30th(int user30th) {
		this.user30th = user30th;
	}
	public int getUser30thKibu() {
		return user30thKibu;
	}
	public void setUser30thKibu(int user30thKibu) {
		this.user30thKibu = user30thKibu;
	}
	public String getUserLastDate() {
		return userLastDate;
	}
	public void setUserLastDate(String userLastDate) {
		this.userLastDate = userLastDate;
	}
	public String getUserBirthType() {
		return userBirthType;
	}
	public void setUserBirthType(String userBirthType) {
		this.userBirthType = userBirthType;
	}
	public String getUserBirth() {
		return userBirth;
	}
	public void setUserBirth(String userBirth) {
		this.userBirth = userBirth;
	}
	public int getUserJoinCheck() {
		return userJoinCheck;
	}
	public void setUserJoinCheck(int userJoinCheck) {
		this.userJoinCheck = userJoinCheck;
	}
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
				+ ", userImgOld=" + userImgOld + ", userImgNew=" + userImgNew + ", userLevel=" + userLevel
				+ ", userJoinCheck=" + userJoinCheck + ", userBirthType=" + userBirthType + ", userBirth=" + userBirth
				+ ", userLastDate=" + userLastDate + ", userDues2017=" + userDues2017 + ", user30th=" + user30th
				+ ", user30thKibu=" + user30thKibu + ", userBirthMonth=" + userBirthMonth + ", userBirthDay="
				+ userBirthDay + ", joJoinShape=" + joJoinShape + ", userSangseAdd=" + userSangseAdd + ", destName="
				+ destName + ", phoneNumber=" + phoneNumber + ", result=" + result + "]";
	}
	
}
