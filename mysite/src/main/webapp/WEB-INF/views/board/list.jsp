<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 
<% pageContext.setAttribute( "newLine", "\n" ); %>
<!DOCTYPE html>
<html>
<head>
	<title>mysite</title>
	<style type="text/css">
		.dataRow:hover {
			background: #eee;
			cursor: pointer;
		}
	</style>
	<meta http-equiv="content-type" content="text/html; charset=utf-8">
	<link href="/mysite/assets/css/board.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div id="container">
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
		<c:import url="/WEB-INF/views/includes/navigation.jsp"></c:import>
		
		<div id="content">
			<div id="board">
				<form id="search_form" action="/mysite/board" method="get">
					<!-- page정보를 hidden태그로 보내주기 -->
					<input type="hidden" name="a" value="list" />
					<input type="hidden" name="page" value="1" />
					<input type="hidden" name="perPageNum" value="${pageObject.perPageNum}" />
					<select name="key">
						<option value="title"  ${(pageObject.key == "title")?"selected":"" }>제목</option>
						<option value="content"  ${(pageObject.key == "content")?"selected":"" }>내용</option>
						<option value="name" ${(pageObject.key == "name")?"selected":"" }>작성자</option>
						<option value="reg_date" ${(pageObject.key == "reg_date")?"selected":"" }>작성일</option>
					</select>
					<input type="text" id="word" name="word" value="${param.word}">
					<input type="submit" value="찾기">
				</form>
				<table class="tbl-ex">
				 <thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>&nbsp;</th>
					</tr>
				 </thead>
				 <tbody>				
		    	<!--list 데이터가 없는 경우 표시 -->
			      <c:if test="${empty list}">
			      	<tr>
			      		<td>데이터가 존재하지 않습니다..</td>
			      	</tr>
			      </c:if>
			      <!-- list 데이터가 있을때 출력 -->
			      <c:if test="${!empty list}">
			      	<c:forEach items="${list}" var="vo">
						<tr class = "dataRow">
							<td>${vo.no}</td>
							<td><a href="/mysite/board?a=read&no=${vo.no}&inc=1">${vo.title}</a></td>
							<td>${vo.name}</td>
							<td>${vo.hit}</td>
							<td>${vo.reg_date}</td>
							<td>
								<c:if test="${authUser.no==vo.user_no}">
									<a href="/mysite/board?a=delete&no=${vo.no}" class="del">삭제</a>
								</c:if>
							</td>
						</tr>
			      	</c:forEach>
			      </c:if>
					</tbody>
				</table>
				<div class="pager">
					<ul class="pagination">
						<li data-page=1>
							<c:if test="${pageObject.page>1}">
								<a href="/mysite/board?a=list&page=1&perPageNum=${pageObject.perPageNum}&key=${pageObject.key }&word=${pageObject.word }">
									◀◀
								</a>
							</c:if>
							<c:if test="${pageObject.page==1}">
								<a href="" onclick="return false">
									◀◀
								</a>
							</c:if>
						</li>
						
						<li data-page="${pageObject.startPage-1}">
							<c:if test="${pageObject.startPage>1}">
								<a href="/mysite/board?a=list&page=${pageObject.startPage-1}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key }&word=${pageObject.word }">
									◀
								</a>
							</c:if>
							<c:if test="${pageObject.startPage==1}">
								<a href="" onclick="return false">
									◀
								</a>
							</c:if>
						</li>
						
						<!-- 반복문 으로 페이지 번호 생성 -->
						<c:forEach begin="${pageObject.startPage}" end="${pageObject.endPage}" var="cnt">
							<li ${(pageObject.page==cnt)?"class=\"selected\"":""}
								data-page="${cnt}">
								<!-- 페이지와 cnt가 같으면 링크가 없음 -->
								<c:if test="${pageObject.page==cnt}">
									<a href="" onclick="return false">${cnt}</a>
								</c:if>
								<!-- 페이지와 cnt가 같지않으면 링크가 있음 -->
								<c:if test="${pageObject.page!=cnt}">
									<a href="/mysite/board?a=list&page=${cnt}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key }&word=${pageObject.word }">
										${cnt}
									</a>
								</c:if>
							</li>
						</c:forEach>
						<!-- ▶부분 -->
						<c:if test="${pageObject.endPage<pageObject.totalPage}">
							<li data-page="${pageObject.endPage+1}">
								<a href="/mysite/board?a=list&page=${pageObject.endPage+1}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key }&word=${pageObject.word }">
									▶
								</a>
							</li>
						</c:if>
						<c:if test="${pageObject.endPage==pageObject.totalPage}">
							<li data-page="${pageObject.endPage+1}">
								<a href="" onclick="return false">
									▶
								</a>
							</li>
						</c:if>
						<!--▶▶부분  -->
						<c:if test="${pageObject.page<pageObject.totalPage}">
							<li data-page="${pageObject.totalPage}">
								<a href="/mysite/board?a=list&page=${pageObject.totalPage}&perPageNum=${pageObject.perPageNum}&key=${pageObject.key }&word=${pageObject.word }">
									▶▶
								</a>
							</li>
						</c:if>
						<c:if test="${pageObject.page==pageObject.totalPage}">
							<li data-page="${pageObject.totalPage}">
								<a href="" onclick="return false">
									▶▶
								</a>
							</li>
						</c:if>
					</ul>
				</div>	<!-- end pager -->			
				
				<div class="bottom">
					<a href="/mysite/board?a=writeForm" id="new-book">글쓰기</a>
				</div>				
			</div>
		</div>
		
		<div id="footer">
			<p>(c)opyright 2015,2016,2017</p>
		</div> <!-- /footer -->
		
	</div>
</body>
</html>