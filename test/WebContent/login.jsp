<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
							<a class="page-scroll" href="StockManagement.jsp">재고관리</a>
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
							<a class="page-scroll" href="StockManagement.jsp">주문내역</a>
						</li>
						<li>
							<a class="page-scroll" href="StockManagement.jsp">장바구니</a>
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
 <br><br><br><br><br><br>
	  <div class="col-lg-4"></div>
		  <div class="col-lg-4">
		  <!-- 점보트론 -->
		   <div class="jumbotron" style="padding-top: 20px;">
			   <!-- 로그인 정보를 숨기면서 전송post -->
			   <form method="post" action="loginAction.jsp">
			    <h3 style="text-align: center;">로그인</h3>
				    <div class="form-group">
				     	<input type="text" class="form-control" placeholder="USER ID *" name="userID" maxlength="20" required="" data-validation-required-message="Please enter USER ID.">
				    </div>
				    <div class="form-group">
				     	<input type="password" class="form-control" placeholder="PASSWORD *" name="userPassword" maxlength="20" required="" data-validation-required-message="Please enter PASSWORD.">
				    </div>

			    	<input type="submit" class="btn btn-success form-control" value="로그인">
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
