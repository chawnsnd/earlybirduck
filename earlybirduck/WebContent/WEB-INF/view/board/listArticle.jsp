<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 목록</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

</head>
<body>
	<!-- 상단 네비게이션 바 -->
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<!-- 브라우저가 좁아졋을때 나오는 버튼(클릭시 메뉴출력) -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="/earlybirduck/index.jsp">EARLYBIRDUCK</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="/earlybirduck/index.jsp">홈으로</a></li>
					<li><a href="/earlybirduck/introduce.jsp">얼리버덕프로젝트</a></li>
					<li><a href="/earlybirduck/mission.do">미션수행</a></li>
					<li class="active"><a href="article/list.do">게시판</a></li>
					<u:isLogin>
						<li><a href="/earlybirduck/record.do">개인실적조회</a></li>
						<li><a href="/earlybirduck/logout.do">로그아웃</a></li>
					</u:isLogin>
					<u:notLogin>
						<li><a href="/earlybirduck/join.do">회원가입</a></li>
						<li><a href="/earlybirduck/login.do">로그인</a></li>
					</u:notLogin>
				</ul>
			</div>
		</div>
	</div>

	<!-- 내용 -->
	<div class="container">
		<div style="margin-top: 100px;">
			<table class="table table-hover">
				<colgroup>
					<col width="100">
					<col>
					<col width="150">
					<col width="100">
				</colgroup>

				<tbody>
					<tr>
						<td>번호</td>
						<td>제목</td>
						<td>작성자</td>
						<td>조회수</td>
					</tr>
					<c:if test="${articlePage.hasNoArticles()}">
						<tr>
							<td colspan="4">게시글이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="article" items="${articlePage.content}">
						<tr>
							<td>${article.number}</td>
							<td><a
								href="read.do?no=${article.number}&pageNo=${articlePage.currentPage}">
									<c:out value="${article.title}" />
							</a></td>
							<td>${article.writer.name}</td>
							<td>${article.readCount}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr />
			<a class="btn btn-default pull-right" href="write.do">글쓰기</a>
			<c:if test="${articlePage.hasArticles()}">
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${articlePage.startPage > 5}">
							<li><a href="list.do?pageNo=${articlePage.startPage - 5}">이전</a>
							<li>
						</c:if>
						<c:forEach var="pNo" begin="${articlePage.startPage}"
							end="${articlePage.endPage}">
							<li><a href="list.do?pageNo=${pNo}">${pNo}</a>
							<li>
						</c:forEach>
						<c:if test="${articlePage.endPage < articlePage.totalPages}">
							<li><a href="list.do?pageNo=${articlePage.startPage + 5}">다음</a>
							<li>
						</c:if>
					</ul>
				</div>
			</c:if>
			
		</div>


<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>