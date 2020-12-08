<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="buy.BuyDAO" %>
<%@ page import="buy.Buy" %>
<%@ page import="cart.CartDAO" %>
<%@ page import="cart.Cart" %>
<%@ page import="java.util.ArrayList"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>

<jsp:useBean id="buy" class="buy.Buy" scope="page" />
<jsp:setProperty name="buy" property="name" />
<jsp:setProperty name="buy" property="address" />
<jsp:setProperty name="buy" property="contact" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else { 		
				int result = 0;
				BuyDAO BuyDAO = new BuyDAO();
				CartDAO CartDAO = new CartDAO();
				ArrayList<Cart> list = CartDAO.getList(1); 
				for (int i = 0; i < list.size(); i++) {
					result = BuyDAO.write_cart(list.get(i).getpID(), userID, buy.getname(), buy.getaddress(), buy.getcontact(), list.get(i).getpName(), list.get(i).getamount(), (list.get(i).getpPrice() * list.get(i).getamount()), list.get(i).getpFile()); 
					
					if(result != -1) {
						BuyDAO.update(list.get(i).getpID(), list.get(i).getamount());
					}
				} 
				
				

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('구매에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					CartDAO.Alldelete(userID);
					script.println("<script>");
					script.println("alert('구매 완료')");
					script.println("location.href='main.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
	%>
</body>
</html>