package kr.co.sh86.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.Mms;
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.Sinbo;
import kr.co.sh86.user.domain.SinboDb;
import kr.co.sh86.user.domain.User;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 주소 분할을 위한 주소와 회원아이디 조회
	public List<User> selectAddAll(){
		return sqlSession.selectList("UserDao.selectAddAll");
	}

	// 풀주소로 분할된 도이름, 시이름 수정하기
	public int updateDoAndCity(User user) {
		return sqlSession.update("UserDao.updateDoAndCity", user);
	}
	
	// 모든 회원조회
	public List<User> selectAllUser(){
		return sqlSession.selectList("UserDao.selectAllUser");
	}
	
	//신보
	public List<SinboDb> selectSinboRes(){
		return sqlSession.selectList("UserDao.selectSinboRes");
	}
	
	public Sinbo selectSinbo(int memId){
		return sqlSession.selectOne("UserDao.selectSinbo", memId);
	}
	
	//신보 업데이트
	public int updateSinbo(Sinbo sinbo) {
		return sqlSession.update("UserDao.updateSinbo", sinbo);
	}
	
	//문자 - 수신자 검색
	public List<User> selectUserForMms(Map<String,String> params){
		return sqlSession.selectList("UserDao.selectUserForMms", params);
	}
	
	//문자 - 전체 수신자 검색
	public List<User> selectAllUserForMms(){
		return sqlSession.selectList("UserDao.selectAllUserForMms");
	}
	//문자 - 발송
	public int sendMmsToSelected(Mms mms) {
		return sqlSession.insert("UserDao.sendMmsToSelected", mms);
	}
	
	//공지 > 부의등록 > 작성자정보조회
	public User selectWriter(String writerHp) {
		return sqlSession.selectOne("UserDao.selectWriter", writerHp);
	}
	
	//공지 > 부의등록 > 공지등록
	public int insertNotice(Notice notice) {
		return sqlSession.insert("UserDao.insertNotice", notice);
	}
	
	//공지 > 부의등록 > 컨텐트등록
	public int insertContent(Content content) {
		return sqlSession.insert("UserDao.insertContent", content);
	}
	
	//공지 > 부의등록 > 컨텐트등록 후 공지테이블 컨텐트넘버 수정
	public int updateNoticeContentNum(Notice notice) {
		return sqlSession.update("UserDao.updateNoticeContentNum", notice);
	}
	
	//공지 > 부의등록 > 행사등록
	public int insertEvent(Event event) {
		return sqlSession.insert("UserDao.insertEvent", event);
	}
	
	//공지목록 > 모든공지사항 목록
	public List<NoticeView> selectAllNotice(){
		return sqlSession.selectList("UserDao.selectAllNotice");
	}
	
	//공지목록 > 조회된 공지사항 타입에 따라 상세내용조회.
	public NoticeView selectNoticeContent(int noContentNum){
		return sqlSession.selectOne("UserDao.selectNoticeContent", noContentNum);
	}
	
	//공지목록 > 조회된 공지사항 타입에 따라 상세내용조회.
	public NoticeView selectNoticeEvent(int noContentNum){
		return sqlSession.selectOne("UserDao.selectNoticeEvent", noContentNum);
	}
	
	//공지목록 > 조회된 공지사항 타입에 따라 상세내용조회.
	public NoticeView selectNoticeEventForJoin(int noNum){
		return sqlSession.selectOne("UserDao.selectNoticeEventForJoin", noNum);
	}
	//공지목록 > 참여체크 입력.
	public int insertJoin(Join join){
		return sqlSession.insert("UserDao.insertJoin", join);
	}
	
	//신보마지막문자
	public List<Sinbo> sinboLast(){
		return sqlSession.selectList("UserDao.sinboLast");
	}
	
	//졸업사진업로드 > 회원번호조회
	public List<User> selectUserIdAll(){
		return sqlSession.selectList("UserDao.selectUserIdAll");
	}
	
	//졸업사진업로드 > 이미지명 수정.
	public int updateOldImg(User user) {
		return sqlSession.update("UserDao.updateOldImg", user);
	}
	
	//회원 접속 카운팅 > 현재카운팅 검색
	public User selectUserById(String userId) {
		return sqlSession.selectOne("UserDao.selectUserById", userId);
	}
	
	//회원접속 카운팅 > 현재카운팅+1로 수정
	public int updateUserConnection(User user) {
		return sqlSession.update("UserDao.updateUserConnection", user);
	}
	
	//휴대폰보유 회원 카운팅
	public int selectCountByHp(String num) {
		return sqlSession.selectOne("UserDao.selectCountByHp", num);
	}
	
	//1번이라도 접속했던 유저카운트
	public int selectCountByJoin(String num) {
		return sqlSession.selectOne("UserDao.selectCountByJoin", num);
	}
	
	//친구 - 회원조회(이름)
	public List<User> selectUserByUserName(String userName){
		return sqlSession.selectList("UserDao.selectUserByUserName", userName);
	}
	
	//마이페이지 - 개인정보조회
	public User selectUserByCookieId(String userId) {
		return sqlSession.selectOne("UserDao.selectUserByCookieId",userId);
	}
	
	//마이페이지 - 새로운사진등록
	public int updateUserImgNew(User user) {
		return sqlSession.update("UserDao.updateUserImgNew", user);
	}
	
	//마이페이지 - 새로운사진등록
	public int updateUserInfo(User user) {
		return sqlSession.update("UserDao.updateUserInfo", user);
	}
}
