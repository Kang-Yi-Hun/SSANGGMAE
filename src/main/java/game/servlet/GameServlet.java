package game.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import game.domain.CategoryDTO;
import game.domain.GameDTO;
import game.model.*;

@MultipartConfig(
	location = "/",
	maxFileSize = -1, // 파일 최대 크기
	maxRequestSize = -1,
	fileSizeThreshold = 1024)
@WebServlet("/")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final GameDAO gameDAO = new GameDAO_imple(); // 재할당, 재선언을 막기 위한 DAO 초기화
	
	private final CategoryDAO categoryDAO = new CategoryDAO_imple(); // 재할당, 재선언을 막기 위한 DAO 초기화
	
	// HttpServletRequest 객체는 요청하기 위한 모든 정보를 담는다 (헤더 정보, 파라미터, 쿠키, URI, URL 등)
	// HttpServletResponse 객체는 응답코드, 응답 메시지 등을 전송한다.
	
	// GET 요청이면 해당 메소드로 요청을 받는다. 그러나 여기서는 따로 만든 process 메소드로 모든 요청을 한꺼번에 처리
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	// POST 요청이면 해당 메소드로 요청을 받는다. 그러나 여기서는 따로 만든 process 메소드로 모든 요청을 한꺼번에 처리
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	/*
	 * 모든 요청에 대해 URI를 확인 후 요청에 맞게 메소드를 실행하는 처리 메소드
	 */
	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI(); // URI를 가져옴

		if (uri.endsWith("/game")) {
			games(req, resp);
		} else if (uri.endsWith("/game_details")) {
			game_details(req, resp);
		} else if (uri.endsWith("/game_register")) {
			game_register(req, resp);
		} else if (uri.endsWith("/game_register_action")) {
			game_register_action(req, resp);
		} else if (uri.endsWith("/popular_game")) { 
			game_popular(req, resp);
		} else if (uri.endsWith("/Recentgame")) {
			game_recent(req, resp);
		} else if (uri.endsWith("/browse")) {
			game_list_by_category(req, resp);
		}
		else if (uri.endsWith("/")) {
			main(req, resp);
		} 
	}

	/*
	 * 메인 홈 페이지로 연결하는 메소드
	 */
	private void main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/index.jsp");
	}

	/*
	 *  게임 등록 화면으로 연결하는 메소드
	 */
	private void game_register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		CategoryDAO categoryDAO = new CategoryDAO_imple();
		
		List<CategoryDTO> categoryList = categoryDAO.getCategoryList(); // 게임 카테고리 목록 조회
		
		req.setAttribute("categoryList", categoryList);
		
		forward(req, resp, "/game_register.jsp");
	}

	/*
	 * 등록한 이미지 파일의 이름을 가져오는 메소드
	 */
	private static String getFilename(Part part) {
        // courtesy of BalusC : http://stackoverflow.com/a/2424824/281545
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim()
                        .replace("\"", "");
                return filename.substring(filename.lastIndexOf('/') + 1)
                        .substring(filename.lastIndexOf('\\') + 1); // MSIE fix.
            }
        }
        return null;
    }
	
	/*
	 * 게임 등록하기 버튼을 눌렀을 때 실행
	 */
	private void game_register_action(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		GameDTO gameDTO = new GameDTO();
		
		gameDTO.setTitle(req.getParameter("title")); // 게임 제목
		gameDTO.setIntro(req.getParameter("intro")); // 게임 설명
		gameDTO.setLink(req.getParameter("link"));   // 게임 링크
		
		// 이미지 //
		Part part = req.getPart("image");
		if("".equals(getFilename(part))) { // 파일명이 공백인 경우 == 이미지를 업로드하지 않은 경우
    		gameDTO.setImage("");
		}
		else { // 이미지를 업로드한 경우
			String uploadPath = req.getServletContext().getRealPath(req.getContextPath());
			if(uploadPath.endsWith("SSANGGAME")) { // 끝에 \SSANGGAME\SSANGGAME 로 끝나는 경우
				uploadPath = uploadPath.substring(0, uploadPath.lastIndexOf("SSANGGAME")); // 끝에 SSANGGAME을 자른다.
			}
			uploadPath = uploadPath + "images/game/";
			
			File uploadDir = new File(uploadPath); // 이미지 업로드 폴더 객체 생성
			System.out.println("이미지 업로드 경로 : " + uploadDir.getPath());
			File image = null; // 이미지 파일 객체 생성
			
			if(!uploadDir.exists()) { // 이미지 업로드 폴더가 없으면
				if(!uploadDir.mkdir()) { // 폴더 생성
					System.out.println("이미지 업로드 폴더 생성 실패");
				}
			}
			
			if(uploadDir.exists()) { // 업로드 폴더 존재하는지 다시 확인
		        image = new File(uploadPath, System.currentTimeMillis() + "_"
		            + getFilename(part));
		        final String absolutePath = image.getAbsolutePath();
		        part.write(absolutePath);
			}
			
	        if(image != null) {
	    		gameDTO.setImage(image.getName());
	    		System.out.println(image.getName());
	        }
		}
		// 이미지 끝 //
		
		// 게임 인원수
		if(Integer.parseInt(req.getParameter("player_cnt")) == -1) {
			return;
		}
		gameDTO.setPlayerCnt(Integer.parseInt(req.getParameter("player_cnt")));

		// 게임 카테고리
		if(Integer.parseInt(req.getParameter("category")) == -1) {
			return;
		}
		CategoryDTO categoryDTO = new CategoryDTO();
		categoryDTO.setPkCategoryNo(Integer.parseInt(req.getParameter("category")));
		gameDTO.setCategoryDTO(categoryDTO);
		
		// TODO: 비밀번호는 나중에 sha-256 방식으로 저장되도록 수정해야 한다.
		gameDTO.setPasswd(req.getParameter("passwd"));
		
		int pkGameNo = gameDAO.registerGame(gameDTO);
		
		if(pkGameNo != -1) { // 데이터베이스 등록 성공
			resp.setContentType("text/html; charset=UTF-8");
			
			HttpSession session = req.getSession(true); // 세션 사용
			
			session.setAttribute("gameNumber", pkGameNo); // 등록한 게임 상세정보를 보여주기 위해 게임 일련번호를 저장
			resp.sendRedirect(req.getContextPath() + "/game"); // 새로고침시 양식 다시 제출이 뜨지 않게 하기 위해 redirect
		}
		else { // 데이터베이스 등록 실패
			resp.setContentType("text/html; charset=UTF-8");
		    PrintWriter out = resp.getWriter();
		    out.println("<script>alert('게임 등록에 실패했습니다. 개발자를 찾지 마세요.'); location.href='" + req.getContextPath() + "/game';</script>");
		    out.flush();
		    out.close();
		}
	}
	
	// TODO 혹시 사용하지 않는 메소드라면 지워주세요
	private void games(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<GameDTO> gameList = gameDAO.getPopularGames();
		
		// 이미지 경로 설정
		for(GameDTO gameDTO: gameList) {
			if(gameDTO.getImage() != null && !gameDTO.getImage().startsWith("http")) {
				gameDTO.setImage(req.getContextPath() + "/images/game/" + gameDTO.getImage());
			}
		}
		
		req.setAttribute("gameList", gameList);
		
		// 최신등록게임 리스트 불러오기
		List<GameDTO> Recent_gameList = gameDAO.getRecentGames();

		// 이미지 경로 설정
		for(GameDTO gameDTO: Recent_gameList) {
			if(gameDTO.getImage() != null && !gameDTO.getImage().startsWith("http")) {
				gameDTO.setImage(req.getContextPath() + "/images/game/" + gameDTO.getImage());
			}
		}
		
		// 뭔지 모르겠으나 이걸로 했어요
		req.setAttribute("Recent_gameList", Recent_gameList);
		
		forward(req, resp, "/game.jsp");
	}
	
	/*
	 * 인기게임 페이지 리스트 조회 메소드
	 */
	private void game_popular(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<GameDTO> PopulargameList = gameDAO.getPopularGamesAll();
		
		// 이미지 경로 설정
		for(GameDTO gameDTO: PopulargameList) {
			if(gameDTO.getImage() != null && !gameDTO.getImage().startsWith("http")) {
				gameDTO.setImage(req.getContextPath() + "/images/game/" + gameDTO.getImage());
			}
		}
		
		req.setAttribute("PopulargameList", PopulargameList);
		
		forward(req, resp, "/popular_game.jsp");
	}

	/*
	 * 최신등록게임 리스트 조회 메소드
	 */
	private void game_recent(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 최신등록게임 리스트 불러오기
		List<GameDTO> Recent_gameList = gameDAO.getRecentGames();

		// 이미지 경로 설정
		for(GameDTO gameDTO: Recent_gameList) {
			if(gameDTO.getImage() != null && !gameDTO.getImage().startsWith("http")) {
				gameDTO.setImage(req.getContextPath() + "/images/game/" + gameDTO.getImage());
			}
		}
		
		// 뭔지 모르겠으나 이걸로 했어요
		req.setAttribute("Recent_gameList", Recent_gameList);
		
		forward(req, resp, "/Recentgame.jsp");
	}
	
	/*
	 * 게임에 대한 상세 모달로 연결하는 메소드
	 */
	private void game_details(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int gameNumber = Integer.parseInt(req.getParameter("gameNumber")); // game pk 값
			
			GameDTO gameDTO = gameDAO.getGameDetails(gameNumber); // 게임 상세 정보가 담긴 gameDTO 조회
			
			if(gameDTO == null) {
				System.out.println("요청한 gameDTO가 존재하지 않습니다.");
				// TODO 예외처리..
			}
			else {
				// 이미지 경로 설정
				if(gameDTO.getImage() != null && !gameDTO.getImage().startsWith("http")) {
					gameDTO.setImage(req.getContextPath() + "/images/game/" + gameDTO.getImage());
				}
				
				req.setAttribute("gameDTO", gameDTO);
			}
			
		} catch (NumberFormatException e) {
			// TODO 로그 대용
			System.out.println("gameNumber의 값이 올바르지 않습니다.");
		}
		
		forward(req, resp, "/game_details.jsp");
	}
	
	/*
	 * 카테고리에 의한 게임 목록 조회 메소드
	 */
	private void game_list_by_category(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String selectedCategories = req.getParameter("categories"); // 선택된 카테고리 pk들의 문자열 ex) '1, 2'
		
		//TODO NumberFormatException 예외 처리해야됨
		//TODO 리팩토링 필요
		Integer playerCnt = (req.getParameter("playerCnt") == null || req.getParameter("playerCnt").isBlank()) ? 3 : Integer.parseInt(req.getParameter("playerCnt"));
		String playerCount = "";
		
		List<GameDTO> gameList = gameDAO.getGameListByCategory(playerCnt, selectedCategories);
		List<CategoryDTO> categoryList = categoryDAO.getCategoryList();
		
		switch(playerCnt) {
		case 0 : playerCount = "멀티"; break;
		case 1 : playerCount = "1인칭"; break;
		case 2 : playerCount = "2인칭"; break;
		case 3 : playerCount = "전체"; break;
		default : playerCount = "전체"; playerCnt = 3; break;
		}
		
		req.setAttribute("gameList", gameList);
		req.setAttribute("categoryList", categoryList);
		req.setAttribute("selectedCategories", selectedCategories == null ? null : selectedCategories.split(","));
		req.setAttribute("playerCount", playerCount);
		req.setAttribute("playerCnt", String.valueOf(playerCnt));
		
		forward(req, resp, "/game_browse.jsp");
	}
	
	/*
	 * 처리된 요청과 응답과 함께 특정 경로의 JSP파일을 불러오는 메소드 
	 */
	public void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
}
