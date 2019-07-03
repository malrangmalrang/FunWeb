package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import db.JdbcUtil;
import vo.MemberVO;

public class MemberDAO {

	private Connection con;
	private PreparedStatement stmt;
	private ResultSet rs;
	private static MemberDAO mdao;
	
	private MemberDAO() {}
	
	public static MemberDAO getInstance() {
		if(mdao == null) {
			mdao = new MemberDAO();
		}
		return mdao;
	}
	
	// 회원 가입
	public int insertMember(MemberVO member) {
		int insertCheck = 0;
		String sql = "INSERT INTO member VALUES(?, ?, ?, ?, ?, ?, ?)";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, member.getId());
			stmt.setString(2, member.getPass());
			stmt.setString(3, member.getName());
			stmt.setString(4, member.getEmail());
			stmt.setString(5, member.getAddress());
			stmt.setString(6, member.getPhone());
			stmt.setTimestamp(7, member.getReg_date());
			
			insertCheck = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return insertCheck;
	}
	
	// 로그인
	public int userCheck(String id, String pass) {
		int check = -1; 
		String sql = "SELECT * FROM member WHERE id=?";
		Connection con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				if(pass.equals(rs.getString("pass"))) {
					check = 1; 
				} else {
					check = 0; 
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		return check;
	}
	
	// 아이디 중복 체크
	public int idCheck(String id) {
		int idCheck = 0;
		String sql = "SELECT * FROM member WHERE id=?";
		con = JdbcUtil.getConnection();
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			if(rs.next()) {
				idCheck = 1;
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		return idCheck;
	}
	
	// 회원 정보
	public MemberVO getMember(String id) {
		MemberVO member = null;
		String sql = "SELECT * FROM member WHERE id=?";
		con = JdbcUtil.getConnection();
		
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			rs = stmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberVO();
				member.setId(rs.getString("id"));
				member.setPass(rs.getString("pass"));
				member.setName(rs.getString("name"));
				member.setEmail(rs.getString("email"));
				member.setAddress(rs.getString("address"));
				member.setPhone(rs.getString("phone"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt, rs);
		}
		
		return member;
	}
	
	// 회원 수정
	public int updateMember(MemberVO mvo, String newPass) {
		int check = 0; 
		String sql = "UPDATE member SET pass=?, name=?, email=?, address=?, phone=? WHERE id=? AND pass=?";
		con = JdbcUtil.getConnection();
		try {
			stmt = con.prepareStatement(sql);
			if(newPass.equals("")) {
				stmt.setString(1, mvo.getPass());
			} else {
				stmt.setString(1, newPass);
			}
			stmt.setString(2, mvo.getName());
			stmt.setString(3, mvo.getEmail());
			stmt.setString(4, mvo.getAddress());
			stmt.setString(5, mvo.getPhone());
			stmt.setString(6, mvo.getId());
			stmt.setString(7, mvo.getPass());
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
	
	// 회원 탈퇴
	public int deleteMember(String id, String pass) {
		int check = 0; 
		String sql = "DELETE FROM member WHERE id=? AND pass=?";
		con = JdbcUtil.getConnection();
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, id);
			stmt.setString(2, pass);
			check = stmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			JdbcUtil.close(con, stmt);
		}
		
		return check;
	}
	
}
