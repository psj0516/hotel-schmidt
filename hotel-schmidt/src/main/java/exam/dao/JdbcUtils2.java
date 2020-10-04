//package exam.dao;
//
//import java.sql.Connection;
//import java.sql.ResultSet;
//import java.sql.Statement;
//
//import javax.naming.Context;
//import javax.naming.InitialContext;
//import javax.sql.DataSource;
//
//public class JdbcUtils2 {
//	
//	
//	// DB연결 메소드
//	public static Connection getConnection() throws Exception {
//		Connection con = null;
//		
//		// 커넥션 풀 이용
//		Context context = new InitialContext();
//		DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/mydb");
//		con = ds.getConnection(); // 컨넥션 한개 빌려오기
//		return con;
//	}
//	
//	public static void close(Connection con, Statement stmt) {
//		close(con, stmt, null);
//	} // close
//	
//	
//	public static void close(Connection con, Statement stmt, ResultSet rs) {
//		// JDBC 객체는 사용의 역순으로 자원닫기
//		try {
//			if (rs != null) {
//				rs.close();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		try {
//			if (stmt != null) {
//				stmt.close();
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		
//		try {
//			if (con != null) {
//				con.close(); // 커넥션 반납하기
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	} // close
//	
//
//}
