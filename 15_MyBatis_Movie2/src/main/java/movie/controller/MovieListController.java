package movie.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;
import utility.Paging;

@Controller
public class MovieListController {
	
	private final String command = "list.mv";
	private final String getPage = "movieList";
	
	@Autowired
	MovieDao mdao;
	
	@RequestMapping(command)
	public ModelAndView doList(
			@RequestParam(value = "whatColumn", required = false) String whatColumn,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "pageNumber", required = false) String pageNumber,
			HttpServletRequest request) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn); 
		map.put("keyword", "%" + keyword + "%"); //name : 아이유, age : 30
		
		int totalCount = mdao.getTotalCount(map);
		System.out.println("MLC totalCount : " + totalCount);
		
		String url = request.getContextPath() + "/" + command;
		System.out.println("MLC url : " + url);
		
		Paging pageInfo = new Paging(pageNumber, "2", totalCount, url, whatColumn, keyword);
		System.out.println("MLC offset : " + pageInfo.getOffset());
		System.out.println("MLC limit : " + pageInfo.getLimit());
		
		List<MovieBean> lists = mdao.getMovieList(pageInfo, map);
		
		ModelAndView mav = new ModelAndView(); 
		mav.addObject("movieLists", lists);
		mav.addObject("totalCount", totalCount);
		mav.addObject("pageInfo", pageInfo);
		
		mav.setViewName(getPage);
		return mav;
	}
	
}






