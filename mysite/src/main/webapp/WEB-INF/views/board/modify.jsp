<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<% pageContext.setAttribute( "newLine", "\n" ); %>
<!DOCTYPE html>
<html>
<head>
	<title>mysite</title>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	  <!-- bootstrap 라이브러리 CDN 방식 등록 -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		<div id="content">
			<div id="board">
				<form class="board-form" method="post" action="/mysite/board?a=modify">
					<input type="hidden" name="no" value="${vo.no}" />
					<table class="tbl-ex">
						<tr>
							<th colspan="2">글수정</th>
						</tr>
						<tr>
							<td class="label">제목</td>
							<td><input type="text" name="title" value="${vo.title}"></td>
						</tr>
						<tr>
							<td class="label">내용</td>
							<td>
								<textarea id="content" name="content">
									${fn:replace(vo.content,newLine,"<br>")}
								</textarea>
							</td>
						</tr>
					</table>
					<div class="bottom">
						<a href="/mysite/board?a=read&no=${vo.no}">취소</a>
						<input type="submit" value="수정">
					</div>
				</form>				
			</div>
		</div>

		<div id="footer">
			<p>(c)opyright 2015,2016,2017</p>
		</div> <!-- /footer -->
	</div>
</body>
</html>