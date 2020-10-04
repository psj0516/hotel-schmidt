package exam.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import exam.domain.AttachfileVo;
import exam.mapper.AttachfileMapper;

public class AttachfileDao {
	private static AttachfileDao instance = new AttachfileDao();

	public static AttachfileDao getInstance() {
		return instance;
	}

	private AttachfileDao() {}
	
	// 첨부파일 정보 추가
	public void insert(AttachfileVo vo) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.insert(vo);
		}
	}

	// 첨부파일정보 여러개 추가
	public void insert(List<AttachfileVo> list) {
		for (AttachfileVo vo : list) {
			this.insert(vo);
		}
	}
	
	// 파일 가져오기
	public AttachfileVo getAttachfileByUuid(String uuid) {
		AttachfileVo vo = null;
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			vo = mapper.getAttachfileByUuid(uuid);
		}
		return vo;
	}
	
	// 파일 삭제
	public void deleteAttachfilesByUuids(List<String> uuids) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.deleteAttachfilesByUuids(uuids);
		}
	}
	
	// 파일 가져오기
	public List<AttachfileVo> getAttachfilesByBno(int bno) {
		List<AttachfileVo> list = null;

		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(false)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			list = mapper.getAttachfilesByBno(bno);
		}

		return list;
	}
	
	// 게시글 삭제
	public void deleteAttachfilesByBno(int bno) {
		try (SqlSession sqlSession = DBManager.getSqlSessionFactory().openSession(true)) {
			AttachfileMapper mapper = sqlSession.getMapper(AttachfileMapper.class);
			mapper.deleteAttachfilesByBno(bno);
		}
	}
}
