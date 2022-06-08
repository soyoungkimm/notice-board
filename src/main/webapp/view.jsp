<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="post.Post"%>
<%@ page import="post.PostDAO"%>

<%@ include file="header.jsp" %>
	<%
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
	%>
	
	<div class="container">
		<br><br>
		<div class="row">

			<table class="table table-success"
				style="text-align: center;">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center">글 보기
						</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
				<tr>
					<td style="width: 20%;">글 제목</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%=post.getPostTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
				</tr>
				<tr>
					<td style="width: 20%;">작성자</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%=post.getUserID()%></td>
				</tr>
				<tr>
					<td style="width: 20%;">작성일자</td>
					<td colspan="2" style="min-height: 200px; text-align: left;"><%=post.getPostDate().substring(0, 11) + post.getPostDate().substring(11, 13) + "시 "
					+ post.getPostDate().substring(14, 16) + "분"%></td>
				</tr>
				<tr>
					<td style="width: 20%;">내용</td>
					<td colspan="2" style="height: 200px; text-align: left;">
					<%-- <%=post.getPostContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %> --%>
					<%= post.getPostContent()%>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		<br><br>
		<div style="text-align : center" >
			<a href="list.jsp" class="btn btn-success">뒤로가기</a>
			<%
				if(userID != null && userID.equals(post.getUserID())){
			%>
				<a href="update.jsp?postID=<%= postID %>" class="btn btn-primary">수정</a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')"  href="deleteAction.jsp?postID=<%= postID %>" class="btn btn-danger">삭제</a>
			
			<%
				}
			%>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>