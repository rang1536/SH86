package kr.co.sh86.user.domain;

public class PhotoList {
	private int shListNo;
	private String shListSubject;
	private String shListDate;
	private int shListType;
	public int getShListNo() {
		return shListNo;
	}
	public void setShListNo(int shListNo) {
		this.shListNo = shListNo;
	}
	public String getShListSubject() {
		return shListSubject;
	}
	public void setShListSubject(String shListSubject) {
		this.shListSubject = shListSubject;
	}
	public String getShListDate() {
		return shListDate;
	}
	public void setShListDate(String shListDate) {
		this.shListDate = shListDate;
	}
	public int getShListType() {
		return shListType;
	}
	public void setShListType(int shListType) {
		this.shListType = shListType;
	}
	@Override
	public String toString() {
		return "PhotoList [shListNo=" + shListNo + ", shListSubject=" + shListSubject + ", shListDate=" + shListDate
				+ ", shListType=" + shListType + "]";
	}
	
	
}
