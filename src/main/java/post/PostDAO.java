package post;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PostDAO {
	private Connection conn;
	private ResultSet rs;

	public PostDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3307/board?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "crroba";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
	}

	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	public int write(String postTitle, String userID, String postContent) {
		String SQL = "INSERT INTO post(postTitle, userID, postDate, postContent) VALUES(?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			//pstmt.setInt(1, getNext());
			pstmt.setString(1, postTitle);
			pstmt.setString(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setString(4, postContent);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	
	public ArrayList<Post> getList(){
		String SQL = "SELECT * FROM post ORDER BY postDate DESC";
		ArrayList<Post> list = new ArrayList<Post>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				list.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Post getPost(int postID){
		String SQL = "SELECT * FROM post WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Post post = new Post();
				post.setPostID(rs.getInt(1));
				post.setPostTitle(rs.getString(2));
				post.setUserID(rs.getString(3));
				post.setPostDate(rs.getString(4));
				post.setPostContent(rs.getString(5));
				return post;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int postID, String postTItle, String postContent) {
		String SQL = "UPDATE post SET postTitle=?, postContent=? WHERE postID=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, postTItle);
			pstmt.setString(2, postContent);
			pstmt.setInt(3, postID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
	}
	
	public int delete(int postID) {
		String SQL = "delete from post WHERE postID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, postID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
	}
	
	
	public String XSSFilter(String str){
	    // javascript 문자열 제거 
	    if(str.toLowerCase().indexOf("javascript") > -1){
	        /*  대소문자 구분 없애는 정규식 
	            문자열 시작 위치에 (?i) 삽입 */
	        str = str.replaceAll("javascript", "");
	    }

	    // script 문자열 제거
	    if(str.toLowerCase().indexOf("script") > -1){
	        str = str.replaceAll("script", "");
	    }

	    return str;
	} 
}
