package game.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import common.ProjectDBConnection;
import game.domain.CategoryDTO;
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
	
	/**
	 * 조회수 순 인기 게임 목록 조회
	 */
	@Override
	public List<GameDTO> getPopularGames() {

		List<GameDTO> gameList = new ArrayList<>();
		
		try {
			// TODO: 현재 조회수 순 인기 게임이 아닌 그냥 게임 목록을 불러오는 SQL문입니다.
			// 게임, 게임_카테고리, 카테고리 테이블을 pk_game_no와 pk_category_no를 기준으로 join해서 4개까지 불러오고 있습니다.
			// 조회수순, 삭제되었는지 여부를 고려해서 SQL문을 수정해 주시기 바랍니다.
			String sql = " select pk_game_no, title, intro, image, link, player_cnt, passwd, pk_category_no, c.name as category_name "
					   + " from TBL_GAME G join TBL_GAME_CATEGORY GC "
					   + " on G.pk_game_no = GC.fk_game_no "
					   + " join tbl_category C "
					   + " on GC.fk_category_no = C.pk_category_no"
					   + " where rownum <= 4 "
					   + " order by views desc ";
			
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
				
				// 카테고리명을 담기 위해 CategoryDTO를 GameDTO 안에 담았습니다.
				CategoryDTO categoryDTO = new CategoryDTO();
				categoryDTO.setPkCategoryNo(rs.getInt("pk_category_no"));
				categoryDTO.setName(rs.getString("category_name"));
				
				gameDTO.setCategoryDTO(categoryDTO);
				
				gameList.add(gameDTO);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return gameList;
	}

	/**
	 * 최신 등록 게임 목록 조회
	 */
	@Override
	public List<GameDTO> getRecentGames() {
		List<GameDTO> Recent_gameList = new ArrayList<>();
		
		try {
			String sql = " select pk_game_no, title, intro, image, link, player_cnt, passwd, pk_category_no, c.name as category_name "
					   + " from TBL_GAME G join TBL_GAME_CATEGORY GC "
					   + " on G.pk_game_no = GC.fk_game_no "
					   + " join tbl_category C "
					   + " on GC.fk_category_no = C.pk_category_no"
					   + " where rownum <= 4 "
					   + " order by register_day desc";
			
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
				
				// 카테고리명을 담기 위해 CategoryDTO를 GameDTO 안에 담았습니다.
				CategoryDTO categoryDTO = new CategoryDTO();
				categoryDTO.setPkCategoryNo(rs.getInt("pk_category_no"));
				categoryDTO.setName(rs.getString("category_name"));
				
				Recent_gameList.add(gameDTO);
			}
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return Recent_gameList;
	}
  
	/*
	 * 게임 상세 정보 조회
	 */
   @Override
   public GameDTO getGameDetails(int gameNumber) {
      GameDTO gameDTO = new GameDTO(); // GameDTO 객체 초기화
      
      try {
         
         String sql    = " select title, intro, image, link, views, register_day, player_cnt, passwd "
                  + " from tbl_game "
                  + " where pk_game_no = ? and is_delete = 0";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setInt(1, gameNumber);
         
         rs = pstmt.executeQuery();
         
         if(rs.next()) {
            gameDTO.setTitle(rs.getString("title"));
            gameDTO.setIntro(rs.getString("intro"));
            gameDTO.setImage(rs.getString("image"));
            gameDTO.setLink(rs.getString("link"));
            
            gameDTO.setViews( (rs.getInt("views") + 1 ));
            gameDTO.setRegisterDay(rs.getString("register_day"));
            gameDTO.setPlayerCnt(rs.getInt("player_cnt"));
            gameDTO.setPasswd(rs.getString("passwd"));
         }         
         else {
            gameDTO = null;
         }
         
         String sql2 = " update TBL_GAME set views = ? "
                  + " where pk_game_no = ? ";
      
         pstmt = conn.prepareStatement(sql2);
         
         pstmt.setInt(1, gameDTO.getViews());
         pstmt.setInt(2, gameNumber);
         
         pstmt.executeUpdate();
         
      } catch(SQLException e) {
         e.printStackTrace();
      } finally {
         close();
      }
      
      return gameDTO;
   }

	/**
	 * 게임 등록
	 */
	@Override
	public int registerGame(GameDTO gameDTO) {

		int pkGameNo = -1;
		
		try {
			conn.setAutoCommit(false); // 게임과 게임 카테고리를 등록해야 하므로 오토 커밋을 끈다. 둘 중 하나가 실패하면 되돌려야 하기 때문
			
			// 게임 시퀀스 번호를 두 번 써야 하므로 먼저 시퀀스 번호를 알아온다. //
			String sql = " select seq_game_no.nextval as pk_game_no from dual ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(); // sql문 실행
			
			if(!rs.next()) { // 게임 시퀀스 번호 조회를 실패한 경우 오류 발생
				throw new SQLException("게임 시퀀스 번호 조회 중 오류 발생"); 
			}
			///////////////////////////////////////////////////
			
			// 게임 테이블에 게임 등록 //
			pkGameNo = Integer.parseInt(rs.getString("pk_game_no"));
			
			sql = " insert into TBL_GAME(pk_game_no, title, intro, image, link, player_cnt, passwd) "
					   + " values(?, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pkGameNo); // "1" 같은 형태가 되지만 숫자로 호환
			pstmt.setString(2, gameDTO.getTitle());
			pstmt.setString(3, gameDTO.getIntro());
			pstmt.setString(4, gameDTO.getImage());
			pstmt.setString(5, gameDTO.getLink());
			pstmt.setInt(6, gameDTO.getPlayerCnt());
			pstmt.setString(7, gameDTO.getPasswd());
			
			int result = pstmt.executeUpdate(); // sql문 실행
			
			if(result != 1) { // 게임 테이블에 게임 등록을 실패한 경우 오류 발생
				throw new SQLException("게임 등록 중 오류 발생"); 
			}
			///////////////////////////////////////////////////
			
			// 게임_카테고리 등록 //
			sql = " insert into TBL_GAME_CATEGORY(pk_game_category_no, fk_game_no, fk_category_no) "
				+ " values(seq_game_category_no.nextval, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pkGameNo); // "1" 같은 형태가 되지만 숫자로 호환
			pstmt.setInt(2, gameDTO.getCategoryDTO().getPkCategoryNo());

			result = pstmt.executeUpdate(); // sql문 실행

			if(result != 1) { // 카테고리 테이블에 게임 등록을 실패한 경우 오류 발생
				throw new SQLException("게임 등록 중 오류 발생"); 
			}
			///////////////////////////////////////////////////
				
			conn.commit(); // 모든게 성공하면 커밋
			
		} catch(SQLException e) {
			try {
				conn.rollback(); // 실패시 롤백
				pkGameNo = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			close();
		}
		
		return pkGameNo;
	}

}
