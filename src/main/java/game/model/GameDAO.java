package game.model;

import java.util.List;

import game.domain.GameDTO;

public interface GameDAO {

	List<GameDTO> getPopularGames();
	
	List<GameDTO> getRecentGames();
}
