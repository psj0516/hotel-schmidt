package exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import exam.domain.MemberVo;

public interface MemberMapper {
	
	// 회원가입
	int insert(MemberVo vo);
	
	// 아이디 중복체크
	@Select ("SELECT COUNT(*) FROM member WHERE id = #{id}")
	int countMembeById(String id);
	
	// 로그인
	@Select ("SELECT passwd FROM member WHERE id = #{id}")
	String getPasswdById(String id);
	
	@Select("SELECT name FROM member WHERE id = #{id}")
	String getNameById(String id);
	
	// 멤버 수 가져오기
	@Select("SELECT count(*) FROM member ")
	int getTotalCount();
	
	// 멤버 목록 가져오기
	@Select ("SELECT * FROM member LIMIT #{startRow}, #{pageSize}")
	List<MemberVo> getMembers(@Param("startRow") int startRow, @Param("pageSize") int pageSize);
	
	// 특정 멤버 정보 가져오기
	@Select ("SELECT * FROM member WHERE id = #{id}")
	MemberVo getMemberById(String id);
	
	// 멤버 정보 수정하기
	int update(MemberVo vo);
	
	// 멤버 정보 삭제하기
	@Delete ("DELETE FROM member WHERE id = #{id}")
	int deleteById(String id);
}
