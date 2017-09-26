<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미션 수행하기</title>
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
				<a class="navbar-brand" href="index.jsp">EARLYBIRDUCK</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="./index.jsp">홈으로</a></li>
					<li><a href="./introduce.jsp">얼리버덕프로젝트</a></li>
					<li class="active"><a href="mission.do">미션수행</a></li>
					<li><a href="article/list.do">게시판</a></li>
					<u:isLogin>
						<li><a href="record.do">개인실적조회</a></li>
						<li><a href="logout.do">로그아웃</a></li>
					</u:isLogin>
					<u:notLogin>
						<li><a href="join.do">회원가입</a></li>
						<li><a href="login.do">로그인</a></li>
					</u:notLogin>
				</ul>
			</div>
		</div>
	</div>

	<!-- 내용 -->
	<div class="container">
		<div style="margin-top: 100px;">

			<form action="mission.do" method="post">
				<input type="hidden" name="order" value="1" /> 첫번째 미션 <input
					type="submit" value="수행하기">
			</form>

			<br />

			<form action="mission.do" method="post">
				<input type="hidden" name="order" value="2" /> 두번째 미션 <input
					type="submit" value="수행하기">
			</form>

			<br />

			<form action="mission.do" method="post">
				<input type="hidden" name="order" value="3" /> 세번째 미션 <input
					type="submit" value="수행하기">
			</form>

		</div>
	</div>
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>