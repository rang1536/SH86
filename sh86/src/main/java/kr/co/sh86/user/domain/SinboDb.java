package kr.co.sh86.user.domain;

public class SinboDb {
	private int memId;
	private String company;
	private String dateOfEst;
	private String ceo;
	private String rrn;
	private String address;
	private String branch;
	private String josaja;
	private String hp;
	private String job;
	
	public int getMemId() {
		return memId;
	}
	public void setMemId(int memId) {
		this.memId = memId;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getDateOfEst() {
		return dateOfEst;
	}
	public void setDateOfEst(String dateOfEst) {
		this.dateOfEst = dateOfEst;
	}
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getRrn() {
		return rrn;
	}
	public void setRrn(String rrn) {
		this.rrn = rrn;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getJosaja() {
		return josaja;
	}
	public void setJosaja(String josaja) {
		this.josaja = josaja;
	}
	public String getHp() {
		return hp;
	}
	public void setHp(String hp) {
		this.hp = hp;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	@Override
	public String toString() {
		return "SinboDb [memId=" + memId + ", company=" + company + ", dateOfEst=" + dateOfEst + ", ceo=" + ceo
				+ ", rrn=" + rrn + ", address=" + address + ", branch=" + branch + ", josaja=" + josaja + ", hp=" + hp
				+ ", job=" + job + "]";
	}
	
	
}
