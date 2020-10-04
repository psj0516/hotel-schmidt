package exam.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import exam.domain.ReviewBoardVo;
import exam.mapper.ReviewBoardMapper;

public class ReviewBoardDao {
	private static ReviewBoardDao instance = new ReviewBoardDao();

	public static ReviewBoardDao getInstance() {
		return instance;
	}

	private ReviewBoardDao() {
	}

	// 전체 행 갯수 가져오기
	public int getTotalCount(String category, String search) {
		int count = 0;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			count = mapper.getTotalCount(category, search);
		}
		return count;
	}

	// 글목록 가져오기
	public List<ReviewBoardVo> getBoards(int startRow, int pageSize, String category, String search) {
		List<ReviewBoardVo> list = null;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			list = mapper.getBoards(startRow, pageSize, category, search);
		}

		return list;
	} // getBoards()

	// 게시판 새글번호 생성
	public int getBoardNum() {
		int boardNum = 0;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			boardNum = mapper.getBoardNum();
		}

		return boardNum;
	} // getBoardNum()

	// 조회수 증가
	public void updateReadcount(int num) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			mapper.updateReadcount(num);
		}
	} // updateReadcount()

	// 글 가져오기
	public ReviewBoardVo getBoardByNum(int num) {
		ReviewBoardVo vo = null;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			vo = mapper.getBoardByNum(num);
		}

		return vo;
	} // getBoardByNum

	// 게시글(주) 삽입 insert
	public void insert(ReviewBoardVo vo) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			mapper.insertBoard(vo);
		}
	} // insert()
	
	// 게시글 수정
	public void update(ReviewBoardVo vo) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			mapper.update(vo);
		}
	} // update()
	
	// 게시글 삭제
	public void deleteByNum(int num) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			mapper.deleteByNum(num);
		}
	} // deleteByNum()
	
	// 특정 회원이 쓴 글목록 가져오기
	public List<ReviewBoardVo> getBoardsById(String id) {
		List<ReviewBoardVo> list = null;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			list = mapper.getBoardsById(id);
		}

		return list;
	} // getBoards()
	
	// 답글 삽입
	public void replyInsert(ReviewBoardVo vo) {
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true);
		try {
			ReviewBoardMapper mapper = sqlSession.getMapper(ReviewBoardMapper.class);
			
			mapper.updateReSeqByReRef(vo.getReRef(), vo.getReSeq());
			
			// 새글번호 구하기
			int num = mapper.getBoardNum();
			
			vo.setNum(num);
			vo.setReLev(vo.getReLev()+1);
			vo.setReSeq(vo.getReSeq()+1);
			vo.setReadCount(0);
			
			mapper.insertBoard(vo);			
			sqlSession.commit();
		} catch (Exception e) {
			e.printStackTrace();
			sqlSession.rollback();
		} finally {
			sqlSession.close();
		}
	} // replyInsert()
	
	
//	private void insertDummyRows(int count, int month, int day) {
//		
//	    
//		for (int i=1; i<=count; i++) {
//			ReviewBoardVo vo = new ReviewBoardVo();
//			Random ran = new Random();
//			int ranNum = ran.nextInt(50) + 1;
//			if (ranNum < 10) {
//				String strRanNum = "0" + String.valueOf(ranNum);
//				vo.setName("회원" + strRanNum);
//				vo.setId("member" + strRanNum);
//			} else {
//				String strRanNum = String.valueOf(ranNum);
//				vo.setName("회원" + strRanNum);
//				vo.setId("member" + strRanNum);
//			}
//			
//			int num = getBoardNum();
//			int ranM = ran.nextInt(60);
//			int ranS = ran.nextInt(60);
//			
//			vo.setNum(num);
//			vo.setPasswd("1234");
//			vo.setSubject(num + "번 샘플 게시글");
//			vo.setContent(num + "번 게시글\n내용입니다. ");
//			vo.setReadCount(0);
//			vo.setRegDate(LocalDateTime.of(2020, month, day, 0+i, ranM, ranS));
//			vo.setReRef(num);
//			vo.setReLev(0);
//			vo.setReSeq(0);
//			
//			insert(vo);
//		}
//	}
//	
//	public static void main(String[] args) {
//		ReviewBoardDao dao = ReviewBoardDao.getInstance();
//		for (int i = 1; i<=20; i++) {
//			dao.insertDummyRows(1, 6, 5+i);
//		}
//	}
	
}