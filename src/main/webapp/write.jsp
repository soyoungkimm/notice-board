<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ include file="header.jsp" %>
	<div class="container">
	<br><br>
		<div class="row">
			<form action="writeAction.jsp" method="post">
				<table class="table table-success
					style="text-align: center;">
					<thead>
						<tr>
							<td colspan="2"	style="background-color: #eeeeee; text-align: center">글쓰기</td>
						</tr>
					</thead>
					<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="postTitle" maxlength="50"></td>
					</tr>
					<tr>	
						<td><textarea class="form-control" placeholder="글 내용"name="postContent" maxlength="2048" style="height: 350px;"></textarea></td>
					</tr>
					</tbody>
				</table>
				<div style="text-align : center" >
					<input type="submit" class="btn btn-success" value="저장">
				</div>
			</form>
		</div>
		<br><br>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pprn3073KE6tl6bjs2QrFaJGz5/SUsLqktiwsUTF55Jfv3qYSDhgCecCxMW52nD2" crossorigin="anonymous"></script>
</body>
</html>