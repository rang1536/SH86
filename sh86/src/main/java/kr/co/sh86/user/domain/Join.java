package kr.co.sh86.user.domain;

public class Join {
	private int joNum;
	private String userId;
	private String joDate;
	private String joJoinShape;
	private int joMoney;
	private String joRegDate;
	private int noNum;
	private String joPayType;
	
	
	public String getJoPayType() {
		return joPayType;
	}
	public void setJoPayType(String joPayType) {
		this.joPayType = joPayType;
	}
	public int getJoNum() {
		return joNum;
	}
	public void setJoNum(int joNum) {
		this.joNum = joNum;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getJoDate() {
		return joDate;
	}
	public void setJoDate(String joDate) {
		this.joDate = joDate;
	}
	public String getJoJoinShape() {
		return joJoinShape;
	}
	public void setJoJoinShape(String joJoinShape) {
		this.joJoinShape = joJoinShape;
	}
	public int getJoMoney() {
		return joMoney;
	}
	public void setJoMoney(int joMoney) {
		this.joMoney = joMoney;
	}
	public String getJoRegDate() {
		return joRegDate;
	}
	public void setJoRegDate(String joRegDate) {
		this.joRegDate = joRegDate;
	}
	public int getNoNum() {
		return noNum;
	}
	public void setNoNum(int noNum) {
		this.noNum = noNum;
	}
	@Override
	public String toString() {
		return "Join [joNum=" + joNum + ", userId=" + userId + ", joDate=" + joDate + ", joJoinShape=" + joJoinShape
				+ ", joMoney=" + joMoney + ", joRegDate=" + joRegDate + ", noNum=" + noNum + ", joPayType=" + joPayType
				+ "]";
	}
	
	
}
