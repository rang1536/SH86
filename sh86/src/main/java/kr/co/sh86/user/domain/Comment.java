package kr.co.sh86.user.domain;

public class Comment {
	private int comNum;
	private String comContent;
	private String comRegDate;
	private String userId;
	private int noNum;
	private int albumNo;
	private String userImgNew;
	private String userImgOld;
	private String userName;
	private int photoType;
	private int fileNo;
	
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getPhotoType() {
		return photoType;
	}
	public void setPhotoType(int photoType) {
		this.photoType = photoType;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserImgNew() {
		return userImgNew;
	}
	public void setUserImgNew(String userImgNew) {
		this.userImgNew = userImgNew;
	}
	public String getUserImgOld() {
		return userImgOld;
	}
	public void setUserImgOld(String userImgOld) {
		this.userImgOld = userImgOld;
	}
	public int getComNum() {
		return comNum;
	}
	public void setComNum(int comNum) {
		this.comNum = comNum;
	}
	public String getComContent() {
		return comContent;
	}
	public void setComContent(String comContent) {
		this.comContent = comContent;
	}
	public String getComRegDate() {
		return comRegDate;
	}
	public void setComRegDate(String comRegDate) {
		this.comRegDate = comRegDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getNoNum() {
		return noNum;
	}
	public void setNoNum(int noNum) {
		this.noNum = noNum;
	}
	public int getAlbumNo() {
		return albumNo;
	}
	public void setAlbumNo(int albumNo) {
		this.albumNo = albumNo;
	}
	@Override
	public String toString() {
		return "Comment [comNum=" + comNum + ", comContent=" + comContent + ", comRegDate=" + comRegDate + ", userId="
				+ userId + ", noNum=" + noNum + ", albumNo=" + albumNo + ", userImgNew=" + userImgNew + ", userImgOld="
				+ userImgOld + ", userName=" + userName + ", photoType=" + photoType + "]";
	}
	
}
