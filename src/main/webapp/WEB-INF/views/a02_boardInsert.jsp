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
	.input-group-text{width:100%;background-color:#cfffdf;color:black;font-weight:bolder;}
	.input-group-prepend{width:20%;}
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
</script>
</head>

<body>
<div class="jumbotron text-center">
  <h2>게시판등록</h2>

</div>
<div class="container">
	<form id="frm01" enctype="multipart/form-data" action="${path}/boardInsert.do" 
		 class="form"  method="post">
		 <input type="hidden" name="refno" value="${empty param.refno?'0': param.refno}"/>
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="text-center input-group-text">제 목</span>
			</div>
			<input name="subject" class="form-control" 
				value="${param.subject}" placeholder="제목 입력하세요" />	
		</div>  
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="text-center input-group-text">작성자</span>
			</div>
			<input name="writer" class="form-control" 
				value="" placeholder="작성자 입력하세요" />	
		</div> 	
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="text-center input-group-text">내 용</span>
			</div>
			<textarea name="content" rows="10" class="form-control"  
				placeholder="내용 입력하세요">${param.content}</textarea>	
		</div> 	
		<div class="input-group mb-3">
			<div class="input-group-prepend">
				<span class="text-center input-group-text">파일첨부</span>
			</div>
			<input type="file" name="report" class="form-control" 
				placeholder="파일을 첨부하세요" />	
		</div> 			
		<div class="text-right">
			<button type="button" onclick="insertProc()" class="btn btn-success">등록</button>
			<button type="button" onclick="goMain()" class="btn btn-info">메인화면</button>
		</div>		
	</form>
</div>
<script type="text/javascript">
var isInsert = "${isInsert}"
	if(isInsert=="Y"){
		if(!confirm("등록성공했습니다\n계속등록하시겠습니까?")){
			// 취소 입력시 조회화면 이동..
			location.href="${path}/boardList.do"
		}else{
			location.href="${path}/boardInsertForm.do"
		}
	}
function goMain(){
	location.href="${path}/boardList.do";
}
function insertProc(){
	if(confirm("등록하시겠습니까?")){
		var subjectVal = $("[name=subject]").val();		
		if(	subjectVal == ""){
			alert("제목을 등록하세요");
			$("[name=subject]").focus();
			return; // 프로세스를 중단 처리
		}	
		var writerVal = $("[name=writer]").val();		
		if(	writerVal == ""){
			alert("작성자를 등록하세요");
			$("[name=writer]").focus();
			return; // 프로세스를 중단 처리
		}	
		document.querySelector("form").submit();
	}
}

</script>
</body>
</html>