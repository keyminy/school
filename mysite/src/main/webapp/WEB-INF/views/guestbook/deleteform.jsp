<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="/mysite/assets/css/guestbook.css" rel="stylesheet" type="text/css">
	<title>Insert title here</title>
</head>
<body>
	<div id="container">
		
		<div id="header">
			<h1>MySite</h1>
			<ul>
				<!-- 로그인 전 -->
				<li><a href="">로그인</a></li>
				<li><a href="">회원가입</a></li>
				
				<!-- 로그인 후 -->
				<!-- 
				<li><a href="">회원정보수정</a></li>
				<li><a href="">로그아웃</a></li> 
				<li> 황일영님 안녕하세요^^;</li>
				-->
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
				<div id="guestbook" class="delete-form">
					
					<form method="post" action="gb?a=delete">
						
						<label>비밀번호</label>
						<input type="password" name="password">
						<input type="hidden" name="no" value="${param.no}">
						<input type="submit" value="확인">
					</form>
					<a href="">방명록 리스트</a>
					
				</div>
			</div><!-- /content -->
		</div><!-- /wrapper -->
		
		<div id="footer">
			<p>(c)opyright 2015,2016,2017</p>
		</div> <!-- /footer -->
		
	</div> <!-- /container -->

</body>
</html>
