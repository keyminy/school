package com.javaex.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.javaex.dao.BoardDaoImpl;
import com.javaex.dao.BoardDao;
import com.javaex.util.WebUtil;
import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;
import com.my.util.PageObject;

/**
 * Servlet implementation class BoardServlet
 */
@WebServlet("/board")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		PageObject pageObject = null;
		String actionName = request.getParameter("a");
		System.out.println("board:" + actionName);
		pageObject = PageObject.getInstance(request);
		
		if ("list".equals(actionName)) {
			List<BoardVo> list =null;
			System.out.println("=======담긴 pageObject====" + pageObject);
			BoardDao dao = new BoardDaoImpl();
			//페이지 갯수 구하기
			long cnt = dao.getTotalRow(pageObject);
			pageObject.setTotalRow(cnt);
			System.out.println("list()에서 pageObject() : " + pageObject);
			//list 구하기
			list = dao.getList(pageObject);
			System.out.println("dao.getList() 값 : " + list);
			//request에 담기
			request.setAttribute("list", list);
			request.setAttribute("pageObject", pageObject);
			//forward시키기
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
			rd.forward(request, response);
		}
		else if("read".equals(actionName)) {
			//게시물 가져오기
			int no = Integer.parseInt(request.getParameter("no"));
			BoardDao dao = new BoardDaoImpl();
			BoardVo vo = dao.read(no);
			System.out.println("read() vo  : " + vo);
			request.setAttribute("vo", vo);
			WebUtil.forward(request, response, "/WEB-INF/views/board/read.jsp");
		}else if("modifyForm".equals(actionName)) {
			int no = Integer.parseInt(request.getParameter("no"));
			BoardDao dao = new BoardDaoImpl();
			BoardVo vo = dao.read(no);
			System.out.println("modifyForm() vo  : " + vo);
			request.setAttribute("vo", vo);
			WebUtil.forward(request, response, "/WEB-INF/views/board/modify.jsp");
		}else if("modify".equals(actionName)) {
			int no = Integer.parseInt(request.getParameter("no"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			BoardVo vo = new BoardVo();
			vo.setNo(no);
			vo.setTitle(title);
			vo.setContent(content);
			System.out.println("vo : " + vo);
			BoardDao dao = new BoardDaoImpl();
			int res = dao.modify(vo);
			System.out.println("수정완료?  : " + res);
			response.sendRedirect("/mysite/board?a=read&no="+vo.getNo());
		}
		else if("delete".equals(actionName)) {
			int no = Integer.parseInt(request.getParameter("no"));
			BoardVo vo = new BoardVo();
			vo.setNo(no);
			System.out.println("vo : " + vo);
			BoardDao dao = new BoardDaoImpl();
			int res = dao.delete(no);
			System.out.println("삭제 완료?  : " + res);
			response.sendRedirect("/mysite/board?a=list");
		}else if("write".equals(actionName)) {
			HttpSession session = request.getSession();
			UserVo authUser = (UserVo)session.getAttribute("authUser");
			
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			BoardVo vo = new BoardVo();
			vo.setTitle(title);
			vo.setContent(content);
			vo.setUser_no(authUser.getNo());
			BoardDao dao = new BoardDaoImpl();
			dao.insert(vo);
			System.out.println("insert vo : " + vo);
			response.sendRedirect("/mysite/board?a=list");
		}else if("writeForm".equals(actionName)) {
			WebUtil.forward(request, response, "/WEB-INF/views/board/write.jsp");
		}else if("search".equals(actionName)) {
			String kwd = request.getParameter("kwd");
			System.out.println("kwd : " + kwd);
			BoardDao dao = new BoardDaoImpl();
			List<BoardVo> list = dao.getSearch(kwd);
			System.out.println("dao.getSearch() 값 : " + list);
			request.setAttribute("list", list);
			request.setAttribute("kwd", kwd);
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
			rd.forward(request, response);
			//response.sendRedirect("/mysite/board?a=list&kwd="+kwd);
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/board/list.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
