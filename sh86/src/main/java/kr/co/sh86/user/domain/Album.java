package kr.co.sh86.user.domain;

import java.util.List;

public class Album {
	private int albumNo;
	private String albumMsg;
	private String userId;
	private String albumRegDate;
	private String userName;
	private String userHp;
	private int albumGood;
	private String userImgOld;
	private String userImgNew;
	private List<UploadFileDTO> fileList;
	private List<Comment> commentList;
	
	
	public String getUserHp() {
		return userHp;
	}
	public void setUserHp(String userHp) {
		this.userHp = userHp;
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
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	public int getAlbumGood() {
		return albumGood;
	}
	public void setAlbumGood(int albumGood) {
		this.albumGood = albumGood;
	}
	public String getAlbumRegDate() {
		return albumRegDate;
	}
	public void setAlbumRegDate(String albumRegDate) {
		this.albumRegDate = albumRegDate;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public List<UploadFileDTO> getFileList() {
		return fileList;
	}
	public void setFileList(List<UploadFileDTO> fileList) {
		this.fileList = fileList;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getAlbumNo() {
		return albumNo;
	}
	public void setAlbumNo(int albumNo) {
		this.albumNo = albumNo;
	}
	public String getAlbumMsg() {
		return albumMsg;
	}
	public void setAlbumMsg(String albumMsg) {
		this.albumMsg = albumMsg;
	}
	@Override
	public String toString() {
		return "Album [albumNo=" + albumNo + ", albumMsg=" + albumMsg + ", userId=" + userId + ", albumRegDate="
				+ albumRegDate + ", userName=" + userName + ", userHp=" + userHp + ", albumGood=" + albumGood
				+ ", userImgOld=" + userImgOld + ", userImgNew=" + userImgNew + ", fileList=" + fileList
				+ ", commentList=" + commentList + "]";
	}

}
