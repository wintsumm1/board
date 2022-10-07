package board.service;

import java.io.File;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import board.dao.BoardDao;
import board.vo.Board;
import board.vo.BoardFile;
import board.vo.BoardSch;

@Service
public class BoardService {
	@Autowired(required=false)
	private BoardDao dao;
	
	public List<Board> boardList(BoardSch sch){
		// 1. 전체 데이터 건수 설정
		sch.setCount(	dao.totCnt(sch) );
		System.out.println("총건수:"+sch.getCount());
		// 2. 선언한 한번에 보여줄 데이터 건수(요청값)
		// 		초기화면을 대비하여 한번에 보여줄 데이터건수를 선언
		if(sch.getPageSize()==0) {
			sch.setPageSize(5);
		}
		// 3. 총페이지수 : 데이터건수/한번에 보여주페이지 크기  [1][2][3][4]
		//    ex) 18/5 ==> 3
		//    ex) 18/5.0 (실수) ==> Math.ceil(3.6) : 4.0 ==> 정수형으로 변환하여 4를 총페이지수로 처리
		sch.setPageCount( (int)Math.ceil( sch.getCount() /(double)sch.getPageSize()) );
		// 4. 클릭한 현재 페이지 번호..(요청값) 
		//     1 => 1~5
		//     2 => 6~10
		//     3 => 11~15
		//     4 ==>16~20
		// 	   초기에 화면은  0으로 처리되기에 default 값을 1로 처리한다.
		if(sch.getCurPage()==0) {
			sch.setCurPage(1);
		}
		// 블럭단위로 next를 눌렀을 때, curpage가 증가되는 것을 방지.
		if(sch.getCurPage() > sch.getPageCount()){
			sch.setCurPage(sch.getPageCount());
		}
		// 5. 마지막번호(현재페이지*한번에보여주는페이지건수)
		int end = sch.getCurPage()*sch.getPageSize();
		if(end>sch.getCount()) { // 총데이터 건수보다 크면..
			sch.setEnd(sch.getCount());
		}else {
			sch.setEnd(end);
		}
		sch.setStart((sch.getCurPage()-1)*sch.getPageSize()+1);
		//          1   (1-1)*5+1 : 1
		//          2   (2-1)*5+1 : 6
		//          3   (3-1)*5+1 : 11
		// 하단에 <이전     이후> 블럭 처리.
		// 1. 블럭의 크기 지정.
		sch.setBlockSize(5);
		// 2. 블럭의 번호 지정..
		//    1번블럭   [1]...     [5]
		//    2번블럭   [6]...     [10]
		//    3번블럭   [11]...    [15]
		//            [11][12][13]
		int blocknum = (int)(Math.ceil(sch.getCurPage()/(double)sch.getBlockSize()));
		
		int endBlock = blocknum*sch.getBlockSize();
		if(endBlock>=sch.getPageCount()) {
			endBlock = sch.getPageCount();
		}
		sch.setEndBlock(endBlock);
		sch.setStartBlock((blocknum-1)*sch.getBlockSize()+1);
		
		
		
		
		// 요청값을 넘기고, 객체(ArrayList<Board>)를 받는 처리.
		return dao.boardList(sch);
	}
	// 파일서버 정보(공통정보)
	@Value("${upload}")
	private String path;
	
	public void insertBoard(Board ins) {
		MultipartFile mpf = ins.getReport();
		String fname = mpf.getOriginalFilename();
		
		File f = new File(path+fname);
		try {
			mpf.transferTo(f);
			System.out.println("파일업로드 완성");
			// IO(input/output)일어나는 경우에는 일반적으로 필수예외처리(compile예외처리)
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		dao.insertBoard(ins); // 기본정보가 등록  key(no)
		dao.insertFile(new BoardFile(path,fname)); // 위 게시물의 key를 가져와서 파일정보에 등록
		
	// 		insert into  boardfile values(board_seq.currval,
	// 	     #{path}, #{fname}, sysdate, sysdate, '')	
		
		
	}
	public Board getBoardDetail(int no){
		
		// 조회 카운트업
		dao.readCountup(no);
		
		// 상세 내용을 VO로 가져오기..
		return dao.getBoardDetail(no);
	}	
	public Board updateBoard(Board upt) {
		dao.updateBoard(upt); // 수정과 함께 수정된 상세 데이터
		return dao.getBoardDetail(upt.getNo());
	}	
	
	public void deleteBoard(int no) {
		dao.deleteBoard(no);
	}
}


