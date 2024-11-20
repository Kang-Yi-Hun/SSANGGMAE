package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.ProjectDBConnection;
import game.domain.GameDTO;

public class GameDAO_imple implements GameDAO {

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
	
	@Override
	public List<GameDTO> getPopularGames() {

		List<GameDTO> gameList = new ArrayList<>();
		
		try {
			String sql = " select pk_game_no, title, intro, image, link, player_cnt, passwd, c.name as category_name "
					   + " from TBL_GAME G join TBL_GAME_CATEGORY GC "
					   + " on G.pk_game_no = GC.fk_game_no "
					   + " join tbl_category C "
					   + " on GC.fk_category_no = C.pk_category_no"
					   + " where rownum <= 4 ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery(); // sql문 실행
			
			while(rs.next()) {
				
				GameDTO gameDTO = new GameDTO();
				
				gameDTO.setPkGameNo(rs.getInt("pk_game_no"));
				gameDTO.setTitle(rs.getString("title"));
				gameDTO.setIntro(rs.getString("intro"));
				gameDTO.setImage(rs.getString("image"));
				gameDTO.setLink(rs.getString("link"));
//				gameDTO.setIsDelete(rs.getInt("is_delete"));
//				gameDTO.setViews(rs.getInt("views"));
//				gameDTO.setRegisterDay(rs.getString("register_day"));
				gameDTO.setPlayerCnt(rs.getInt("player_cnt"));
				gameDTO.setPasswd(rs.getString("passwd"));
				gameDTO.setCategoryName(rs.getString("category_name"));
				
				gameList.add(gameDTO);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return gameList;
	}

	@Override
	public List<GameDTO> getRecentGames() {
		// TODO Auto-generated method stub
		return null;
	}

}
