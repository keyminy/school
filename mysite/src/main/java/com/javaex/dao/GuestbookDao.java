package com.javaex.dao;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.GuestbookVo;



public class GuestbookDao {
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
		  
			public int insert(GuestbookVo vo) {
				
				Connection conn = null;
				PreparedStatement pstmt = null;
				int count = 0 ;
				
				try {
					conn = getConnection();
					
					String query ="INSERT INTO guestbook(no,name,password,content,reg_date) "
											+"VALUES (seq_guestbook_no.nextval,?,?,?,sysdate)";
					pstmt = conn.prepareStatement(query);	
					
					pstmt.setString(1,vo.getName());
					pstmt.setString(2, vo.getPassword());
					pstmt.setString(3, vo.getContent());
				
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
			
			public void delete(GuestbookVo vo) {
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    int count = 0 ;
		    
		    try {
		      conn = getConnection();
		      
		      String query ="DELETE FROM guestbook WHERE no = ? AND password = ?";
		      pstmt = conn.prepareStatement(query); 
				pstmt.setInt(1,vo.getNo());
				pstmt.setString(2,vo.getPassword());
		    
		      count = pstmt.executeUpdate();
		      
		      System.out.println(count + "건 삭제");
		      
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
		  }
			
			public List<GuestbookVo> getList() {

				// 0. import java.sql.*;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				List<GuestbookVo> list = new ArrayList<GuestbookVo>();

				try {
				  conn = getConnection();
					
					// 3. SQL문 준비 / 바인딩 / 실행
					String query =  "SELECT no, name,CONTENT, REG_DATE  "
												+ "FROM guestbook "
												+ "ORDER BY no DESC";
					pstmt = conn.prepareStatement(query);
					
					rs = pstmt.executeQuery();
					// 4.결과처리
					while(rs.next()) {
						int no = rs.getInt("no");
						GuestbookVo vo = new GuestbookVo();
						vo.setNo(rs.getInt("no"));
						vo.setName(rs.getString("name"));
						vo.setContent(rs.getString("CONTENT"));
						vo.setReg_date(rs.getDate("REG_DATE"));
						list.add(vo);
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

				return list;
			}

}
