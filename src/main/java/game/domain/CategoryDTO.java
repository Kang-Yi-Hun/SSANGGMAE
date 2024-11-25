package game.domain;

public class CategoryDTO {

	// field
	int pkCategoryNo; /* 카테고리 일련번호 */
	String name; /* 장르명 */
	int isDelete; /* 삭제여부 유지:0 삭제:1 */
	
	// method
	public int getIsDelete() {
		return isDelete;
	}
	
	public void setIsDelete(int isDelete) {
		this.isDelete = isDelete;
	}

	public int getPkCategoryNo() {
		return pkCategoryNo;
	}

	public void setPkCategoryNo(int pkCategoryNo) {
		this.pkCategoryNo = pkCategoryNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "CategoryDTO Info------------------------"
				+ "pkCategoryNo : " + pkCategoryNo + "\n"
				+ "name : " + name + "\n"
				+ "isDelete : " + isDelete
				+ "\n------------------------------------";
	}
}
