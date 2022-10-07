package board.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import board.vo.Board;
import board.vo.BoardFile;
import board.vo.BoardSch;

// board.dao.BoardDao
@Repository
public interface BoardDao {
	public int totCnt(BoardSch sch);
	public List<Board> boardList(BoardSch sch);
	public void insertBoard(Board ins);
	public Board getBoardDetail(int no);
	public void readCountup(int no);
	public void updateBoard(Board upt);		
	public void deleteBoard(int no);	
	public void insertFile(BoardFile file);
}
