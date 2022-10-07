package board.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;
// board.vo.Board
public class Board {
	private int cnt;
	private int no;
	private int refno;
	private String subject;
	private String content;
	private String writer;
	private int readcnt;
	private Date regdte;
	private Date uptdte;
	private MultipartFile report;
	private String fname;
	private int level;
	
	
	public Board() {
		// TODO Auto-generated constructor stub
	}
	public Board(int no, int refno, String subject, String content, String writer, int readcnt, Date regdte,
			Date uptdte) {
		this.no = no;
		this.refno = refno;
		this.subject = subject;
		this.content = content;
		this.writer = writer;
		this.readcnt = readcnt;
		this.regdte = regdte;
		this.uptdte = uptdte;
	}
	
	
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getRefno() {
		return refno;
	}
	public void setRefno(int refno) {
		this.refno = refno;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public Date getRegdte() {
		return regdte;
	}
	public void setRegdte(Date regdte) {
		this.regdte = regdte;
	}
	public Date getUptdte() {
		return uptdte;
	}
	public void setUptdte(Date uptdte) {
		this.uptdte = uptdte;
	}
	public MultipartFile getReport() {
		return report;
	}
	public void setReport(MultipartFile report) {
		this.report = report;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
}
