<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/jquery.filestyle.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDialog.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDrag.js" type="text/javascript"></script>
<script>
	function databaseInfo()
	{
		var diag = new Dialog();
		diag.Title = "数据库基本信息";
		diag.URL = "databaseInfo.html";
		diag.OKEvent = function(){$id('#sourceText').value = diag.innerFrame.contentWindow.document.getElementById('url').value + ";username="
													+diag.innerFrame.contentWindow.document.getElementById('username').value + ";password="
													+diag.innerFrame.contentWindow.document.getElementById('password').value;diag.close();};
		diag.show();
		var doc=diag.innerFrame.contentWindow.document;
		doc.open();
		doc.write('<html><body>');
		doc.write('<table>');
		doc.write('<tr><td>URL:</td><td><input id="url" type="text"/></td></tr>');
		doc.write('<tr><td>Username:</td><td><input id="username" type="text"/></td></tr>');
		doc.write('<tr><td>Password:</td><td><input id="password" type="text"/></td></tr>');
		doc.write('</table>');
		doc.write('</body></html>');
		doc.close();
	}
	
    $(document).ready(function() {  
    	
    	$("#upfile").filestyle({ 
            image: "choose-file.gif",
            imageheight : 22,
            imagewidth : 82,
            width : 220
        });
    	
    	$("#source").click(function() {
    		var sourceType = $("input[name='sourceType']:checked").val();
    		if (sourceType==0) {
    			databaseInfo();
    		} else {
    			
    		}
    	});  
    });  
	
</script>
</head>
<body>
<div>
	<label>基准数据来源：</label>
	<label><input type="radio" name="sourceType" value="0" >数据库</label>
	<label><input type="radio" name="sourceType" value="1" checked="checked">文件</label>
</div>
<div>
	<input id="upfile" type="file" value="上传文件" />
	<div>源数据：<input id="sourceText" type="text" size="50"/><input id="source" type="button" value="上传文件"></div>
	<div>目标数据：<input id="targetText" type="text" size="50"/><input id="target" type="button" value="上传文件" /></div>
	<div><input id="compare" type="button" value="比对" /></div><!-- 比对结束后提示是否加入到stable中  -->
</div>
</body>
</html>