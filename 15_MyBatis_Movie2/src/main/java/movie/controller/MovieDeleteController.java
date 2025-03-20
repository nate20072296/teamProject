package movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import movie.model.MovieDao;

@Controller
public class MovieDeleteController {
	private final String command="delete.mv";
	private final String gotoPage="redirect:/list.mv";
	
	@Autowired
	MovieDao mdao;//dkffufnasdf¤·¶÷´É¸®  
	
	@RequestMapping(command)
	public String delete(@RequestParam("num") int num) {    //kim//kim
		int cnt=mdao.delete(num);
		return gotoPage;
	}
}
