<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="cart.Cart"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>
<jsp:useBean id="cart" class="cart.Cart" scope="page" />
<jsp:setProperty name="cart" property="statement" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HJ몰</title>
</head>
<body>
<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}

		int pID = 0;
		if (request.getParameter("pID") != null) {
			pID = Integer.parseInt(request.getParameter("pID"));
		}
		
		int cartID = 0;
		if (request.getParameter("cartID") != null) {
			cartID = Integer.parseInt(request.getParameter("cartID"));
		}
		
		Product product = new ProductDAO().getProduct(pID);
		
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else {   
				CartDAO CartDAO = new CartDAO();
				int result = CartDAO.delete(cartID);

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('삭제 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('장바구니에서 삭제했습니다')");
					script.println("location.href='cart.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
	%>
</body>
</html>