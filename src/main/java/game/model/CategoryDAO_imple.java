package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.ProjectDBConnection;
import game.domain.CategoryDTO;

public class CategoryDAO_imple implements CategoryDAO {

	// field
	private Connection conn = ProjectDBConnection.getConn();
	private PreparedStatement pstmt;
	private ResultSet rs;

	// method
	// === 자원반납 === //
	private void close() {
		try {
			if(rs != null) { rs.close(); rs = null; }
			if(pstmt != null) { pstmt.close(); pstmt = null; }
		} catch (SQLException e) {
			e.printStackTrace();
		}	
	}// end of close()-------------------------
	
	/**
	 * (삭제되지 않은) 카테고리 목록 조회
	 */
	@Override
	public List<CategoryDTO> getCategoryList() {

		List<CategoryDTO> categoryList = new ArrayList<>();
		
		try {
			String sql = " select pk_category_no, name "
					   + " from TBL_CATEGORY "
					   + " where is_delete = 0 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); // sql문 실행
			
			while(rs.next()) {
				
				CategoryDTO categoryDTO = new CategoryDTO();
				categoryDTO.setPkCategoryNo(rs.getInt("pk_category_no"));
				categoryDTO.setName(rs.getString("name"));
				
				categoryList.add(categoryDTO);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return categoryList;
	}

}
