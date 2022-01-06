package com.javaex.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;
import com.javaex.vo.UserVo;

public class UserDao {
	
	 private Connection getConnection() throws SQLException {
		    Connection conn = null;
		    try {
		      Class.forName("oracle.jdbc.driver.OracleDriver");
		      String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		      conn = DriverManager.getConnection(dburl, "webdb", "1234");
		    } catch (ClassNotFoundException e) {
		      System.err.println("JDBC 드라이버 로드 실패!");
		    }
		    return conn;
		  }
	 
	 public int insert(UserVo vo) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int count = 0 ;
		
		try {
			conn = getConnection();
			String query ="INSERT INTO users(no,name,email,password,gender) "
									+"VALUES (seq_users_no.nextval,?,?,?,?)";
			pstmt = conn.prepareStatement(query);	
			pstmt.setString(1,vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getPassword());
			pstmt.setString(4, vo.getGender());
		
			count = pstmt.executeUpdate();
			
			System.out.println(count + "건 등록");
			
		} catch (SQLException e) {
			System.out.println("error:" + e);
		} finally {
			try {
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (SQLException e) {
				System.out.println("error:" + e);
			}
		}
		return count;
	}
	 
	 public UserVo getUser(String email,String password) {

			// 0. import java.sql.*;
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			UserVo vo = null;

			try {
			  conn = getConnection();
				
				// 3. SQL문 준비 / 바인딩 / 실행
				String query =  "SELECT no, name,email,password,gender  "
											+ "FROM users "
											+ "WHERE email = ? AND password = ?";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, email);
				pstmt.setString(2, password);
				
				rs = pstmt.executeQuery();
				// 4.결과처리
				if(rs.next()) {
					int no = rs.getInt("no");
					String name = rs.getString("name");
					 email = rs.getString("email");
					password = rs.getString("password");
					String gender = rs.getString("gender");
					vo = new UserVo(no,name,email,password,gender);
				}
			} catch (SQLException e) {
				System.out.println("error:" + e);
			} finally {
				// 5. 자원정리
				try {
					if (pstmt != null) {
						pstmt.close();
					}
					if (conn != null) {
						conn.close();
					}
				} catch (SQLException e) {
					System.out.println("error:" + e);
				}

			}
			return vo;
		}
	 
	 public int update(UserVo vo) {
		 Connection conn = null;
			PreparedStatement pstmt = null;
			int cnt = 0 ;
			
			try {
				conn = getConnection();
				String query ="UPDATE users SET name=? ,email=?,password=? "
										+"WHERE no = ?";
				pstmt = conn.prepareStatement(query);	
				pstmt.setString(1,vo.getName());
				pstmt.setString(2, vo.getEmail());
				pstmt.setString(3, vo.getPassword());
				pstmt.setInt(4, vo.getNo());
			
				cnt = pstmt.executeUpdate();
				
				System.out.println(cnt + "수정 완료");
				
			} catch (SQLException e) {
				System.out.println("error:" + e);
			} finally {
				try {
					if (pstmt != null) pstmt.close();
					if (conn != null) conn.close();
				} catch (SQLException e) {
					System.out.println("error:" + e);
				}
			}
			return cnt;
		}
}
