<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>


<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->
<jsp:useBean id="product" class="product.Product" scope="page" />
<jsp:setProperty name="product" property="pName" />
<jsp:setProperty name="product" property="pExp" />
<jsp:setProperty name="product" property="pStock" />
<jsp:setProperty name="product" property="pPrice" />
<jsp:setProperty name="product" property="pFile" />
<%
	System.out.println(product);
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

		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		} else { 
				ProductDAO ProductDAO = new ProductDAO();
				int result = ProductDAO.write(product.getpName(), product.getpExp(), product.getpStock(), product.getpPrice(), product.getpFile());

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('상품 등록에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='main.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
	%>
</body>

</html>