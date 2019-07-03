package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import db.JdbcUtil;
import vo.DatVO;

public class BoardDown_DatDAO {
	
	private Connection con;
	private PreparedStatement stmt;
	private ResultSet rs;
	private static BoardDown_DatDAO bddao;
	
	private BoardDown_DatDAO() {}
	
	public static BoardDown_DatDAO getInstance() {
		if(bddao == null) {
			bddao = new BoardDown_DatDAO();
		}
		return bddao;
	}
	
	// 댓글 등록
	public int insertDat(DatVO dat) {
		int check = 0;
		int max = 0;
		String sql1 = "SELECT MAX(dat_num) FROM board_down_dat WHERE board_num=?";
		String sql2 = "INSERT INTO board_down_dat VALUES(?, ?, ?, ?, now(), ?, ?, ?)";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql1);
			stmt.setInt(1, dat.getBoard_num());
			rs = stmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1)+1;
			}
			
			stmt = con.prepareStatement(sql2);
			stmt.setInt(1, max);
			stmt.setInt(2, dat.getBoard_num());
			stmt.setString(3, dat.getDat_name());
			stmt.setString(4, dat.getDat_content());
			stmt.setInt(5, max);
			stmt.setInt(6, 0);
			stmt.setInt(7, 0);
			
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return check;
	}
	
	// 대댓글 등록
	public int insertReDat(DatVO dat) {
		int check = 0;
		int max = 0;
		String sql1 = "SELECT MAX(dat_num) FROM board_down_dat WHERE board_num=?";
		String sql2 = "UPDATE board_down_dat SET dat_re_seq=dat_re_seq+1 WHERE board_num=? AND dat_re_ref=? AND dat_re_seq > ?";
		String sql3 = "INSERT INTO board_down_dat VALUES(?, ?, ?, ?, now(), ?, ?, ?)";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql1);
			stmt.setInt(1, dat.getBoard_num());
			rs = stmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1)+1;
			}			
			stmt = con.prepareStatement(sql2);
			stmt.setInt(1, dat.getBoard_num());
			stmt.setInt(2, dat.getDat_re_ref());
			stmt.setInt(3, dat.getDat_re_seq());
			stmt.executeUpdate();
			
			stmt = con.prepareStatement(sql3);
			stmt.setInt(1, max);
			stmt.setInt(2, dat.getBoard_num());
			stmt.setString(3, dat.getDat_name());
			stmt.setString(4, dat.getDat_content());
			stmt.setInt(5, dat.getDat_re_ref());
			stmt.setInt(6, dat.getDat_re_lev() + 1);
			stmt.setInt(7, dat.getDat_re_seq() + 1);
				
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
			
		return check;
	}
	
	// 댓글 전체 갯수
	public int getDatCount(int board_num) {
		int count = 0;
		String sql = "SELECT COUNT(*) FROM board_down_dat WHERE board_num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, board_num);
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
	
	// 댓글 리스트 받아오기
	public List<DatVO> getDatList(int startRow, int pageSize, int board_num) {
		List<DatVO> datList = new ArrayList<DatVO>();
		String sql = "SELECT * FROM board_down_dat WHERE board_num=? ORDER BY dat_re_ref ASC, dat_re_seq ASC LIMIT ?, ?";
		con = JdbcUtil.getConnection();
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, board_num);
			stmt.setInt(2, startRow-1);
			stmt.setInt(3, pageSize);
			rs = stmt.executeQuery();
			
			while(rs.next()) {
				DatVO dat = new DatVO();
				dat.setDat_num(rs.getInt("dat_num"));
				dat.setBoard_num(rs.getInt("board_num"));
				dat.setDat_name(rs.getString("dat_name"));
				dat.setDat_content(rs.getString("dat_content"));
				dat.setDat_reg_date(rs.getTimestamp("dat_reg_date"));
				dat.setDat_re_ref(rs.getInt("dat_re_ref"));
				dat.setDat_re_lev(rs.getInt("dat_re_lev"));
				dat.setDat_re_seq(rs.getInt("dat_re_seq"));
				
				datList.add(dat);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return datList;
	}
	
	// 댓글 수정
	public int updateDat(int dat_num, int board_num, String dat_content) {
		int check = 0;
		String sql = "UPDATE board_down_dat SET dat_content=? WHERE dat_num=? AND board_num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, dat_content);
			stmt.setInt(2, dat_num);
			stmt.setInt(3, board_num);
			
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
	
	// 댓글 삭제
	public int deleteDat(int dat_num, int board_num) {
		int check = 0;
		String sql = "DELETE FROM board_down_dat WHERE dat_num=? AND board_num=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, dat_num);
			stmt.setInt(2, board_num);
			
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
	
}
