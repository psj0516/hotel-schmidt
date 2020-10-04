package exam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import exam.domain.AttachfileVo;

public interface AttachfileMapper {
	@Insert ("INSERT INTO attachfile (uuid, filename, uploadpath, image, bno) "
			+ "VALUES (#{uuid}, #{filename}, #{uploadpath}, #{image}, #{bno})")
	void insert(AttachfileVo vo);
	
	@Select("SELECT * FROM attachfile WHERE uuid = #{uuid}")
	AttachfileVo getAttachfileByUuid(String uuid);
	
	// 파일 지우기
	void deleteAttachfilesByUuids(@Param("uuids") List<String> uuids);
	
	@Select("SELECT * FROM attachfile WHERE bno = #{bno}")
	List<AttachfileVo> getAttachfilesByBno(int bno);
	
	// 게시글 삭제
	@Delete ("DELETE FROM attachfile WHERE bno=#{bno}")
	void deleteAttachfilesByBno(int bno);
}
