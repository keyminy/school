package com.javaex.dao;

import java.sql.Connection;


import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.javaex.vo.BoardVo;
import com.my.util.PageObject;


public class BoardDaoImpl implements BoardDao {

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

	@Override
	public List<BoardVo> getList(PageObject pageObject) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVo> list = new ArrayList<BoardVo>();

		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행

			String query = " "; 
			query += "SELECT rnum,no,title,name,hit,reg_date,user_no ";
			query += "FROM ";
			query += "( ";
			query += "SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no ";
			query += "FROM ";
			query += "( ";
			query += "SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no ";
			query += "FROM board b,users u ";
			query += "WHERE b.user_no=u.no ";
			query += "ORDER BY no DESC ";
			query += ") ";
			query += ") ";
			query += "WHERE rnum BETWEEN ? AND ? ";	
			System.out.println("BoardDAO.list().sql - " + query);
			pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, pageObject.getStartRow()); // 시작 번호 - 1 :1페이지 정보
			pstmt.setLong(2, pageObject.getEndRow()); // 끝 번호 - 10 : 1페이지 정보
			rs = pstmt.executeQuery();
			// 4.결과처리
			while (rs.next()) {
				int no = rs.getInt("no");
				BoardVo vo = new BoardVo();
				vo.setNo(rs.getInt("no"));
				vo.setTitle(rs.getString("title"));
				vo.setName(rs.getString("name"));
				vo.setHit(rs.getInt("hit"));
				vo.setReg_date(rs.getDate("reg_date"));
				vo.setUser_no(rs.getInt("user_no"));
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
	
	@Override
	public BoardVo read(int no) {
		BoardVo vo = null;
		// 0. import java.sql.*;
		Connection conn = null;	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVo> list = new ArrayList<BoardVo>();
		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "SELECT no, title, content "
					+ "FROM board WHERE no = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setLong(1, no);
			rs = pstmt.executeQuery();
			// 4 표시 / 데이터 담기
			if(rs != null && rs.next()) {
				// 데이터가 있으면 vo 를 생성한다.
				vo = new BoardVo();
				vo.setNo(rs.getInt("no"));
				vo.setTitle(rs.getString("title"));
				vo.setContent(rs.getString("content"));
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

	@Override
	public int insert(BoardVo vo) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0 ;
		
		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행
			String query ="INSERT INTO board(no,title,content,user_no) "
					+"VALUES(seq_board_no.nextval,?,?,?)";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getUser_no());
			cnt = pstmt.executeUpdate();
			System.out.println("게시판 글등록이 되었습니다.");
		}  catch (SQLException e) {
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

	@Override
	public int delete(int no) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0 ;
		
		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행
			String query ="	DELETE FROM board "
					+ "WHERE no = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setInt(1,no);
			cnt = pstmt.executeUpdate();
			// 6. 
			if(cnt == 0) System.out.println("정보를 확인해 주세요.");
			else System.out.println("데이터가 삭제 되었습니다.");
			System.out.println(cnt + "삭제 완료");
		}  catch (SQLException e) {
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
	
	@Override
	public int modify(BoardVo vo) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		int cnt = 0 ;
		
		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행
			String query ="UPDATE board SET title=? ,content=? "
					+"WHERE no = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1,vo.getTitle());
			pstmt.setString(2, vo.getContent());
			pstmt.setInt(3, vo.getNo());
			cnt = pstmt.executeUpdate();
			System.out.println(cnt + "수정 완료");
		}  catch (SQLException e) {
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

	@Override
	public List<BoardVo> getSearch(String word) {
		// 0. import java.sql.*;
				Connection conn = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				List<BoardVo> list = new ArrayList<BoardVo>();

				try {
					conn = getConnection();
					// 3. SQL문 준비 / 바인딩 / 실행
					String query = "SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no  " 
							+ "FROM board b,users u "
							+ "WHERE b.user_no=u.no " 
							+ "AND title LIKE '%' || ? || '%' "
							+ "ORDER BY no DESC";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1,word);
					rs = pstmt.executeQuery();
					// 4.결과처리
					while (rs.next()) {
						int no = rs.getInt("no");
						BoardVo vo = new BoardVo();
						vo.setNo(rs.getInt("no"));
						vo.setTitle(rs.getString("title"));
						vo.setName(rs.getString("name"));
						vo.setHit(rs.getInt("hit"));
						vo.setReg_date(rs.getDate("reg_date"));
						vo.setUser_no(rs.getInt("user_no"));
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

	@Override
	public long getTotalRow(PageObject pageObject) {
		// 0. import java.sql.*;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BoardVo> list = new ArrayList<BoardVo>();
		long cnt =0;
		try {
			conn = getConnection();
			// 3. SQL문 준비 / 바인딩 / 실행
			String query = "SELECT COUNT(*) FROM board";
			//추후 구현
			//if(pageObject.getWord()!=null && !pageObject.getWord().equals(""))
				
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			// 4.결과처리
			if(rs!=null&&rs.next()) {
				cnt = rs.getLong(1);
				System.out.println("게시판의 전체 글의 개수 : " + cnt);
			}else System.out.println("데이터가 존재하지 않습니다.");
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
		return cnt;
	}
}
