package game.domain;

public class GameDTO {
	
	// field
	int pkGameNo;      /* 게임 일련번호 */
	String title;        /* 제목 */
	String intro;        /* 소개 */
	String image;        /* 이미지 */
	String link;         /* 링크 */
	int isDelete;       /* 삭제여부 기본값 0 (0:유지, 1:삭제) */
	int views;           /* 조회수 기본값 0 */
	String registerDay; /* 등록일자 기본값 SYSDATE "2024-11-20" 형태 */
	int playerCnt;      /* 게임 인원수 (0: 멀티, 1: 1인용, 2:2인용) */
	String passwd;       /* 비밀번호 SHA-256 */
	
	// insert 및 select를 위한 field
	CategoryDTO categoryDTO; /* 카테고리명 */
	

	// method
	public int getPkGameNo() {
		return pkGameNo;
	}
	
	public void setPkGameNo(int pkGameNo) {
		this.pkGameNo = pkGameNo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public int getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}

	public int getViews() {
		return views;
	}

	public void setViews(int views) {
		this.views = views;
	}

	public String getRegisterDay() {
		return registerDay;
	}

	public void setRegisterDay(String registerDay) {
		this.registerDay = registerDay;
	}

	public int getPlayerCnt() {
		return playerCnt;
	}

	public void setPlayerCnt(int playerCnt) {
		this.playerCnt = playerCnt;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	
	public CategoryDTO getCategoryDTO() {
		return categoryDTO;
	}

	public void setCategoryDTO(CategoryDTO categoryDTO) {
		this.categoryDTO = categoryDTO;
	}
	

	@Override
	public String toString() {
		return "GameDTO Info------------------------"
				+ "pkGameNo : " + pkGameNo + "\n"
				+ "title : " + title + "\n"
				+ "intro : " + intro + "\n"
				+ "image : " + image + "\n"
				+ "link : " + link + "\n"
				+ "isDelete : " + isDelete + "\n"
				+ "views : " + views + "\n"
				+ "registerDay : " + registerDay + "\n"
				+ "playerCnt : " + playerCnt + "\n"
				+ "passwd : " + passwd + "\n"
				+ "CategoryDTO : " + categoryDTO.toString()
				+ "\n------------------------------------";
	}
}
