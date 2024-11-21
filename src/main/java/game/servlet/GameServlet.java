package game.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import game.domain.GameDTO;
import game.model.*;

@WebServlet("/")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private final GameDAO gameDAO = new GameDAO_imple();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		process(req, resp);
	}

	protected void process(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		String uri = req.getRequestURI();

		if (uri.contains("game.do")) {
			games(req, resp);
		} else if (uri.contains("game_details.do")) {
			game_details(req, resp);
		} else if (uri.contains("main.do")) {
			main(req, resp);
		} 
	}

	private void main(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		forward(req, resp, "/main.jsp");
	}

	private void games(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		GameDAO gameDAO = new GameDAO_imple();
		List<GameDTO> gameList = gameDAO.getPopularGames();
		
		req.setAttribute("gameList", gameList);
		
		forward(req, resp, "/game.jsp");
	}

	private void game_details(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("시작");
		try {
			int gameNumber = Integer.parseInt(req.getParameter("gameNumber")); // game pk 값
			
			GameDTO gameDTO = gameDAO.getGameDetails(gameNumber); // 게임 상세 정보가 담긴 gameDTO 조회
			
			if(gameDTO == null) {
				System.out.println("요청한 gameDTO가 존재하지 않습니다.");
				// 예외처리..
			}
			else {
				System.out.println("됨");
				req.setAttribute("gameDTO", gameDTO);
			}
			
		} catch (NumberFormatException e) {

			// 로그 대용
			System.out.println("gameNumber의 값이 올바르지 않습니다.");
		}
		
		forward(req, resp, "/game_details.jsp");
	}
	
	public void forward(HttpServletRequest req, HttpServletResponse resp, String path) throws ServletException, IOException {
		RequestDispatcher rd = req.getRequestDispatcher(path);
		rd.forward(req, resp);
	}
}
