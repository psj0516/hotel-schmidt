package exam.domain;

import java.time.LocalDateTime;
import java.util.List;

public class ReviewBoardVo {
	private Integer num;
	private String name;
	private String passwd;
	private String subject;
	private String content;
	private Integer readcount;
	private String id;
	private LocalDateTime regDate;
	
    private Integer reRef;
	private Integer reLev;
	private Integer reSeq;
	
	// 첨부파일 정보를 리스트 필드에 설정
	private List<AttachfileVo> attachList;
	
	public Integer getNum() {
		return num;
	}
	public void setNum(Integer num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getReadCount() {
		return readcount;
	}
	public void setReadCount(Integer readCount) {
		this.readcount = readCount;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public LocalDateTime getRegDate() {
		return regDate;
	}
	public void setRegDate(LocalDateTime regDate) {
		this.regDate = regDate;
	}
	public Integer getReRef() {
		return reRef;
	}
	public void setReRef(Integer reRef) {
		this.reRef = reRef;
	}
	public Integer getReLev() {
		return reLev;
	}
	public void setReLev(Integer reLev) {
		this.reLev = reLev;
	}
	public Integer getReSeq() {
		return reSeq;
	}
	public void setReSeq(Integer reSeq) {
		this.reSeq = reSeq;
	}
	public List<AttachfileVo> getAttachList() {
		return attachList;
	}
	public void setAttachList(List<AttachfileVo> attachList) {
		this.attachList = attachList;
	}
	@Override
	public String toString() {
		return "reviewBoardVo [num=" + num + ", name=" + name + ", passwd=" + passwd + ", subject=" + subject
				+ ", content=" + content + ", readCount=" + readcount + ", id=" + id + ", regDate=" + regDate
				+ ", reRef=" + reRef + ", reLev=" + reLev + ", reSeq=" + reSeq + ", attachList=" + attachList + "]";
	}
}
