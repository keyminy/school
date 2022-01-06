<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<% pageContext.setAttribute( "newLine", "\n" ); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="/mysite/assets/css/user.css" rel="stylesheet" type="text/css">
	<title>Mysite</title>
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>
<script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js'></script>
<script>
	$(function() {
		//아이디 체크하는 url : "api/emailCheck.jsp","/mysite/user",
		$("#btn-checkid").on("click",function(){
			//alert("나 실행됨??");
			var params = {a:"idcheck",email:$("[name=email]").val()};
			console.log(params);
			$.ajax({
				url : "api/emailCheck.jsp",
				type : "post",
				data : params,
				dataType : "json",
				success : function(isExist){
					console.log(isExist);
					if(!isExist){
			             $("#checkid-msg").text("사용할 수 있는 아이디 입니다.")
			             $("#checkid-msg").css("color", "green")
			           }else {
			             $("#checkid-msg").text("다른 아이디로 가입해 주세요.")
			             $("#checkid-msg").css("color", "red");
			           }
				},
				error : function(XHR,status,error){
					console.error(status + " : " + error);
				}
			});
		});
	});//end jquery
</script>
</head>
<body>

	<div id="container">
		<div id="header">
			<h1>MySite</h1>
			<ul>
				<!-- 로그인 전 -->
				<li><a href="/mysite/user?a=loginform">로그인</a></li>
				<li><a href="/mysite/user?a=joinform">회원가입</a></li>
				
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
				<div id="user">
					<form id="join-form" name="joinForm" method="post" action="user">
						<input type="hidden" name="a"  value="join"/>
						<label class="block-label" for="name">이름</label>
						<input id="name" name="name" type="text" value="">
	
						<label class="block-label" for="email">이메일</label>
						<input id="email" name="email" type="text" value="">
						<input id="btn-checkid" type="button" value="id 중복체크">
			            <p id="checkid-msg" class="form-error">
			           	 	&nbsp;
			            </p>
						<label class="block-label">패스워드</label>
						<input name="password" type="password" value="">
						
						<fieldset>
							<legend>성별</legend>
							<label>여</label> <input type="radio" name="gender" value="female" checked="checked">
							<label>남</label> <input type="radio" name="gender" value="male">
						</fieldset>
						
						<fieldset>
							<legend>약관동의</legend>
							<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
							<label>서비스 약관에 동의합니다.</label>
						</fieldset>
						
						<input type="submit" value="가입하기">
						
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