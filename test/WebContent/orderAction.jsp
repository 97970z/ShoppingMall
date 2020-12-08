<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="buy.BuyDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>
<jsp:useBean id="buy" class="buy.Buy" scope="page" />
<jsp:setProperty name="buy" property="name" />
<jsp:setProperty name="buy" property="address" />
<jsp:setProperty name="buy" property="contact" />
<jsp:setProperty name="buy" property="amount" />
<jsp:setProperty name="buy" property="price" />
<jsp:setProperty name="buy" property="file" />
<jsp:setProperty name="buy" property="pname" />
<%
	System.out.println(buy.getfile());
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

		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else { 
				BuyDAO BuyDAO = new BuyDAO(); 
				int result = BuyDAO.write(pID, userID, buy.getname(), buy.getaddress(), buy.getcontact(), buy.getpname(), buy.getamount(), buy.getprice(), buy.getfile() ); 
 
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('구매에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					BuyDAO.update(pID, buy.getamount());
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