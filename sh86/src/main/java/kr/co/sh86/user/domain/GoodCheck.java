package kr.co.sh86.user.domain;

public class GoodCheck {
	private int goodNum;
	private String userId;
	private int albumNo;
	private int fileNo;
	
	
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}
	public int getGoodNum() {
		return goodNum;
	}
	public void setGoodNum(int goodNum) {
		this.goodNum = goodNum;
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
	@Override
	public String toString() {
		return "GoodCheck [goodNum=" + goodNum + ", userId=" + userId + ", albumNo=" + albumNo + ", fileNo=" + fileNo
				+ "]";
	}
	
	
}
