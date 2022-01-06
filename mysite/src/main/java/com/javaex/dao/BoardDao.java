package com.javaex.dao;

import java.util.List;


import com.javaex.vo.BoardVo;
import com.my.util.PageObject;

public interface BoardDao {
	//리스트
	public List<BoardVo> getList(PageObject pageObject);
	public long getTotalRow(PageObject pageObject);
	
	 public int insert(BoardVo vo);
	 public int modify(BoardVo vo);

	 public int delete(int no);
	 public BoardVo read(int no); 
	 
	 public List<BoardVo> getSearch(String word);
}
