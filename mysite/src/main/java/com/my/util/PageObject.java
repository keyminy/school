package com.my.util;

import javax.servlet.http.HttpServletRequest;

public class PageObject {
	//현재 페이지를 DB에서 가져 올때 필요한 정보
	private long page; //현재 페이지
	private long perPageNum; //페이지당 보여지는 글의 개수
	private long startRow,endRow; //현재 페이지의 시작 줄번호,끝번호
	
	//JSP화면 하단 부분에 페이지를 표시할때 필요한 정보
	private long perGroupPageNum; //기본값 10을 생성자에서 셋팅
	private long startPage;
	private long endPage;
	private long totalPage;
	private long totalRow; //DB에서 구한다.
	
	//검색에 필요한 변수 선언
	private String key;
	private String word;
	
	public PageObject(long page,long perPageNum) {
		this.page = page;
		this.perPageNum = perPageNum;
		//시작 줄번호와 끝 줄 번호를 계산
		//startRow 부분 : (page-1) : 이전 페이지 까지 데이터 skip시키고 *10 +1 그 다음 번호 시작 번호로 한다.
		startRow = (page-1)*perPageNum+1;
		endRow = startRow+perPageNum-1;
		
		//JSP 하단 부분에 몇개의 페이지를 표시할지 정한다.
		perGroupPageNum = 10;
		System.out.println("PageObject(페이지,페이지 당 글 수)");
	}
	
	//기본 생성자 : Spring에서는 파라매터 값을 전달 받을때, 기본 생성자와 setter()를 이용해서 데이터를 전달받음
	public PageObject() {
		//처음 리스트로 들어올 때는 데이터가 안 넘어 오므로 초기값을 1페이지에,(page=1)
		//perPageNum=10으로 한 페이지 당 10개의 글이 보이도록 셋팅함
		this.page=1;
		this.perPageNum=10;
		//JSP하단 부분에 몇개의 페이지를 표시할지 정한다.
		this.startPage=1;
		this.endPage=1;
		this.perGroupPageNum=10;
		//service프로그램에서 setTotalRow(DB의 데이터 갯수)를 호출해야만 한다.그래야 자동 계산이 된다.
		
	}
	
	//객체로 만들어 주는 메서드 -> 웹 프로젝트의 request객체를 이용한것
	public static PageObject getInstance(HttpServletRequest request){
		//페이지 처리를 위한 프로그램
		//페이지 처리를 위한 객체 사용
		PageObject pageObject = new PageObject();
		//페이지에 대한 정보를 받는다.
		//page는 jsp에서 기본 객체로 사용하고 있다. -> 페이지의 정보가 담겨져 있다.
		String strPage = request.getParameter("page");
		//넘어오는 페이지가 있는 경우는 넘어오는 페이지를 현재 페이지로 셋팅하고,그렇지 않으면 1이 셋팅 된다
		if(strPage!=null && !strPage.equals("")) pageObject.setPage(Integer.parseInt(strPage));
		//한 페이지에 표시할 데이터의 수를 받는다.
		String strPerPageNum = request.getParameter("perPageNum");
		//한 페이지당 표시할 데이터의 수가 안넘어오면 10으로 셋팅된다.넘어오면 넘어오는 데이터를 사용한다
		if(strPerPageNum!=null && !strPerPageNum.equals("")) pageObject.setPerPageNum(Integer.parseInt(strPerPageNum));
		//검색을 위한 데이터 전달
		pageObject.setKey(request.getParameter("key"));
		pageObject.setWord(request.getParameter("word"));
		
		//pageObject확인
		System.out.println("PageObject.getInstance() [pageObject = " + pageObject +"]==");
		return pageObject;
	}
	
	public long getPage() {
		return page;
	}
	public void setPage(long page) {
		this.page = page;
	}
	public long getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(long perPageNum) {
		this.perPageNum = perPageNum;
	}
	//setStartRow()와 setEndRow()를 계산에 의해서 결정이 되므로 받는 않아서 만들지 않는다.
	public long getStartRow() {
		return startRow;
	}
	public long getEndRow() {
		return endRow;
	}
	
	public long getPerGroupPageNum() {
		return perGroupPageNum;
	}

	public void setPerGroupPageNum(long perGroupPageNum) {
		this.perGroupPageNum = perGroupPageNum;
	}

	public long getStartPage() {
		return startPage;
	}

	public long getEndPage() {
		return endPage;
	}

	public long getTotalPage() {
		return totalPage;
	}

	public long getTotalRow() {
		return totalRow;
	}
	
	//페이지에 따른 데이터의 startRow와 endRow,totalPage,startPage,endPage
	public void setTotalRow(long totalRow) {
		this.totalRow = totalRow;
		
		//시작 줄번호와 끝 줄번호를 계산
		startRow = (page-1)*perPageNum + 1;
		endRow = startRow+perPageNum-1;
		
		//리스트 화면 하단 부분에 나타내는 페이지를 처리하기 위한 데이터들을 계산
		//전체 페이지를 계산 할 수 있다.
		totalPage = (totalRow-1)/perPageNum+1;
		//startPage,endPage
		startPage
		=(page-1)/perGroupPageNum*perGroupPageNum+1;
		endPage = startPage + perGroupPageNum -1;
		//endPage가 총 페이지 수를 넘을 수 없다.
		if(endPage>totalPage) endPage = totalPage;
	}
	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getWord() {
		return word;
	}

	public void setWord(String word) {
		this.word = word;
	}

	@Override
	public String toString() {
		return "PageObject [page=" + page + ", perPageNum=" + perPageNum + ", startRow=" + startRow + ", endRow="
				+ endRow + ", perGroupPageNum=" + perGroupPageNum + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", totalPage=" + totalPage + ", totalRow=" + totalRow + ", key=" + key + ", word=" + word + "]";
	}
	
}