package exam.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JdbcUtils {
	// DB연결 메소드
		public static Connection getConnection() throws Exception {
			Connection con = null;

			String url = "jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=utf8&allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Seoul";
			String user = "myuser";
			String passwd = "mypass";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(url, user, passwd);

			return con;
		}
		
		public static void close(Connection con, Statement stmt) {
			close(con, stmt, null);
		} // close
		
		
		public static void close(Connection con, Statement stmt, ResultSet rs) {
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		} // close
}