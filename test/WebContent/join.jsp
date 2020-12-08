<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ page import="java.io.PrintWriter"%>
	<%@ page import="product.ProductDAO"%>
	<%@ page import="product.Product"%>
	<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<meta name="description" content="">
		<meta name="author" content="">
		<link rel="icon" href="favicon.ico">
		<!-- Bootstrap core CSS -->
		<link href="css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
		<!-- Custom styles for this template -->
		<link href="css/style.css" rel="stylesheet">
<style>
	.jumbotron{
		background-color:white;
		color:black;
	}
	body {

		background-image : url('images/123.JPG');
		background-repeat : no-repeat;
		background-size : cover;
	}
	.navbar-default{
		background-color:#FFFFFF;
	}
</style>


<title>HJ몰</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		int pageNumber = 1; //기본 페이지 넘버
	%>
	
	 <nav class="navbar navbar-default">
			<div class="container">
				<!-- Brand and toggle get grouped for better mobile display -->
				<div class="navbar-header page-scroll">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand page-scroll" href="main.jsp">HJ몰</a>
				</div>
				
				<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
					<ul class="nav navbar-nav navbar-right">
						<li class="hidden">
							<a href="#page-top"></a>
						</li>
						<%
						if(userID == null) {
						%>
						<li>
							<a class="page-scroll" href="login.jsp">로그인</a>
						</li>
						<li>
							<a class="page-scroll" href="join.jsp">회원가입</a>
						</li>
						<%
						} else if(userID.equals("admin")) {
						%>
						<li>
							<a class="page-scroll" href="ProductRegister.jsp">상품등록</a>
						</li>
						<li>
							<a class="page-scroll" href="StockManagement.jsp">재고확인</a>
						</li>
						<li>
							<a class="page-scroll" href="OrderDetail.jsp">주문내역</a>
						</li>
						<li>
							<a class="page-scroll" href="cart.jsp">장바구니</a>
						</li>
						<li>
							<a class="page-scroll" href="logoutAction.jsp">로그아웃</a>
						</li>
						<%
						} else {
						%>
						<li>
							<a class="page-scroll" href="OrderDetail.jsp">주문내역</a>
						</li>
						<li>
							<a class="page-scroll" href="cart.jsp">장바구니</a>
						</li>
						<li>
							<a class="page-scroll" href="logoutAction.jsp">로그아웃</a>
						</li>
						<%
						}
						%>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>
	<!-- 로긴폼 -->
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<!-- 점보트론 -->
			<div class="jumbotron" style="padding-top: 20px;">
				<!-- 로그인 정보를 숨기면서 전송post -->
				<form method="post" action="joinAction.jsp">
					<h3 style="text-align: center;">회원가입</h3>
					<div class="row">
						<div class="col-md-7">
							<div class="form-group">
								<input type="text" class="form-control" placeholder="아이디" id="userId" name="userID" maxlength="20">
							</div>
						</div>
						<div class="col-md-5" style="text-align: center;">
							<div class="form-group">
								<input type="button" class="btn btn-success form-control" id="dup" value="중복" onclick="javascript:checkValue()">
								<script type="text/javascript">
									function checkValue() {
										var id = document.getElementById('userId').value;
										if(id == "admin" || id == "hanjun" || id == "test") {
											alert('중복된 아이디 입니다.');
										} else {
											alert('사용 가능한 아이디 입니다.')
										}
									}
								</script>
							</div>
						</div>
						
					</div>
					<div class="form-group">
						<input type="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="50">
					</div>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary active"> 
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label> 
							<label class="btn btn-primary"> 
								<input type="radio" name="userGender" autocomplete="off" value="여자" >여자
							</label>
						</div>
					</div>
					<input type="submit" class="btn btn-success form-control" value="회원가입">
				</form>
			</div>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/SmoothScroll.js"></script>
	<script src="js/theme-scripts.js"></script>
</body>
</html>
