<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/common.jsp" %>
    
list.mv => movieList.jsp<br>

<script type="text/javascript">

function insert() {
	location.href = "insert.mv";
}
function goUpdate(num,pageNumber){
	location.href = "update.mv?num=" + num+"&pageNumber="+pageNumber;
}
</script>
<h2 align="center">영화 정보 리스트 화면(${pageInfo.pageNumber})</h2>
<center>
총 레코드갯수 : ${totalCount }

<form action="list.mv" method="get">
	<select name="whatColumn">
		<option value="">전체 검색</option>
		<option value="genre">장르</option>
		<option value="grade">등급</option>
		<option value="actor">배우</option>
	</select>
	<input type="text" name="keyword">
	<input type="submit" value="검색">
</form>
</center>

<table border="1" align="center">
	<tr>
		<td colspan="9" align="right">
			<input type="button" value="추가하기" onClick="insert()">
		</td>
	</tr>
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>대륙</th>
		<th>제작국가</th>
		<th>장르</th>
		<th>등급</th>
		<th>출연배우</th>
		<th>삭제</th>
		<th>수정</th>
	</tr>
	<c:forEach var="ml" items="${movieLists}">
	<tr>
		<td>${ml.num}</td>
		<td><a href="">${ml.title}</a></td>
		<td>${ml.continent}</td>
		<td>${ml.nation}</td>
		<td>${ml.genre}</td>
		<td>${ml.grade}</td>
		<td>${ml.actor}</td>
		<td><a href="delete.mv?num=${ml.num}">삭제</a></td>
		<td><input type="button" onclick="goUpdate('${ml.num}','${pageInfo.pageNumber}')" value="수정"></td>
	</tr>
	</c:forEach>
</table>
<br><br>

<p align="center">
	${pageInfo.pagingHtml }
</p>


