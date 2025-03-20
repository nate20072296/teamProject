package movie.controller;
  
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.model.MovieDao;

@Controller
public class MovieCheckController {
	private final String command="title_check_proc.mv";
	
	@Autowired
	MovieDao mdao;  
	//cpdpaps
	//movieInsertFom.jsp�뿉�꽌 以묐났泥댄겕 �겢由�
	@RequestMapping(command)
	@ResponseBody	//臾몄옄 洹� �옄泥대�� �삷湲몃븣
	public String doAction(@RequestParam(value = "inputtitle",required = true)String inputtitle) {
		System.out.println("inputtitle:"+inputtitle);
		int cnt=mdao.findTitle(inputtitle);
		
		System.out.println("MCC cnt:"+cnt);
		
		if(cnt == 0) {
			//�궗�슜媛��뒫
			return "YES";
		}else {
			//�궗�슜 遺덇��뒫
			return "NO";
		}
	}
}
