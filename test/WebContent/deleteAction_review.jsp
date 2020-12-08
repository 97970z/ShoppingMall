<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="product.ProductDAO"%>
<%@ page import="product.Product"%>
<%@ page import="review.ReviewDAO"%>
<%@ page import="review.Review"%>
<%
	request.setCharacterEncoding("UTF-8");
	//response.setContentType("text/html; charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한준's 자유게시판</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}

		
		int wID = 0;
		if(request.getParameter("wID") != null){
			wID = Integer.parseInt(request.getParameter("wID"));
		}
		
		Review review = new ReviewDAO().getReview(wID);

		if(!userID.equals(review.getUserID()) && !userID.equals("admin")) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");				
		} else {
			//ProductDAO ProductDAO = new ProductDAO();
			ReviewDAO ReviewDAO = new ReviewDAO();

			int result = ReviewDAO.delete(wID);
			
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('리뷰 삭제에 실패했습니다')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('리뷰를 삭제했습니다.')");
				script.println("history.back()");
				//script.println("location.href='main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>