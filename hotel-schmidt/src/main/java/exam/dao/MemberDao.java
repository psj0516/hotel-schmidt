package exam.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import exam.domain.MemberVo;
import exam.mapper.MemberMapper;

public class MemberDao {
	private static MemberDao instance = new MemberDao();
	public static MemberDao getInstance() {
		return instance;
	}
	
	private MemberDao() {}
	
	public void insert(MemberVo vo) {
		SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false);
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		
		int rowCount = mapper.insert(vo);
		
		if (rowCount > 0) {
			sqlSession.commit();
		} else {
			sqlSession.rollback();
		}
		sqlSession.close();
	} // insert
	
	// 아이디 중복체크
	public boolean dupIdCheck(String id) {
		boolean isIdDup = false;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			int count = mapper.countMembeById(id);
			if (count == 1) {
				isIdDup = true;
			} else {
				isIdDup = false;
			}
		}
		// sqlSession은 자동으로 finally로 닫힘
		return isIdDup;
	}
	
	// 로그인
	public int userCheck(String id, String passwd) {
		// 0: 틀림, 1: 아이디 비밀번호 일치
		int checkResult = 0;
		SqlSession sqlSession = null;
		
		try {
			sqlSession = DBManager.getSqlSessionFactory().openSession(false);
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			
			String dbPasswd = mapper.getPasswdById(id);
			if (dbPasswd != null) {
				if (dbPasswd.equals(passwd)) {
					checkResult = 1;
				} else { // 패스워드 불일치
					checkResult = 0;
				}
			} else { // 아이디 불일치
				checkResult = 0;
			}
		} finally {
			sqlSession.close();
		}
		return checkResult;
	}
	
	// 해당 id에 대한 이름 가져오기
	public String getNameById(String id) {
		String name = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			name = mapper.getNameById(id);
		}
		
		return name;
	}
	
	// 멤버 수 가져오기
	public int getTotalCount() {
		int count = 0;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			count = mapper.getTotalCount();
		}
		return count;
	}
	
	// 멤버 전체 목록 가져오기
	public List<MemberVo> getMembers(int startRow, int pageSize) {
		List<MemberVo> list = null;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			list = mapper.getMembers(startRow, pageSize);
		} 

		return list;
	} // getMembers()
	
	// 특정 멤버 정보 가져오기
	public MemberVo getMemberById(String id) {
		MemberVo info = null;
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			info = mapper.getMemberById(id);
		} 

		return info;
	} // getMemberById()
	
	// 멤버 정보 수정
	public int update(MemberVo vo) {
		int rowCount = 0;
		
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			rowCount = mapper.update(vo);
		}
		return rowCount;
	} // update()
	
	
	// 멤버 정보 삭제
	public int deleteById(String id) {
		int rowCount = 0;
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			rowCount = mapper.deleteById(id);
		}
		return rowCount;
	}
	
	
//	private void insertDummyRows(int count) {
//		for (int i=1; i<=count; i++) {
//			MemberVo vo = new MemberVo();
//			Random ran = new Random();
//			
//			if (i < 10) {
//				String str = String.valueOf(i);
//				String num = "0"+str;
//				vo.setId("member"+num);
//				vo.setName("회원"+num);
//				vo.setPasswd("1234");
//				vo.setAge(ran.nextInt(60)+6);
//				vo.setEmail("member" + num + "@mm.com");
//				vo.setTel("010-"+"0000-"+num+num);
//				vo.setRegDate(LocalDateTime.now());
//			} else {
//				vo.setId("member"+i);
//				vo.setName("회원"+i);
//				vo.setPasswd("1234");
//				vo.setAge(ran.nextInt(60)+6);
//				vo.setEmail("member" + i + "@mm.com");
//				vo.setTel("010-"+"0000-"+i+i);
//				vo.setRegDate(LocalDateTime.now());
//			}
//		
//			
//			insert(vo);
//		}
//	}
//
//	public static void main(String[] args) {
//		MemberDao dao = MemberDao.getInstance();
//		dao.insertDummyRows(50);
//	}
	
}
