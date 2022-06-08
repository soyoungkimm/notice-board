<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="post.PostDAO"%>
<%@ page import="post.Post"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="header.jsp" %>
	
	<div class="container">
		<br><br>
		<div class="row">
			<table class="table table-success" style="text-align: center;">
			  <thead>
			    <tr>
					<th style="background-color: #eeeeee; text-align: center">글제목</th>
					<th style="background-color: #eeeeee; text-align: center">작성자</th>
					<th style="background-color: #eeeeee; text-align: center">작성일</th>
				</tr>
			  </thead>
				<tbody class="table-group-divider">
					
						<%
							PostDAO postDAO = new PostDAO();
							ArrayList<Post> list = postDAO.getList();
							for(int i=0; i < list.size(); i++){
						%>
							<tr>
								<td><a href="view.jsp?postID=<%= list.get(i).getPostID() %>"><%= list.get(i).getPostTitle()%></td>
								<td><%= list.get(i).getUserID()%></td>
								<td><%= list.get(i).getPostDate().substring(0,11) + list.get(i).getPostDate().substring(11,13)+"시 " + list.get(i).getPostDate().substring(14,16)+"분"%></td>
							</tr>
						<%		
							}
						%>
				</tbody>
			</table>
			<%-- <%
				if(pageNumber != 1){
			%>
			<a href="bbs.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if(postDAO.nextPage(pageNumber+1)){
			%>
			<a href="bbs.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-success btn-arrow-right">다음</a>
			<%		
				}
			%> --%>
			
		</div>
		<br><br>
		<div style="text-align : center" >
			<a href="write.jsp" class="btn btn-success">글작성</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>