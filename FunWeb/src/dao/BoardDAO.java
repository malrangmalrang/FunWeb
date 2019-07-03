package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;
import vo.BoardVO;

public class BoardDAO {
	
	private Connection con;
	private PreparedStatement stmt;
	private ResultSet rs;
	private static BoardDAO bdao;
	
	private BoardDAO() {}
	
	public static BoardDAO getInstance() {
		if(bdao == null) {
			bdao = new BoardDAO();
		}
		return bdao;
	}
	
	// 글 등록
	public int insertBoard(BoardVO board) {
		int check = 0;
		int max = 0;
		String sql1 = "SELECT MAX(num) FROM board";
		String sql2 = "INSERT INTO board VALUES(?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql1);
			rs = stmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1) + 1;
			}
			
			stmt = con.prepareStatement(sql2);
			stmt.setInt(1, max);
			stmt.setString(2, board.getName());
			stmt.setString(3, board.getSubject());
			stmt.setString(4, board.getContent());
			stmt.setString(5, board.getFile());
			stmt.setInt(6, 0);
			stmt.setInt(7, max);
			stmt.setInt(8, 0);
			stmt.setInt(9, 0);
			
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		return check;
	}
	
	// 답글 등록
	public int reInsertBoard(BoardVO board) {
		int check = 0;
		int max = 0;
		String sql1 = "SELECT MAX(num) FROM board";
		String sql2 = "UPDATE board SET re_seq=re_seq+1 WHERE re_ref=? AND re_seq > ?";
		String sql3 = "INSERT INTO board VALUES(?, ?, ?, ?, ?, ?, now(), ?, ?, ?)";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql1);
			rs = stmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1) + 1;
			}
			
			stmt = con.prepareStatement(sql2);
			stmt.setInt(1, board.getRe_ref());
			stmt.setInt(2, board.getRe_seq());
			stmt.executeUpdate();
			
			stmt = con.prepareStatement(sql3);
			stmt.setInt(1, max);
			stmt.setString(2, board.getName());
			stmt.setString(3, board.getSubject());
			stmt.setString(4, board.getContent());
			stmt.setString(5, board.getFile());
			stmt.setInt(6, 0);
			stmt.setInt(7, board.getRe_ref());
			stmt.setInt(8, board.getRe_lev()+1);
			stmt.setInt(9, board.getRe_seq()+1);
			
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		return check;
	}
	
	// 글 전체 갯수
	public int getBoardCount() {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM board";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return count;
	}
	
	// 글 리스트 받아오기
	public List<BoardVO> getBoardList(int startRow, int pageSize) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		String sql = "SELECT * FROM board ORDER BY re_ref DESC, re_seq ASC LIMIT ?, ?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, startRow-1);
			stmt.setInt(2, pageSize);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				BoardVO board = new BoardVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setRe_ref(rs.getInt("re_ref"));
				board.setRe_lev(rs.getInt("re_lev"));
				board.setRe_seq(rs.getInt("re_seq"));
				
				boardList.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return boardList;
	}
	
	// 검색된 글 리스트 받아오기
	public List<BoardVO> getBoardList(int startRow, int pageSize, String search) {
		List<BoardVO> boardList = new ArrayList<BoardVO>();
		String sql = "SELECT * FROM board WHERE subject LIKE ? ORDER BY re_ref DESC, re_seq ASC LIMIT ?, ?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, "%" + search + "%");
			stmt.setInt(2, startRow-1);
			stmt.setInt(3, pageSize);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				BoardVO board = new BoardVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setRe_ref(rs.getInt("re_ref"));
				board.setRe_lev(rs.getInt("re_lev"));
				board.setRe_seq(rs.getInt("re_seq"));
				
				boardList.add(board);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return boardList;
	}
	
	// 조회수 카운트
	public void updateReadcount(int num) {
		String sql = "UPDATE board SET readcount=readcount+1 WHERE num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, num);
			stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
	}
	
	// 글 조회
	public BoardVO getBoard(int num) {
		BoardVO board = null;
		String sql = "SELECT * FROM board WHERE num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				board.setRe_ref(rs.getInt("re_ref"));
				board.setRe_lev(rs.getInt("re_lev"));
				board.setRe_seq(rs.getInt("re_seq"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return board;
	}
	
	// 글 수정
	public int updateBoard(BoardVO board) {
		int check = 0;
		String sql = "UPDATE board SET name=?, subject=?, file=?, content=? WHERE num=?";
		con = JdbcUtil.getConnection();

		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, board.getName());
			stmt.setString(2, board.getSubject());
			stmt.setString(3, board.getFile());
			stmt.setString(4, board.getContent());
			stmt.setInt(5, board.getNum());
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
	
	// 글 삭제
	public int deleteBoard(int num) {
		int check = 0; 
		String sql = "DELETE FROM board WHERE num=?";
		String sql2 = "DELETE FROM board_dat WHERE board_num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql2);
			stmt.setInt(1, num);
			stmt.executeUpdate();
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, num);
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
}













