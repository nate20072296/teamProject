<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>    
movieInsertForm.jsp<br>

<%
	String[] nation = {"한국","중국","미국","일본","체코"};
	String[] genre = {"액션","스릴러","코미디","판타지","애니메이션"};
	String[] grade = {"19","15","12","7"};
	
	pageContext.setAttribute("pnation", nation);
	pageContext.setAttribute("pgenre", genre);
	pageContext.setAttribute("pgrade", grade);
%>

<style type="text/css">
	.err{
		font-size: 10pt;
		color: red;
		font-weight: bold;
	}
</style>
<script type="text/javascript" src="resources/js/jquery.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		//alert(1);
		
		var isCheck = false;
		var use;
		var isChange = false;
		
		$('#title_check').click(function(){ // 중복체크
			//alert(2);
			isCheck = true;
			
			$.ajax({
				url : "title_check_proc.mv", // MovieCheckController
				type : "post",
				data : ({
					inputtitle : $('input[name=title]').val() // inputtitle = 배트맨
				}),
				success : function(data){
					
					//alert("data : " + data);
					
					if($('input[name=title]').val() == ""){
						$('#titleMessage').html("<font color=red>title 입력 누락</font>");
						$('#titleMessage').show();
						
					}else if($.trim(data) == 'YES'){
						$('#titleMessage').html("<font color=blue>사용 가능합니다.</font>");
						use = "possible";
						$('#titleMessage').show();
					}else{
						$('#titleMessage').html("<font color=red>이미 등록한 제목입니다.</font>");
						use = "impossible";
						$('#titleMessage').show();
					}
				}//success
			});//ajax
		}); // 중복 체크 click
		
		$('#btnSubmit').click(function(){ // submit 클릭했을 때
			
			if(use == "impossible"){
				alert('이미 사용중인 제목입니다.');
				return false;
				
			}else if(isCheck == false){
				alert('중복체크 하세요.');
				return false;
			}
			
		}); // submit click
		
		$('input[name=title]').keydown(function(){
			isCheck = false;
			use = "";
			$('#titleMessage').css('display','none'); 
		});
			
		
	}); // ready
	
	
	var f_selbox = new Array('아시아','아프리카','유럽','아메리카','오세아니아');

	var s_selbox = new Array();
	s_selbox[0] = new Array('한국','중국','베트남','네팔');
	s_selbox[1] = new Array('케냐', '가나', '세네갈');
	s_selbox[2] = new Array('스페인', '영국','덴마크','러시아','체코');
	s_selbox[3] = new Array('미국', '캐나다'); 
	s_selbox[4] = new Array('뉴질랜드','오스트레일리아');
	
	function init(f,mc, mn){
		alert(mc +"," + mn); // 아프리카,세네갈
		var selectedContinent;
		
		/* <option value="">대륙 선택하세요</option> 0번 옵션*/
		for(var i=0;i <f_selbox.length; i++){
			f.continent.options[i+1] = new Option(f_selbox[i]); 
			
			if(f.continent.options[i+1].value == mc){
				f.continent.options[i+1].selected = true;
				selectedContinent = i;
			}
		}//for 
		/* 
		i=0 1번 옵션 아시아
		i=1 2번 옵션 아프리카
		i=2 3번 옵션 유럽
		 */
		 
		for(var i=0;i<s_selbox[selectedContinent].length;i++){
			f.nation.options[i+1] = new Option(s_selbox[selectedContinent][i]); 
			
			if(f.nation.options[i+1].value == mn){
				f.nation.options[i+1].selected = true;
			}
		}//for
		
	}//init
	
	
	
	function firstChange(f){ // 대륙 변화 생김
		//alert('firstChange');
		
		var findex = f.continent.selectedIndex;
		var fvalue = f.continent[findex].value;
		//alert(findex +"/" + fvalue); // 1/아시아 2/아프리카
		
		for(i=f.nation.length-1 ; i>0; i--) {
			f.nation.options[i] = null;
		}
		
		/* <option value="">나라 선택하세요</option> 0번 옵션*/
		for(var i=0; i<s_selbox[findex-1].length; i++){
			f.nation.options[i+1] = new Option(s_selbox[findex-1][i]); 
		}
	}//firstChange
	
</script> 

<body onLoad="init(f, '${movie.continent }', '${movie.nation }')">
<h2>영화 정보 등록 화면</h2>
<form:form commandName="movie" action="insert.mv" method="post" name="f">
${movie.continent }/ ${movie.nation } <br>

	<p>
		<label>영화 제목 : </label>
		<input type="text" name="title" value="${movie.title }">
		<input type="button" id="title_check" value="중복체크">
		<span id="titleMessage"></span>
	</p>
 	<%-- 
	<p>
		<label>나라 : </label>
		<select name="nation">
			<option value="">나라 선택하세요</option>
			<c:forEach var="nt" items="${pnation }">
				<option value="${nt }" <c:if test="${movie.nation == nt }">selected</c:if>>${nt }</option>
			</c:forEach>
		</select>
		<form:errors cssClass="err" path="nation"/>
	</p>
 --%>
 
 	<p  style="float:left">
		<label>대륙 </label>
		<select name="continent" onChange="firstChange(this.form)">
			<option value="">대륙 선택하세요</option>
		</select>
		<form:errors cssClass="err" path="nation"/>
	</p>
 
	<p  style="float:left">
		<label>나라 </label>
		<select name="nation">
			<option value="">나라 선택하세요</option>
		</select>
		<form:errors cssClass="err" path="nation"/>
	</p>
 
	
	<p  style="clear:left">
		<label>장르 : </label>
		<c:forEach var="gn" items="${pgenre }">
			<input type="checkbox" name="genre" value="${gn }" <c:if test="${fn:contains(movie.genre, gn) }">checked</c:if>>${gn }
		</c:forEach>
		<form:errors cssClass="err" path="genre"/>
	</p>
	<p>
		<label>등급 : </label>
		<c:forEach var="gr" items="${pgrade }">
			<input type="radio" name="grade" value="${gr }" <c:if test="${movie.grade == gr }">checked</c:if>>${gr }
		</c:forEach>
		<form:errors cssClass="err" path="grade"/>
	</p>
	<p>
		<label>출연 배우 : </label>
		<input type="text" name="actor" value="${movie.actor }">
		<form:errors cssClass="err" path="actor"/>
	</p>
	<p>
		<input type="submit" value="추가하기" id="btnSubmit">
	</p>
</form:form>

</body>




