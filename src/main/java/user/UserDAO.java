package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Statement stmt;

	public UserDAO() {
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
	
	public String getName(String userID) {
		String name = null;
		String SQL = "SELECT userName FROM user WHERE userID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString("userName");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return name;
	}

	public int login(String userID, String userPassword) {
		
		String SQL = "SELECT userPassword FROM user WHERE userID='" + userID + "' and userPassword='" + userPassword + "'";
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL);
			if (rs.next()) {
				return 1; // 濡쒓렇�씤 �꽦怨�
			}
			else {
				return 0; // 鍮꾨�踰덊샇 遺덉씪移�
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
		
//		String SQL = "SELECT userPassword FROM user WHERE userID=?";
//		try {
//			pstmt = conn.prepareStatement(SQL);
//			pstmt.setString(1, userID);
//			rs = pstmt.executeQuery();
//			if (rs.next()) {
//				if (rs.getString(1).equals(userPassword)) {
//					return 1; // 濡쒓렇�씤 �꽦怨�
//				} else {
//					return 0; // 鍮꾨�踰덊샇 遺덉씪移�
//				}
//			}
//			return -1; // �븘�씠�뵒媛� �뾾�쓬
//		} catch (SQLException e) {
//			e.printStackTrace();
//		}
//		return -2; // �뜲�씠�꽣踰좎씠�뒪 �삤瑜�
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �뜲�씠�꽣 踰좎씠�뒪 �삤瑜�
	}

}
