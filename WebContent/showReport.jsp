<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/checkIsLogin.jsp"%>
<title>浏览比对报告</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/content_left.css" type="text/css"></link>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/ajaxfileupload.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/main.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDialog.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDrag.js" type="text/javascript"></script>
<script type="text/javascript">
	var error = "${error}";
	if (error != "") {
		alert(error);
	}

	//初始化主界面
	function getHistoryList(projectName, pageNo) {
		$.ajax({
			type:"POST",
			contentType : "application/json",  
			dataType: "json",
			url: "compareHistory/getList.do?projectName="+projectName+"&pageNo="+pageNo,
			success: fillLeftHistoryList,
			error: function(error) {
				alert("比对历史加载失败!");
			}
		});
	}
	
	$(document).ready(function(){
		//在页面载入的时候，加载比对记录列表
		getHistoryList($("#projectName").val(), $("#pageNo").val());
	});
</script>
</head>
<body>
<div id="Container">
		<%@ include file="common/header.jsp"%>
		<div id="Content">
			<%@ include file="common/content_left.jsp"%>
			<%@ include file="common/showReportContent.jsp" %>
		</div>
	</div>
</body>
</html>