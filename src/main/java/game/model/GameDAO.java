package game.model;

import java.util.List;

import game.domain.GameDTO;

public interface GameDAO {

	List<GameDTO> getPopularGames(); // 조회수 순 인기 게임 목록 조회
	
	List<GameDTO> getRecentGames(); // 최신 등록 게임 목록 조회
	
	GameDTO getGameDetails(int gameNumber); // 게임 상세 정보 조회

	int registerGame(GameDTO gameDTO); // 게임 등록 후 게임 일련번호 값 반환
	
	List<GameDTO> getGameListByCategory(Integer playerCnt, String selectedCategories); // 카테고리를 통한 게임 목록 조회
}
