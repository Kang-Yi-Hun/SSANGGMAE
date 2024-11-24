package game.model;

import java.util.List;

import game.domain.CategoryDTO;

public interface CategoryDAO {

	// (삭제되지 않은)카테고리 목록 조회
	List<CategoryDTO> getCategoryList();
}
