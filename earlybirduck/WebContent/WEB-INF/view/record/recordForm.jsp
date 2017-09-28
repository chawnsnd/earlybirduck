<!-- 귀찮아서 일단은 모델1으로 구성합니다 나중에 MVC로 바꾸겠습니다 -->

<%@page import="java.sql.Statement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="auth.service.User" %>
<%@ page import="jdbc.JdbcUtil" %>
<%@ page import="jdbc.connection.ConnectionProvider" %>
<%@ page import="java.util.Calendar" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="u" tagdir="/WEB-INF/tags"%>

<%
	User user = (User)request.getSession(false).getAttribute("authUser");
	String id = user.getId();
	Connection conn = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	ResultSet rrs = null;
	Calendar today = Calendar.getInstance();
	int curYear = today.get(Calendar.YEAR);
	int curMonth = today.get(Calendar.MONTH)+1;
	int curMonthPenalty=0;
	String query1 = "select year, month, day, week, firstmission, secondmission, thirdmission, chk from mission where memberid=?";

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
					<td>벌금</td>
					<td>비고</td>
				</tr>

				<%
					try {
						conn = ConnectionProvider.getConnection();
						pstmt = conn.prepareStatement(query1);
						pstmt.setString(1, id);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							int pen=0;
							int penalty=0;
							String fm = "";
							String sm = "";
							String tm = "";
							String keyYear = Integer.toString(rs.getInt("year"));
							String keyMonth = Integer.toString(rs.getInt("month"));
							String keyDay = Integer.toString(rs.getInt("day"));
							if (rs.getTime("firstmission") == null) {
								fm = "미션실패";
								pen++;
							} else {
								fm = rs.getTime("firstmission").toString();
							}
							if (rs.getTime("secondmission") == null) {
								sm = "미션실패";
								pen++;
							} else {
								sm = rs.getTime("secondmission").toString();
							}
							if (rs.getTime("thirdmission") == null) {
								tm = "미션실패";
								pen++;
							} else {
								tm = rs.getTime("thirdmission").toString();
							}
							
							if(pen == 3){
								penalty=6000;
							}else if(pen ==2){
								penalty=4000;
							}else if(pen ==1){
								penalty=2000;
							}else{
								penalty=0;
							}
							stmt=conn.createStatement();
							stmt.executeUpdate("update mission set penalty="+penalty+
									" where memberid='"+id+
									"' and year="+keyYear+
									" and month="+keyMonth+
									" and day="+keyDay+
									" and chk is null");
							
				%>
				<tr>
					<td><%=rs.getInt("year")%></td>
					<td><%=rs.getInt("month")%></td>
					<td><%=rs.getInt("day")%></td>
					<td><%=fm%></td>
					<td><%=sm%></td>
					<td><%=tm%></td>
					<td><%=penalty %></td>
					<td>
						<% if(rs.getString("chk")==null){
						%><a href="#">구제신청</a>
						<%
						}else{
						%><%=rs.getString("chk")%>
						<%
						}
					%>
					</td>
				</tr>
				<%

						} //와일문 끝
						rrs = stmt.executeQuery("select sum(penalty) as curmonthpenalty from mission where memberid='"+id+
						"' and year="+curYear+
						" and month="+curMonth);
						if(rrs.next()){
							curMonthPenalty = rrs.getInt("curmonthpenalty");
							System.out.println(curMonthPenalty);
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
			<br/>
			<h4>이번 달 벌금 : <%=curMonthPenalty %></h4>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
</body>
</html>


