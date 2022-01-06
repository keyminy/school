package com.javaex.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.javaex.dao.UserDao;
import com.javaex.util.WebUtil;
import com.javaex.vo.UserVo;

@WebServlet("/user")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String actionName = request.getParameter("a");
		System.out.println("user:" + actionName);
		
		if ("join".equals(actionName)) {
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String gender = request.getParameter("gender");

			UserDao dao = new UserDao();
			UserVo vo = new UserVo(name,email, password,gender);
			if(dao.insert(vo)==1) {
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/views/user/joinsuccess.jsp");
				rd.forward(request, response);
			}else {
				System.out.println("실패");
			}
		}else if ("joinform".equals(actionName)) {
			WebUtil.forward(request, response, "/WEB-INF/views/user/joinform.jsp");
		} else if("loginform".equals(actionName)){
			WebUtil.forward(request, response, "/WEB-INF/views/user/loginform.jsp");
		}
		else if("login".equals(actionName)){
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			UserDao dao = new UserDao();
			UserVo vo = dao.getUser(email,password);
			System.out.println(" vo : " + vo);
			if(vo == null) {
				System.out.println("로그인 실패");
				HttpSession session = request.getSession();
				session.setAttribute("msg","사용자 정보가 올바르지 않습니다.");
			}else {
				System.out.println("로그인 성공");
				HttpSession session = request.getSession();
				session.setAttribute("authUser",vo);
			}
			WebUtil.forward(request, response, "/main");
		}//end login
		else if("logout".equals(actionName)) {
			HttpSession session = request.getSession();
			session.removeAttribute("authUser");
			session.invalidate();
			response.sendRedirect("/mysite/main");
		}else if("modifyform".equals(actionName)){
			WebUtil.forward(request, response, "/WEB-INF/views/user/modifyform.jsp");
		}else if("modify".equals(actionName)) {
			HttpSession session = request.getSession();
			UserVo authUser = (UserVo)session.getAttribute("authUser");
			
			int no=Integer.parseInt(request.getParameter("no"));
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			String gender = request.getParameter("gender");
			UserVo vo = new UserVo(no,name,email,password,gender);
			System.out.println("수정 vo : " + vo);
			UserDao dao = new UserDao();
			
			if(dao.update(vo)==1) {
				//세션의 name과 no 바꿔주기 authUser.setName~no
				authUser.setName(name);
				authUser.setNo(no);
				WebUtil.forward(request, response, "/main");
			}
		}
		else {
			WebUtil.redirect(request, response, "/mysite/main");
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
