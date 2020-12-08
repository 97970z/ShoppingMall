<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="cart.Cart"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	a { 
		color: inherit;
	}
	h3 { text-align: center; }
</style>
<title>HJ몰</title>
</head>
<body>

<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		
		int TotalPrice = 0;
		int pageNumber = 1; //기본 페이지 넘버
		//페이지넘버값이 있을때
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}

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
		
		<section id="contact">
			<div class="container">
				<div class="row">
					<div class="col-lg-12 text-center">
						<div class="section-title">
							<h2>장바구니</h2>
							<p></p>
						</div>
					</div>
					<hr style="border: solid 1px black;">
				</div>
				<div class="row">
					<section>
					<h3>상품</h3>
					</section>
					<table style="text-align: center; border: 0px">
							<%
								CartDAO CartDAO = new CartDAO();
								ArrayList<Cart> list = CartDAO.getList(pageNumber); 
								for (int i = 0; i < list.size(); i++) {
									int cartID = list.get(i).getcartID();
									if(list.get(i).getuserID().equals(userID)) {
							%>
							<tr>
								<td>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>
									<img src="images/<%=list.get(i).getpFile() %>" width="250" height="200" class="img-responsive" alt="author">
								</td>
								<td>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
								<td>
									<h2><b><%=list.get(i).getpName()%></b></h2>
									<h3><%=df.format(list.get(i).getpPrice()) %>원 / 수량 : <%=list.get(i).getamount() %></h3>
									<form method="post" action="cartDelete.jsp?cartID=<%=cartID %>">
									<input type="submit" class="btn" value="삭제">
									</form>
								</td>
							</tr>
							<%
									}
								}
								
							%>
					</table>
					<hr style="border: solid 1px black;">
				</div>
				<div class="row">
					<div class="col-lg-12 text-center">
						<div class="section-title">
							<h3>선택상품</h3>
							<p></p>
							<%
							for (int i = 0; i < list.size(); i++) {
								if(list.get(i).getuserID().equals(userID)) {
								TotalPrice = TotalPrice + (list.get(i).getpPrice() * list.get(i).getamount());
							%>
							<h3><b><%=list.get(i).getpName()%></b></h3>
							<%
									}
								}
							%>
							<hr style="border: solid 1px black;">
							<h3>총 가격</h3>
							<h3><b><%=df.format(TotalPrice) %>원</b></h3>
						</div>
					</div>
				</div>
					<div class="row">
						<div class="col-lg-12 text-center">
							<div class="section-title">
								<form method="post" action="order_cart.jsp">
									<input style="width:150px;" type="submit" class="btn" value="구매">
								</form>
							</div>
						</div>
					</div>
			</div>
		</section>
		
	<br><br><br><br><br><br>
	<footer>
			<div class="container text-center">
				<p>made by <a href="main.jsp"><span>HanJun</span>ShoppingMall</a></p>
			</div>
	</footer>
</body>
</html>