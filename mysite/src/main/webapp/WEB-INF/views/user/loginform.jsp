<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<% pageContext.setAttribute( "newLine", "\n" ); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="/mysite/assets/css/user.css" rel="stylesheet" type="text/css">
	<title>Insert title here</title>
</head>
<body>

	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>

		<div id="wrapper">
			<div id="content">
				<div id="user">
					
					<form id="login-form" name="loginform" method="post" action="user">
						<input type="hidden" name="a" value="login" /> 
						
						<label class="block-label" for="email">이메일</label> 
						<input id="email" name="email" type="text" value=""> 

						<label class="block-label">패스워드</label> 
						<input name="password" type="password" value="">
						
						<c:if test="${param.result eq 'fail' }">
								<P>로그인이 실패했습니다. 다시입력해주세요</P>
						</c:if>
	
						<input type="submit" value="로그인">
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