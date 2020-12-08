<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="favicon.ico">
<link href="css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<link href="css/style.css" rel="stylesheet">
<title>HJ몰</title>
</head>
<body style="background-color:#FFFFFF">
	<%
		//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
		String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		} 

		int pID = 0;
		if (request.getParameter("pID") != null) {
			pID = Integer.parseInt(request.getParameter("pID"));
		}

		if (pID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글 입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}

		Product product = new ProductDAO().getProduct(pID);
		if(!userID.equals("admin")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");				
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
							<a class="page-scroll"><span style="color:#3366FF"><%=userID %>님 환영합니다 !</span></a>
						</li>
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
							<a class="page-scroll"><span style="color:#3366FF"><%=userID %>님 환영합니다 !</span></a>
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
						}
						%>
					</ul>
				</div>
				<!-- /.navbar-collapse -->
			</div>
			<!-- /.container-fluid -->
		</nav>

	<!-- 게시판 --> 
	<div class="container">
		<div class="row">
			<div class="col-lg-12 text-center">
				<div class="section-title">
					<h2>상품 수정</h2>
					<p></p>
				</div>
			</div>			
			<form method="post" action="updateAction.jsp?pID=<%=pID %> ">
				<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" class="form-control" placeholder="Product Name *" value="<%=product.getpName() %>" name="pName" required="" data-validation-required-message="Please enter Product name.">
										<p class="help-block text-danger"></p>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<input type="text" class="form-control" placeholder="Price *" name="pPrice" value="<%=product.getpPrice() %>" required="" data-validation-required-message="Please enter Product Price.">
										<p class="help-block text-danger"></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<textarea class="form-control" placeholder="Product detailed description *" name="pExp" required="" data-validation-required-message="Please enter detailed description."><%=product.getpExp() %></textarea>
										<p class="help-block text-danger"></p>
									</div>
								</div>
								<div class="clearfix"></div>
							</div>
							<div class="row">
								<div class="col-md-3">
									<div class="form-group">
										<input type="text" class="form-control" placeholder="Stock *" name="pStock" value="<%=product.getpStock() %>" required="" data-validation-required-message="Please enter Product Stock.">
										<p class="help-block text-danger"></p>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-lg-12 text-center">
									<div id="SelectImage"></div>
										<input type="file" name="pFile" required="required">
									</div>
							</div>
							<div class="row">
								<div class="col-lg-12 text-center">
									<div id="success"></div>
									<input type="submit" class="btn" value="Submit">
								</div>
							</div>	
			</form>
		</div>
	</div>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<footer>
			<div class="container text-center">
				<p>made by <a href="main.jsp"><span>HanJun</span>ShoppingMall</a></p>
			</div>
	</footer>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/SmoothScroll.js"></script>
	<script src="js/theme-scripts.js"></script>
</body>

</html>