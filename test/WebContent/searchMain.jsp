<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>

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
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.1/css/all.css">
<link href="css/style.css" rel="stylesheet">

<style>
	.jumbotron{
		background-size:cover;
		background-color:#FFBEBE;
		color:WHITE;
	}
	div{
		text-align: center;
	}
	img { 
		max-width: 100%;
  		height: auto;
		margin: 0px auto; 
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
		int pID = 0;
		if (request.getParameter("pID") != null) {
			pID = Integer.parseInt(request.getParameter("pID"));
		}
		
		String search = request.getParameter("search");
		
		int pageNumber = 1;
		int i = 0;
		DecimalFormat df = new DecimalFormat("###,###");
	
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
	<form method="post" action="searchMain.jsp">
		<div>
		   <input type="text" class="txt" name="search" placeholder="Search" required="">
		   <button>검색</button>
	    </div>
	</form>
	 <br>
	 <div class="container">
	 	
		 <div class="jumbotron text-center">
		 		<h1><span style="color:#46FFFF">Online</span> <span style="color:#FFFA82">Shoes</span> <span style="color:#CBFF75">shop</span></h1>
		 </div>
	 </div>
	 
	<section id="team">
	 	<div class="container">
		 	<div class="row">
			 	<%
					ProductDAO productDAO = new ProductDAO();
					ArrayList<Product> list = productDAO.getSearchList(search);
					for (; i < list.size(); i++) {
						int price = list.get(i).getpPrice();
						if (i > 2) {
							break;
						}
				%>

		 		<div class="col-md-4">
					<div class="team-item">
						<div class="team-image">
							<a href="ProductDetail.jsp?pID=<%=list.get(i).getpID()%>"><img src="images/<%=list.get(i).getpFile() %>" class="img-responsive" alt="author"></a>
						</div>
						<div class="team-text">
							<h2><%=list.get(i).getpName()%></h2>
							<div class="team-position"><%=df.format(price)%>원</div>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
			<br>
			<div class="row">
		 		<%
				for (; i < list.size(); i++) {
					int price = list.get(i).getpPrice();
					if (i > 5) {
						break;
					}
				%>
		 		<div class="col-md-4">
					<div class="team-item">
						<div class="team-image">
							<a href="ProductDetail.jsp?pID=<%=list.get(i).getpID()%>"><img src="images/<%=list.get(i).getpFile() %>" class="img-responsive" alt="author"></a>
						</div>
						<div class="team-text">
							<h2><%=list.get(i).getpName()%></h2>
							<div class="team-position"><%=df.format(price)%>원</div>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
			<br>
			<div class="row">
			 	<%
					for (; i < list.size(); i++) {
						int price = list.get(i).getpPrice();
						if (i > 8) {
							break;
						}
				%>
		 		<div class="col-md-4">
					<div class="team-item">
						<div class="team-image">
							<a href="ProductDetail.jsp?pID=<%=list.get(i).getpID()%>"><img src="images/<%=list.get(i).getpFile() %>" class="img-responsive" alt="author"></a>
						</div>
						<div class="team-text">
							<h2><%=list.get(i).getpName()%></h2>
							<div class="team-position"><%=df.format(price)%>원</div>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
			<br>
			<div class="row">
			 	<%
					for (; i < list.size(); i++) {
						int price = list.get(i).getpPrice();
						if (i > 11) {
							break;
						}
				%>
		 		<div class="col-md-4">
					<div class="team-item">
						<div class="team-image">
							<a href="ProductDetail.jsp?pID=<%=list.get(i).getpID()%>"><img src="images/<%=list.get(i).getpFile() %>" class="img-responsive" alt="author"></a>
						</div>
						<div class="team-text">
							<h2><%=list.get(i).getpName()%></h2>
							<div class="team-position"><%=df.format(price)%>원</div>
						</div>
					</div>
				</div>
				<%
					}
				%>
			</div>
			<br>
		</div>
	</section>
	 
	 <br><br><br><br><br><br>
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