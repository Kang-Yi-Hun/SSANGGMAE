package game.model;

import java.util.List;

import game.domain.GameDTO;

public interface GameDAO {

	List<GameDTO> getPopularGames();
	
	List<GameDTO> getRecentGames();
	
	GameDTO getGameDetails(int gameNumber); // 게임 상세 정보 조회
}
