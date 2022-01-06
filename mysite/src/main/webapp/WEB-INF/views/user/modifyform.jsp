<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="/mysite/assets/css/user.css" rel="stylesheet" type="text/css">
	<title>Insert title here</title>
</head>
<body>

	<div id="container">
		
		<div id="header">
			<h1>MySite</h1>
			<ul>
				<c:choose>
					<c:when test="${authUser == null }">
						<!-- 로그인 전 -->
						<li><a href="/mysite/user?a=loginform">로그인</a></li>
						<li><a href="/mysite/user?a=joinform">회원가입</a></li>
					</c:when>
					<c:otherwise>
						<!-- 로그인 후 -->
						<li><a href="/mysite/user?a=modifyform">회원정보수정</a></li>
						<li><a href="/mysite/user?a=logout">로그아웃</a></li> 
						<li> ${authUser.name }님 안녕하세요^^;</li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div> <!-- /header -->
				
		<div id="navigation">
			<ul>
				<li><a href="">정종욱</a></li>
				<li><a href="">방명록</a></li>
				<li><a href="">게시판</a></li>
			</ul>
		</div> <!-- /navigation -->
		
		<div id="wrapper">
			<div id="content">
				<div id="user">
	
					<form id="join-form" name="joinForm" method="post" action="user?a=modify">
						<input id="name" name="no" type="hidden" value="${authUser.no}" />
						<label class="block-label" for="name">이름</label>
						<input id="name" name="name" type="text" value="${authUser.name}" />
	
						<label class="block-label" for="email">이메일</label>
						<input id="email" name="email" type="text" value="${authUser.email}" />
						<strong></strong>
						
						<label class="block-label">패스워드</label>
						<input name="password" type="password" value="" />
						
							<label class="block-label">성별</label>
							<input name="gender" value="${authUser.gender}" readonly="readonly"/>

						
						<input type="submit" value="수정완료">
						
					</form>
				</div><!-- /user -->
			</div><!-- /content -->
		</div><!-- /wrapper -->
		
		<div id="footer">
			<p>(c)opyright 2015,2016,2017</p>
		</div> <!-- /footer -->
		
	</div> <!-- /container -->

</body>
</html>
