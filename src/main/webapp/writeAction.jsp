<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="post" class="post.Post" scope="page" />
<jsp:setProperty name="post" property="postTitle" />
<jsp:setProperty name="post" property="postContent" />

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
		} else {
			if (post.getPostTitle() == null || post.getPostContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {

				PostDAO postDAO = new PostDAO();
				int result = postDAO.write(post.getPostTitle(), userID, post.getPostContent());
				
				// xss 공격 막는 코드
				//String content = post.getPostContent();
				//content = postDAO.XSSFilter(content);
				//int result = postDAO.write(post.getPostTitle(), userID, content);

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.print("location.href = 'list.jsp'");
					script.println("</script>");
				}
			}

		}
	%>
</body>
</html>