<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 조회</title>
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
			<table class="table">
				<colgroup>
					<col width="100">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<td>번호</td>
						<td>${articleData.article.number}</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td>${articleData.article.writer.name}</td>
					</tr>
					<tr>
						<td>제목</td>
						<td><c:out value='${articleData.article.title}' /></td>
					</tr>
					<tr>
						<td>내용</td>
						<td><u:pre value='${articleData.content}' /> <br />
						<br />
						<br />
						<br />
						<br />
						<br />
						<br />
						<br />
						<br />
						<br /></td>
					</tr>
					<tr>
						<td colspan="2"></td>
					</tr>
				</tbody>
			</table>
			
			<!-- 댓글 -->
			<jsp:include page="/earlybirduck/comment.do?article_no=${articleData.article.number}"></jsp:include>
			</div>

			<div class="text-center">
				<c:set var="pageNo"
					value="${empty param.pageNo ? '1' : param.pageNo}" />
				<a class="btn btn-default" href="list.do?pageNo=${pageNo}">목록</a>
				<c:if test="${authUser.id == articleData.article.writer.id}">
					<a class="btn btn-default"
						href="modify.do?no=${articleData.article.number}">게시글수정</a>
					<a class="btn btn-default"
						href="delete.do?no=${articleData.article.number}">게시글삭제</a>
				</c:if>
			</div>
			

		</div>
	</div>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>