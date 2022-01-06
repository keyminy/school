package com.javaex.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;


import com.javaex.vo.BoardVo;
import com.my.util.PageObject;

public interface BoardDao {
	//리스트
	public List<BoardVo> getList(PageObject pageObject);
	public long getTotalRow(PageObject pageObject);
	//검색에 대한 문자열 붙이기 word가 있는 경우만 조건 붙임
	public String search(PageObject pageObject);
	//검색에 대한 문자열 붙이기 word가 있는 경우에만 조건 붙임
	public int searchSetData(PageObject pageObject, PreparedStatement pstmt, int idx) throws SQLException;
	
	 public int insert(BoardVo vo);
	 public int modify(BoardVo vo);

	 public int delete(int no);
	 public BoardVo read(int no); 
	 
	 public List<BoardVo> getSearch(String word);
	 public int increase(int no);
}
