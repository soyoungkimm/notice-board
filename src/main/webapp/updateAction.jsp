<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.Post"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if ((String) session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
		int postID = 0;
		if (request.getParameter("postID") != null) {
			postID = Integer.parseInt(request.getParameter("postID"));
		}
		if (postID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href='list.jsp'");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(postID);
		if (!userID.equals(post.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='list.jsp'");
			script.println("</script>");
		}
		else {
			if (request.getParameter("postTitle") == null || request.getParameter("postContent") == null ||
				request.getParameter("postTitle").equals("") || request.getParameter("postContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {

				PostDAO postDAO = new PostDAO();
				int result = postDAO.update(postID, request.getParameter("postTitle"),request.getParameter("postContent"));
				
				// xss 공격 막는 코드
				//String content = request.getParameter("postContent");
				//content = postDAO.XSSFilter(content);
				//int result = postDAO.update(postID, request.getParameter("postTitle"), content);

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.print("location.href = 'view.jsp?postID=" + postID + "'");
					script.println("</script>");
				}
			}

		}
	%>
</body>
</html>