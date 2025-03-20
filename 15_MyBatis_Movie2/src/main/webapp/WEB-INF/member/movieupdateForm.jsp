<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>    
movieUpdateForm.jsp<br>

<script type="text/javascript">
	var s_selbox = new Array();
	s_selbox[0] = new Array('한국','중국','베트남','네팔');
	s_selbox[1] = new Array('케냐', '가나', '세네갈');
	s_selbox[2] = new Array('스페인', '영국','덴마크','러시아','체코');
	s_selbox[3] = new Array('미국', '캐나다'); 
	s_selbox[4] = new Array('뉴질랜드','오스트레일리아');

	function firstChange(f) {
		
		for(i=f.nation.length-1; i>0; i--) {
			f.nation.options[i] = null
		}
		
		var findex = f.continent.selectedIndex;
		
		for(var i=0; i<s_selbox[findex-1].length; i++) {
			f.nation.options[i+1] = new Option(s_selbox[findex-1][i]);
		}
	}
	
</script>

<%
	//String[] nation = {"한국","중국","미국","일본","체코"};

	String[] continent = { "아시아","아프리카","유럽","아메리카","오세아니아" };
	String[][] nation = {
							{"한국","중국","베트남","네팔"},
							{"케냐", "가나", "세네갈"},
							{"스페인", "영국","덴마크","러시아","체코"},
							{"미국", "캐나다"},
							{"뉴질랜드","오스트레일리아"}
						};
	String[] genre = {"액션","스릴러","코미디","판타지","애니메이션"};
	String[] grade = {"19","15","12","7"};
	
	pageContext.setAttribute("pcontinent", continent);
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

<h2>영화 정보 수정 화면(${param.pageNumber}/${requestScope.pageNumber})</h2>
<form:form commandName="movie" action="update.mv" method="post">
${movie.continent }/${movie.nation} <br>

	<input type="hidden" name="num" value="${movie.num }">
	<input type="hidden" name="pageNumber" value="${param.pageNumber}">
	<p>
		<label>영화 제목 : </label>
		<input type="text" name="title" value="${movie.title }">
	</p>
	<%-- <p>
		<label>나라 : </label>
		<select name="nation">
			<option value="">나라 선택하세요</option>
			<c:forEach var="nt" items="${pnation }">
				<option value="${nt }" <c:if test="${movie.nation == nt }">selected</c:if>>${nt }</option>
			</c:forEach>
		</select>
		<form:errors cssClass="err" path="nation"/>
	</p> --%>
	
	<p  style="float:left">
		<label>대륙 </label>
		<select name="continent" onChange="firstChange(this.form)">
			<option value="">대륙 선택하세요</option>
				<c:forEach var="i" begin="0" end="${fn:length(pcontinent)-1 }" step="1">
					<option value="${pcontinent[i] }" <c:if test="${movie.continent == pcontinent[i] }">selected</c:if>>${pcontinent[i] }</option>
				</c:forEach>
		</select>
		<form:errors cssClass="err" path="continent"/>
	</p>
 
	<p  style="float:left">
		<label>나라 </label>
		<select name="nation">
			<option value="">나라 선택하세요</option>
			<c:forEach var="i" begin="0" end="${fn:length(pcontinent)-1}"> <!-- i=0 -->
				<c:if test="${movie.continent  == pcontinent[i]}"> <!-- 아프리카 == 아시아(x) 아프리카 == 아프리카(O) -->
					<c:forEach var="j" begin="0" end="${fn:length(pnation[i])-1}">
						<option value="${pnation[i][j] }" <c:if test="${movie.nation == pnation[i][j]}">selected</c:if>>${pnation[i][j]}</option>
					</c:forEach>
				</c:if>
			</c:forEach>
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
		<input type="submit" value="수정하기" >
	</p>
</form:form>






