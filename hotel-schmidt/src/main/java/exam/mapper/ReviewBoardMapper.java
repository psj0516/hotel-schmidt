package exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import exam.domain.ReviewBoardVo;

public interface ReviewBoardMapper {

	// 글갯수
	int getTotalCount(@Param("category") String category, @Param("search") String search);

	// 글목록 가져오기
	List<ReviewBoardVo> getBoards(@Param("startRow") int startRow, @Param("pageSize") int pageSize,
			@Param("category") String category, @Param("search") String search);

	// 게시판 새글번호 생성
	@Select("SELECT ifnull(max(num), 0) + 1 AS max_num FROM reviewb ")
	int getBoardNum();

	// 조회수 증가
	void updateReadcount(int num);

	// 글 가져오기 (첨부파일 조인)
	ReviewBoardVo getBoardByNum(int num);

	// 게시글 삽입
	void insertBoard(ReviewBoardVo vo);

	// 게시글 수정
	void update(ReviewBoardVo vo);

	// 게시글 삭제
	@Delete("DELETE FROM reviewb WHERE num = #{num}")
	void deleteByNum(int num);

	// 특정 회원이 쓴 글목록 가져오기
	@Select("SELECT * FROM reviewb WHERE id = #{id} ORDER BY re_ref DESC")
	List<ReviewBoardVo> getBoardsById(String id);

	// 답글 정보
	int updateReSeqByReRef(@Param("reRef") int reRef, @Param("reSeq") int reSeq);
}
