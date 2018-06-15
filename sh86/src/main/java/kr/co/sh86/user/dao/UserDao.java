package kr.co.sh86.user.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.sh86.user.domain.Album;
import kr.co.sh86.user.domain.Comment;
import kr.co.sh86.user.domain.Content;
import kr.co.sh86.user.domain.Event;
import kr.co.sh86.user.domain.GoodCheck;
import kr.co.sh86.user.domain.Join;
import kr.co.sh86.user.domain.Mms;
import kr.co.sh86.user.domain.MmsReport;
import kr.co.sh86.user.domain.MmsStat;
import kr.co.sh86.user.domain.Notice;
import kr.co.sh86.user.domain.NoticeView;
import kr.co.sh86.user.domain.PhotoList;
import kr.co.sh86.user.domain.Sinbo;
import kr.co.sh86.user.domain.SinboDb;
import kr.co.sh86.user.domain.UploadFileDTO;
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
	
	//1번이라도 접속했던 유저카운트
	public int selectTotalCountByClass(String num) {
		return sqlSession.selectOne("UserDao.selectTotalCountByClass", num);
	}
		
	//1번이라도 접속했던 유저카운트
	public int selectHpCountByClass(String num) {
		return sqlSession.selectOne("UserDao.selectHpCountByClass", num);
	}
		
	//친구 - 회원조회(이름)
	public List<User> selectUserByUserName(String userName){
		return sqlSession.selectList("UserDao.selectUserByUserName", userName);
	}
	
	//친구 - 회원조회(이름)
	public List<User> selectUserByClass(String classNum){
		return sqlSession.selectList("UserDao.selectUserByClass", classNum);
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
	
	//일상 > 앨범등록
	public int insertAlbum(Album album) {
		return sqlSession.insert("UserDao.insertAlbum", album);
	}
	
	//일상 > 포토등록
	public int insertAlbumPhoto(UploadFileDTO uploadFileDto) {
		return sqlSession.insert("UserDao.insertAlbumPhoto", uploadFileDto);
	}
	
	//일상 > 글조회
	public List<Album> selectAllAlbum(){
		return sqlSession.selectList("UserDao.selectAllAlbum");
	}
	
	//일상 > 글에 딸린 사진조회
	public List<UploadFileDTO> selectPhotoForAlbum(int albumNo){
		return sqlSession.selectList("UserDao.selectPhotoForAlbum", albumNo);
	}
	
	//일상 > 좋아요체크했는지 확인
	public int selectGoodCheckByUser(GoodCheck goodCheck) {
		return sqlSession.selectOne("UserDao.selectGoodCheckByUser", goodCheck);
	}
	
	//일상 > 좋아요 등록
	public int insertGoodByAlbum(GoodCheck goodCheck) {
		return sqlSession.insert("UserDao.insertGoodByAlbum",goodCheck);
	}	
	
	//일상 > 엘범 좋아요 카운팅
	public int updateAlbumGoodCount(Album album) {
		return sqlSession.update("UserDao.updateAlbumGoodCount", album);
	}
	
	//일상 > 댓글등록
	public int insertAlbumComment(Comment comment) {
		return sqlSession.insert("UserDao.insertAlbumComment", comment);
	}
	
	//일상 > 댓글조회
	public List<Comment> selectAllAlbumComment(int albumNo){
		return sqlSession.selectList("UserDao.selectAllAlbumComment", albumNo);
	}
	
	//일상 > 댓글조회
	public Comment selectAlbumComment(int comNum){
		return sqlSession.selectOne("UserDao.selectAlbumComment", comNum);
	}
	
	//일상 > 글삭제
	public int deleteAlbumByAlbumNo(int albumNo) {
		return sqlSession.delete("UserDao.deleteAlbumByAlbumNo", albumNo);
	}
	
	//일상 > 글삭제후 해당 댓글삭제
	public int deleteCommentByAlbumNo(int albumNo) {
		return sqlSession.delete("UserDao.deleteCommentByAlbumNo", albumNo);
	}
	
	//일상 > 글수정
	public int updateAlbum(Album album) {
		return sqlSession.update("UserDao.updateAlbum", album);
	}
	
	//행사공지 > 참여카운트
	public int selectEventJoinCount(Join join) {
		return sqlSession.selectOne("UserDao.selectEventJoinCount",join);
	}
	
	//행사공지 > 불참카운트
	public int selectEventNotJoinCount(Join join) {
		return sqlSession.selectOne("UserDao.selectEventNotJoinCount",join);
	}
	
	//공지 > 글삭제
	public int deleteNotice(int noNum) {
		return sqlSession.delete("UserDao.deleteNotice", noNum);
	}
	
	//공지 > 행사글 조회(수정)
	public NoticeView selectNoticeEventByNoNum(int noNum) {
		return sqlSession.selectOne("UserDao.selectNoticeEventByNoNum", noNum);
	}
	
	//공지 > 부의글 조회(수정)
	public NoticeView selectNoticeContentByNoNum(int noNum) {
		return sqlSession.selectOne("UserDao.selectNoticeContentByNoNum", noNum);
	}
		
	//공지 > 축하글 조회(수정)
	public NoticeView selectNoticeByNoNum(int noNum) {
		return sqlSession.selectOne("UserDao.selectNoticeByNoNum", noNum);
	}
	
	//공지 > 축하등록
	public int insertNoticeCong(Notice notice) {
		return sqlSession.insert("UserDao.insertNoticeCong", notice);
	}
	
	//공지 > 수정
	public int updateNotice(NoticeView noticeView) {
		return sqlSession.update("UserDao.updateNotice", noticeView);
	}
	
	//공지 > 부의수정
	public int updateContentNotice(NoticeView noticeView) {
		return sqlSession.update("UserDao.updateContentNotice", noticeView);
	}
	
	//공지 > 행사수정
	public int updateEventNotice(NoticeView noticeView) {
		return sqlSession.update("UserDao.updateEventNotice", noticeView);
	}
	
	//일상 > 등록자명으로 앨범조회
	public List<Album> selectAlbumByUserName(String userName){
		return sqlSession.selectList("UserDao.selectAlbumByUserName", userName);
	}
	
	//공지 > 공지대상자 조회 > 부의
	public String selectUserInfoByContent(Content content) {
		return sqlSession.selectOne("UserDao.selectUserInfoByContent", content);
	}
	
	//공지 > 공지대상자 조회 > 축하
	public String selectUserInfoByNotice(Notice notice) {
		return sqlSession.selectOne("UserDao.selectUserInfoByNotice",notice);
	}
	
	//포토 > 조회
	public List<UploadFileDTO> selectFileInfoByPhotoType(int photoType){
		return sqlSession.selectList("UserDao.selectFileInfoByPhotoType", photoType);
	}
	
	//포토 > 댓글조회
	public List<Comment> selectPhotoCommentByPhotoType(Map<String, Integer> params){
		return sqlSession.selectList("UserDao.selectPhotoCommentByPhotoType", params);
	}
	
	//포토 > 댓글등록
	public int insertPhotoComment(Comment comment) {
		return sqlSession.insert("UserDao.insertPhotoComment", comment);
	}
	
	//공지 대상자 이미지조회(부의)
	public User selectUserImgByContent(NoticeView noticeView) {
		return sqlSession.selectOne("UserDao.selectUserImgByContent", noticeView);
	}
	
	//공지 대상자 이미지조회(축하)
	public User selectUserImgByCong(NoticeView noticeView) {
		return sqlSession.selectOne("UserDao.selectUserImgByCong", noticeView);
	}
	
	//포토 좋아요 카운트 ++ updatePhotoGoodCount
	public int updatePhotoGoodCount(UploadFileDTO uploadFileDto) {
		return sqlSession.update("UserDao.updatePhotoGoodCount", uploadFileDto);
	}
	
	//포토 > 30주년 기념식
	public List<UploadFileDTO> selectFileInfoByPhotoTypeAndFolder(Map<String, Object> params){
		return sqlSession.selectList("UserDao.selectFileInfoByPhotoTypeAndFolder", params);
	}
	
	//관리 - 이용(접속현황상세)
	public List<User> selectUserConnection(String classNum){
		return sqlSession.selectList("UserDao.selectUserConnection", classNum);
	}
	
	//관리 - 회비2017(합계)
	public int selectUserDuesSum(String classNum) {
		return sqlSession.selectOne("UserDao.selectUserDuesSum", classNum);
	}
	
	//관리 - 30th(합계)
	public int selectUser30thSum(String classNum) {
		return sqlSession.selectOne("UserDao.selectUser30thSum", classNum);
	}
	
	//관리 - 30thKibu(합계)
	public int selectUser30thKibuSum(String classNum) {
		return sqlSession.selectOne("UserDao.selectUser30thKibuSum", classNum);
	}
	
	//스케줄러 > 생일자 검색
	public User selectUserBirthday(String birthDay) {
		return sqlSession.selectOne("UserDao.selectUserBirthday", birthDay);
	}
	
	//일상 > 댓글삭제
	public int deleteCommentByComNum(int comNum) {
		return sqlSession.delete("UserDao.deleteCommentByComNum", comNum);
	}
	
	//공지 > 참여자조회
	public List<User> selectUserByEventJoin(int noNum) {
		return sqlSession.selectList("UserDao.selectUserByEventJoin", noNum);
	}
	
	// 포토 - 사진확대
	public UploadFileDTO selectPhotoBigger(int fileNo) {
		return sqlSession.selectOne("UserDao.selectPhotoBigger", fileNo);
	}
	
	// 포토 - 사진삭제
	public int deletePhoto(int fileNo) {
		return sqlSession.delete("UserDao.deletePhoto", fileNo);
	}
	
	//문자 - 발송자 성공여부 확인을 위한 조회
	public List<User> selectUserMmsTaken(String sendDate){
		return sqlSession.selectList("UserDao.selectUserMmsTaken", sendDate);
	}
	
	//문자 - 월별 건수 조회
	public int selectCountMmsByMonth(String sendDate) {
		return sqlSession.selectOne("UserDao.selectCountMmsByMonth", sendDate);
	}
	
	//문자발송 성공자 - selectUserMmsTakenSuccess
	public int selectUserMmsTakenSuccess(String sendDate){
		return sqlSession.selectOne("UserDao.selectUserMmsTakenSuccess", sendDate);
	}
	
	//문자발송후 기록입력
	public int insertMmsReport(MmsReport mmsReport) {
		return sqlSession.insert("UserDao.insertMmsReport", mmsReport);
	}
	
	//문자발송 이력조회 - 월별
	public List<MmsReport> selectReportByMonth(String sendDate){
		return sqlSession.selectList("UserDao.selectReportByMonth", sendDate);
	}
	
	//문자발송 성공여부조회 - 건별
	public List<User> selectUserSuccessByDateTime(String sendDate){
		return sqlSession.selectList("UserDao.selectUserSuccessByDateTime", sendDate);
	}
	
	//selectUserId
	public User selectUserId(User user) {
		return sqlSession.selectOne("UserDao.selectUserId", user);
	}
	
	//selectNewImgName
	public String selectNewImgName(String userId) {
		return sqlSession.selectOne("UserDao.selectNewImgName", userId);
	}
	
	//selectPhotoList
	public List<PhotoList> selectPhotoList() {
		return sqlSession.selectList("UserDao.selectPhotoList");
	}
	
	// 포토목록 타입 마지막값 조회
	public int selectPhotoListType() {
		return sqlSession.selectOne("UserDao.selectPhotoListType");
	}
	
	//insertPhotoList
	public int insertPhotoList(PhotoList photoList) {
		return sqlSession.insert("UserDao.insertPhotoList", photoList);
	}
	
	//deletePhotoList
	public int deletePhotoList(int shListNo) {
		return sqlSession.delete("UserDao.deletePhotoList", shListNo);
	}
	
	//updateMmsCheck
	public int updateMmsCheck(User user) {
		return sqlSession.update("UserDao.updateMmsCheck", user);
	}
	
	//selectReportByMmsNo
	public MmsReport selectReportByMmsNo(int mmsNo) {
		return sqlSession.selectOne("UserDao.selectReportByMmsNo", mmsNo);
	}
	
	//selectUserByMmsRetry
	public User selectUserByMmsRetry(User user) {
		return sqlSession.selectOne("UserDao.selectUserByMmsRetry",user);
	}
	
	// login-selectLoginInfo
	public List<User> selectLoginInfo(Map<String, Object> params){
		return sqlSession.selectList("UserDao.selectLoginInfo", params);
	}
	
	//토큰저장
	public int updateToken(User user) {
		return sqlSession.update("UserDao.updateToken", user);
	}
	
	//토큰조회
	public List<String> selectTokenAll(){
		return sqlSession.selectList("UserDao.selectTokenAll");
	}
}
