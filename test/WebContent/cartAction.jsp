<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="cart.CartDAO"%>
<%@ page import="cart.Cart"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>

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
		
		int pageNumber = 1; //기본 페이지 넘버
		//페이지넘버값이 있을때
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				ArrayList<Cart> list = CartDAO.getList(pageNumber); 
				int detect = 0;
				for (int i = 0; i < list.size(); i++) {
					if(pID == list.get(i).getpID()) {
						CartDAO.update(pID);
						detect = 1;
						break;
					}
				}
				if(detect == 1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('장바구니에 등록했습니다')");
					script.println("location.href='cart.jsp'");
					script.println("</script>");
				}
				if(detect == 0) {
					int result = CartDAO.write(pID, userID, product.getpName(), product.getpPrice(), product.getpFile(), product.getpStock());
					
					if (result == -1) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('장바구니 등록에 실패했습니다')");
						script.println("history.back()");
						script.println("</script>");
					} else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('장바구니에 등록했습니다')");
						script.println("location.href='cart.jsp'");
						//script.println("history.back()");
						script.println("</script>");
					}
				}
			}
	%>
</body>
</html>