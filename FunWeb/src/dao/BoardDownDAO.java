package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;
import vo.BoardDownVO;

public class BoardDownDAO {
	
	private Connection con;
	private PreparedStatement stmt;
	private ResultSet rs;
	private static BoardDownDAO bdao;
	
	private BoardDownDAO() {}
	
	public static BoardDownDAO getInstance() {
		if(bdao == null) {
			bdao = new BoardDownDAO();
		}
		return bdao;
	}
	
	// 글 등록
	public int insertBoard(BoardDownVO board) {
		int check = 0;
		int max = 0;
		String sql1 = "SELECT MAX(num) FROM board_down";
		String sql2 = "INSERT INTO board_down VALUES(?, ?, ?, ?, ?, ?, now())";
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
		String sql = "SELECT COUNT(*) FROM board_down";
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
	public List<BoardDownVO> getBoardList(int startRow, int pageSize) {
		List<BoardDownVO> boardList = new ArrayList<BoardDownVO>();
		String sql = "SELECT * FROM board_down ORDER BY num DESC LIMIT ?, ?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, startRow-1);
			stmt.setInt(2, pageSize);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				BoardDownVO board = new BoardDownVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				
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
	public List<BoardDownVO> getBoardList(int startRow, int pageSize, String search) {
		List<BoardDownVO> boardList = new ArrayList<BoardDownVO>();
		String sql = "SELECT * FROM board_down WHERE subject LIKE ? ORDER BY num DESC LIMIT ?, ?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, "%" + search + "%");
			stmt.setInt(2, startRow-1);
			stmt.setInt(3, pageSize);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				BoardDownVO board = new BoardDownVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
				
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
		String sql = "UPDATE board_down SET readcount=readcount+1 WHERE num=?";
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
	public BoardDownVO getBoard(int num) {
		BoardDownVO board = null;
		String sql = "SELECT * FROM board_down WHERE num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, num);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				board = new BoardDownVO();
				board.setNum(rs.getInt("num"));
				board.setName(rs.getString("name"));
				board.setSubject(rs.getString("subject"));
				board.setContent(rs.getString("content"));
				board.setFile(rs.getString("file"));
				board.setReadcount(rs.getInt("readcount"));
				board.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return board;
	}
	
	// 글 수정
	public int updateBoard(BoardDownVO board) {
		int check = 0;
		String sql = "UPDATE board_down SET name=?, subject=?, file=?, content=? WHERE num=?";
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
		String sql = "DELETE FROM board_down WHERE num=?";
		String sql2 = "DELETE FROM board_down_dat WHERE board_num=?";
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













