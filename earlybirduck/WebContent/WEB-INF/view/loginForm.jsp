<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>로그인</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
</head>
<body>

	<div class="container">
		<form class="form-signin"action="login.do" method="post">
			<h2 class="form-signin-heading">로그인해주세요</h2>
			<label for="inputId" class="sr-only">아이디</label>
			<input type="id" id="inputId" class="form-control" placeholder="아이디" name="id" value="${param.id}" required autofocus>
				<c:if test="${errors.id}">ID를 입력하세요.</c:if>
			<label for="inputPassword" class="sr-only">패스워드</label>
			<input type="password" id="inputPassword" class="form-control" placeholder="패스워드" name="password" required autofocus>
				<c:if test="${errors.password}">암호를 입력하세요.</c:if>
			<button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
			<br/>
			<c:if test="${errors.idOrPwNotMatch}">
				아이디와 암호가 일치하지 않습니다.
			</c:if>
		</form>
	</div>
	
<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>