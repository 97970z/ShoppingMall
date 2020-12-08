<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="review.Review"%>
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
	img { 
			max-width: 100%;
			margin: 0px auto; 
		}
	.table {
		padding: 10px 300px;
	}
	a { 
		color: inherit;
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
		
		int pageNumber = 1; //기본 페이지 넘버
		//페이지넘버값이 있을때
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		Product product = new ProductDAO().getProduct(pID);
		
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
		<section>
			<hr>
		</section>
			<div class="container">
				<div class="row">
					<section>
					<table style="text-align: center; border: 0px">
						<tr>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<img src="images/<%=product.getpFile() %>" width="300" height="200" class="img-responsive" alt="author">
							</td>
							<td>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							</td>
							<td>
								<h1><b><%=product.getpName() %></b></h1>
								<h3>가격 : <%=df.format(product.getpPrice()) %>원 / 재고 : <%=product.getpStock() %></h3>
								
								<%
									if(userID != null && product.getpStock() >= 1) {
								%>
								<a href="order.jsp?pID=<%=pID %>"><button type="submit" class="btn">구매</button></a>
								
								<a onclick="return confirm('장바구니에 담으시겠습니까?')" href="cartAction.jsp?pID=<%=pID %>"><button type="submit" class="btn">찜</button></a>
								<%
									}
								%>
								<%
									if(userID != null && userID.equals("admin")) {
								%>
									<a href="update.jsp?pID=<%=pID %>"><button type="submit" class="btn">수정</button></a>
									<a onclick="return confirm('삭제하시겠습니까?')" href="deleteAction.jsp?pID=<%=pID %>"><button type="submit" class="btn">삭제</button></a>
								<%
									}
								%>
							</td>
						</tr>
					</table>
					</section>
					<hr>
					<h1><b>상품 설명</b></h1>
				</div>
			</div>
			<div class="container">
				<div class="row">
					<table style="text-align: center; border: 0px">
						<tr>
							<td><h3><%=product.getpExp() %></h3></td>
						</tr>
					</table>
					<hr>
					<h1><b>상품 후기</b></h1>
				</div>
			</div>
		<section>
			<div class="container">
				<div class="row">
					
						<table style="text-align: center; border: 0px">
						<thead>
							<tr>
								<th width="500"style="text-align: center;">내용</th>
								<th width="500" style="text-align: right;">작성자</th>
							</tr>
							<tr>
						</tr>
						</thead>
						<%
							ReviewDAO reviewDAO = new ReviewDAO();
							ArrayList<Review> list = reviewDAO.getList(pageNumber);
							for (int i = 0; i < list.size(); i++) {
								if(list.get(i).getpID() == pID) {
						%>
						<tr>
							<td height="50"><%=list.get(i).getContent()%></td>
							<td style="text-align: right;"><%=list.get(i).getUserID()%></td>
							<td>&nbsp;&nbsp;<a href="deleteAction_review.jsp?wID=<%=list.get(i).getwID() %>"><button style="padding: 5px 5px;" type="submit" class="btn">삭제</button></a></td>
						</tr>
						<%
								}
							}
						%>
						</table>
						<hr>
						<form method="post" action="writeAction_review.jsp?pID=<%=pID %> ">
						<textarea class="form-control" placeholder="내용" name="content" maxlength="2048" style="height: 100px;"></textarea>
						&nbsp;
						<div class="row">
							<div class="col-lg-12 text-center">
								<div id="success"></div>
								<input type="submit" class="btn" value="작성">
							</div>
						</div>
						</form>
				</div>
			</div>
		</section>
		
		<footer>
			<div class="container text-center">
				<p>made by <a href="main.jsp"><span>HanJun</span>ShoppingMall</a></p>
			</div>
		</footer>
</body>
</html>