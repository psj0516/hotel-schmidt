package exam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ChartDao {
	private static ChartDao instance = new ChartDao();
	
	public static ChartDao getInstance() {
		return instance;
	}
	
	private ChartDao() {}
	
	public List<List<Object>> getBoardDate() {
		List<List<Object>> list = new ArrayList<List<Object>>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT date_format(reg_date, '%Y년 %m월') m,";
			sql += "COUNT(*) count FROM reviewb ";
			sql += "GROUP BY m; ";
			
			pstmt = con.prepareCall(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				List<Object> rowList = new ArrayList<Object>();
				rowList.add(rs.getString("m"));
				rowList.add(rs.getInt("count"));
				
				
				list.add(rowList);
			}
			
			if (list.size() > 0) {
				list.add(0, Arrays.asList("작성일", "게시글수"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("실패");
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	}

	public List<List<Object>> getAge() {
		List<List<Object>> list = new ArrayList<List<Object>>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		try {
			con = JdbcUtils.getConnection();
			
			sql = "SELECT ";
			sql += "CASE ";
			sql += "WHEN age BETWEEN 10 and 19 THEN '10대' ";
			sql += "WHEN age BETWEEN 20 and 29 THEN '20대' ";
			sql += "WHEN age BETWEEN 30 and 39 THEN '30대' ";
			sql += "WHEN age BETWEEN 40 and 49 THEN '40대' ";
			sql += "WHEN age >= 50 THEN '50대 이상' ";
			sql += "WHEN age <10 OR age IS NULL THEN '기타'";
			sql += "END as age_range ";
			sql += ", count(*) as count ";
			sql += "FROM member ";
			sql += "GROUP BY age_range; ";
			
			pstmt = con.prepareCall(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				List<Object> rowList = new ArrayList<Object>();
				rowList.add(rs.getString("age_range"));
				rowList.add(rs.getInt("count"));

				list.add(rowList);
			}
			
			if (list.size() > 0) {
				list.add(0, Arrays.asList("연령대", "회원수"));
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("실패");
		} finally {
			JdbcUtils.close(con, pstmt, rs);
		}
		return list;
	}
	
	public static void main(String[] args) {
		ChartDao dao = ChartDao.getInstance();
		List<List<Object>> list = dao.getBoardDate();

		for (List<Object> rowList : list) {
			System.out.println(rowList);
		}
		
		List<List<Object>> list2 = dao.getAge();
		for (List<Object> rowList : list2) {
			System.out.println(rowList);
		}
	}
}
