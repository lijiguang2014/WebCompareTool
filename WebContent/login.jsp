<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<title>比对登录</title>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			type: "get",
			url: "${pageContext.request.contextPath}/getProjectNames.do",
			datatype: "json",
			success: function(data) {
				 $.each(data,function(index,entity){
					 if (entity == "fumargin") {
						 $("#projectnames").append("<option value=\"" + entity + "\" selected=\"selected\">" + entity + "</option>");
					 } else {
						 $("#projectnames").append("<option value=\"" + entity + "\">" + entity + "</option>");
					 }
					
				});
			}
		});
	});
</script>
<style type="text/css">
body{TEXT-ALIGN: center;}
#login
{
	height: 200px;
	width: 300px;
}
</style>
</head>
<body background="${pageContext.request.contextPath}/images/bgblue.jpg">
	<div id="login">
		<form action="${pageContext.request.contextPath}/login.do" method="post">
		   <label>项目名：</label>
		   <select id="projectnames" name="projectName" style="margin:-2px;width:104px; ">
		   </select>
		   <input type="submit" value="登录">
		</form>
	</div>
</body>
</html>