<!-- 귀찮아서 일단은 모델1으로 구성합니다 나중에 MVC로 바꾸겠습니다 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="auth.service.User" %>
<%@ page import="jdbc.JdbcUtil" %>
<%@ page import="jdbc.connection.ConnectionProvider" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<%
	User user = (User)request.getSession(false).getAttribute("authUser");
	String id = user.getId();
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String query = "select year, month, day, week, firstmission, secondmission, thirdmission from mission where memberid=?";
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>EARLYBIRDUCK</title>
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
					<li><a href="/earlybirduck/article/list.do">게시판</a></li>
					<u:isLogin>
						<li class="active"><a href="/earlybirduck/record.do">개인실적조회</a></li>
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


	<div class="container">
		<div style="margin-top: 100px;">
			<div class="box">
				<div id="record">
					<table class="table">
						<caption><%=id%>님의 개인실적입니다.
						</caption>
						<tr>
							<td>년</td>
							<td>월</td>
							<td>일</td>
							<td>첫번째 미션</td>
							<td>두번째 미션</td>
							<td>세번째 미션</td>
						</tr>
						<%
							try {
								conn = ConnectionProvider.getConnection();
								pstmt = conn.prepareStatement(query);
								pstmt.setString(1, id);
								rs = pstmt.executeQuery();
								System.out.print(rs);
								while (rs.next()) {
									String fm = "";
									String sm = "";
									String tm = "";
									if (rs.getTime("firstmission") == null) {
										fm = "미션실패";
									} else {
										fm = rs.getTime("firstmission").toString();
									}
									if (rs.getTime("secondmission") == null) {
										sm = "미션실패";
									} else {
										sm = rs.getTime("secondmission").toString();
									}
									if (rs.getTime("thirdmission") == null) {
										tm = "미션실패";
									} else {
										tm = rs.getTime("thirdmission").toString();
									}
						%>
						<tr>
							<td><%=rs.getInt("year")%></td>
							<td><%=rs.getInt("month")%></td>
							<td><%=rs.getInt("day")%></td>
							<td><%=fm%></td>
							<td><%=sm%></td>
							<td><%=tm%></td>
						</tr>
						<%
							}
							} catch (Exception ex) {
								ex.printStackTrace();
							} finally {
								JdbcUtil.close(rs);
								JdbcUtil.close(pstmt);
								JdbcUtil.close(conn);
							}
						%>
					</table>

				</div>
				<br /> <a href="index.jsp">메인화면으로</a>

			</div>
		</div>
	</div>

<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>