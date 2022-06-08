<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.Post"%>
<%@ page import="post.PostDAO"%>
<%@ include file="header.jsp" %>

	<%
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
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
			script.println("location.href='post.jsp'");
			script.println("</script>");
		}
		Post post = new PostDAO().getPost(postID);
		if (!userID.equals(post.getUserID())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='post.jsp'");
			script.println("</script>");
		}
	%>

	<div class="container">
		<br><br>
		<div class="row">
			<form action="updateAction.jsp?postID=<%=postID%>" method="post">
				<table class="table table-success" style="text-align: center;">
					<thead>
						<tr>
							<td colspan="2"
								style="background-color: #eeeeee; text-align: center">
								글 수정</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="postTitle" maxlength="50"
								value="<%=post.getPostTitle()%>"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="postContent" maxlength="2048" style="height: 350px;"><%=post.getPostContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<div style="text-align : center" >
			<input type="submit" class="btn btn-success pull-right" value="저장">
		</div>
			</form>
		</div>
		<br><br>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>