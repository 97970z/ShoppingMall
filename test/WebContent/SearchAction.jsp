<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
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
		
		String search = null;
		if (session.getAttribute("search") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			search = (String) session.getAttribute("search");//유저아이디에 해당 세션값을 넣어준다.
		}
		
		int pageNumber = 1; //기본 페이지 넘버
		//페이지넘버값이 있을때
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		
		Product product = new ProductDAO().getProduct(pID);
		
  
		ProductDAO ProductDAO = new ProductDAO();
		ProductDAO.getSearchList(search);
				
		PrintWriter script = response.getWriter();
		script.println("<script>");
		//script.println("alert('장바구니 등록에 실패했습니다')");
		script.println("location.href='searchMain.jsp'");
		script.println("</script>");
	%>
</body>
</html>