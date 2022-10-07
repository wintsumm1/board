<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<fmt:requestEncoding value="utf-8"/>     
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css" >
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css" >
<style>
	td{text-align:center;}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function(){
		<%-- 
		
		--%>	
	});
	function goInsert(){
		location.href="${path}/boardInsertForm.do"
	}
	function goDetail(no){
		location.href="${path}/boardDetail.do?no="+no;
	}	
</script>
</head>

<body>
<div class="jumbotron text-center">
  <h2>답변형 게시판</h2>

</div>
<div class="container">
	<!-- 
	form action="호출할 controller url"
	   name="subject"  name="writer"    -->
	<form id="frm01" class="form"  method="post">
		<input type="hidden" name="curPage" value=0><!-- 하단에 js에 의해서 현재페이지 번호를 전송 -->
  	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	    <input class="form-control mr-sm-2" name="subject" placeholder="제목" 
	    	value="${boardSch.subject}"/>
	    <input class="form-control mr-sm-2" name="writer" placeholder="작성자" 
	    	value="${boardSch.writer}"/> 
	    	<!-- controller  public String boardList(Board sch)-->
	    <button class="btn btn-info" type="submit">Search</button>
	    <button class="btn btn-success" onclick="goInsert()" 
	    	type="button">등록</button>
 	</nav>
	<div class="input-group lb-3">
		<div class="input-group-prepend">
			<span class="text-center input-group-text">총 : ${boardSch.count }건</span>
		</div>
		<input  class="form-control"  />	
		<div class="input-group-append">
			<span class="text-center input-group-text">페이지 크기</span>
			<select name="pageSize" class="form-control">
				<option>3</option>
				<option>5</option>
				<option>10</option>
				<option>20</option>
				<option>30</option>
			</select>
		</div>
		<script type="text/javascript">
			// 선택된 페이지 크기 설정..
			$("[name=pageSize]").val("${boardSch.pageSize}");
			// 페이지 크기 변경시 마다, controller 단호출..
			$("[name=pageSize]").change(function(){
				$("[name=curPage]").val("1");
				$("form").submit();
			});
		</script>		
		
		
	</div>  	
 	
	</form>
	
	
	
	
	
   <table class="table table-hover table-striped">
   	<col width="10%">
   	<col width="45%">
   	<col width="15%">
   	<col width="15%">
   	<col width="15%">
    <thead>
    
      <tr class="table-success text-center">
        <th>번호</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
        <th>조회건수</th>
      </tr>
    </thead>	
    <tbody>
    	<!-- controller에서 넘겨준 모델데이터 : blist -->
    	<c:forEach var="bd" items="${blist}">
    	
    	<tr ondblclick="goDetail(${bd.no})" ><td>${bd.cnt}</td>
    	
    		<td style="text-align:left;">
    		 	<c:forEach begin="1" end="${bd.level}" varStatus="sts">
    		 		&nbsp;&nbsp;
    		 		<c:if test="${sts.count!=1 and sts.last}">
    		 			<img src="${path}/a01_img/re.png" width="25px" height="25px"/>
    		 		</c:if>
    		 	</c:forEach>
    		 	
    		 	
    			${bd.subject}
    			
    			
    		</td>
    		<td>${bd.writer }</td>
    		<td><fmt:formatDate value="${bd.regdte}"/>
    		</td><td>${bd.readcnt}</td></tr>
    	</c:forEach>
    </tbody>
	</table>
	<!-- 
	previous ==> 이번 blocknum
	
		[1][2][3][4][5]=>  1 blocknum
	 <=	[6][7][8][9][10]=> 2 blocknum
	 <=	[11][12][13][14][15] 3 blocknum
	
	next ==> 이후 blocknum
	
	
	 -->
	
	    
	<ul class="pagination justify-content-end">
	  
	  <li class="page-item">
	  <a class="page-link" href="javascript:goPage(${boardSch.startBlock-1})">Previous</a></li>
	  <c:forEach var="cnt" begin="${boardSch.startBlock}" end="${boardSch.endBlock}">
	  	<li class="page-item ${boardSch.curPage==cnt?'active':''}">
	  		<a class="page-link" href="javascript:goPage(${cnt})">${cnt}</a></li>
	  </c:forEach>
	  <li class="page-item">
	  	<a class="page-link" href="javascript:goPage(${boardSch.endBlock+1})">Next</a></li>
	</ul>    
</div>
	<script type="text/javascript">
		function goPage(cnt){
			// 요청값으로 현재 클릭한 페이지를 설정하고, 서버에 전달..
			$("[name=curPage]").val(cnt);
			$("form").submit();
		}
	
	</script>	

</body>
</html>