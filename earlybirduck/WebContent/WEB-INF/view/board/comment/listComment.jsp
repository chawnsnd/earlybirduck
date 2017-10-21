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
	<!-- 내용 -->
	<div class="container">
		<div style="margin-top: 100px;">
			<table class="table table-hover">
				<colgroup>
					<col>
					<col>
					<col>
				</colgroup>

				<tbody>
					<tr>
						<td>작성자</td>
						<td>댓글</td>
						<td>작성자</td>
					</tr>
					<c:if test="${commentPage.hasNoComments()}">
						<tr>
							<td colspan="3">아직 달린 댓글이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="comment" items="${commentPage.content}">
						<tr>
							<td>${comment.number}</td>
							<td><c:out value="${comment.comment}" /></td>
							<td>${comment.commenter.name}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr />
			<c:if test="${commentPage.hasComments()}">
				<div class="text-center">
					<ul class="pagination">
						<c:if test="${commentPage.startPage > 5}">
							<li><a href="comment.do?pageNo=${commentPage.startPage - 5}">이전</a>
							<li>
						</c:if>
						<c:forEach var="pNo" begin="${commentPage.startPage}"
							end="${commentPage.endPage}">
							<li><a href="comment.do?pageNo=${pNo}">${pNo}</a>
							<li>
						</c:forEach>
						<c:if test="${commentPage.endPage < commentPage.totalPages}">
							<li><a href="comment.do?pageNo=${commentPage.startPage + 5}">다음</a>
						</c:if>
					</ul>
				</div>
			</c:if>
			</div>
		</div>


<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>