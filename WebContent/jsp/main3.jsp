<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/ajaxfileupload.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDialog.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/zDialog/zDrag.js" type="text/javascript"></script>
<script>
	var errorInfo = "${error}";
	if (errorInfo != "") {
		alert(errorInfo);
	} 
	
	function databaseInfo()
	{
		var diag = new Dialog();
		diag.Title = "数据库基本信息";
		diag.URL = "databaseInfo.html";
		diag.OKEvent = function(){$id('sourceDiv').innerHTML = "数据库链接：" + diag.innerFrame.contentWindow.document.getElementById('url').value + ";username="
													+ diag.innerFrame.contentWindow.document.getElementById('username').value + ";password="
													+ diag.innerFrame.contentWindow.document.getElementById('password').value;
													$id('url').value=diag.innerFrame.contentWindow.document.getElementById('url').value;
													$id('username').value=diag.innerFrame.contentWindow.document.getElementById('username').value;
													$id('password').value=diag.innerFrame.contentWindow.document.getElementById('password').value;
													$id('sourceDiv').style="diplay:block";
													diag.close();};
		diag.show();
		var doc=diag.innerFrame.contentWindow.document;
		doc.open();
		doc.write('<html><body>');
		doc.write('<table>');
		doc.write('<tr><td>URL:</td><td><input id="url" type="text" size="44"/></td></tr>');
		doc.write('<tr><td>Username:</td><td><input id="username" type="text" size="44"/></td></tr>');
		doc.write('<tr><td>Password:</td><td><input id="password" type="text" size="44"/></td></tr>');
		doc.write('</table>');
		doc.write('</body></html>');
		doc.close();
	}
	
	function deletefile(file, type){
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/deleteFile.do?type=" + type + "&fileName=" + file,
			success:function(data, status) {
				data = data.replace("<pre>", "");
				data = data.replace("</pre>", "");
				var remsg = data.split("|");
				if ("1" == remsg[0]) {
					alert("文件删除成功!");
					if (type=="source") {
						$("#source_upload_info").html("删除成功，请重新选择文件上传");
					} else {
						$("#target_upload_info").html("删除成功，请重新选择文件上传");
					}
				} else {
					alert(remsg[1]);
				}
			}
		});
	}
	
    $(document).ready(function() {  
    	$("input[name='sourceType'][type='radio']").change(function(){
    		$("#sourceType").val($(this).val());	
    	});
    	
    	$("input[name='sourceType']").click(function(){
    		var sourceType = $(this).val();
    		if(sourceType == 0) {
    			$("#sourceDiv").css("display", "none");
    			databaseInfo();
    		} else {
    			$("#sourceDiv").css("display", "block");
    		}
    	});
    	
    	$("#sourceFile").change(function(){
    		var filename = $(this).val();
    		$("#originalSourceFileName").val(filename);
    	});
    	
    	$("#sourceUpload").submit(function(){
    		$.ajaxFileUpload({
    			type: "post",
    			url: '${pageContext.request.contextPath}/upload.do?type=source',
    			secureuri:false,
    			fileElementId:'sourceFile',
    			dataType: "text",
    			success: function(result,status) {
    				result = result.replace("<pre>", "");
    				result = result.replace("</pre>", "");
    				var remsg = result.split("|");
    				if (remsg[0] == "1") {
    					alert("上传文件成功！");
    					$("#source_upload_info").html("<div>"+"文件:"+remsg[1]+"   <a href='javascript:void();' onclick='deletefile("+"\""+remsg[1]+"\",\"source\")'>删除</a>"+"<br/></div>");
    					$("#source_upload_info").css("display", "block");
    					$("#sourceFileName").val(remsg[1]);
    				} else {
    					$("#source_upload_info").html("文件上传失败: " + remsg[2]);
    					$("#source_upload_info").css({"display":"block", "color":"red"});
    				}
    			},
    			error: function(data, status, e) {
    				alert(data.status);  
    	            alert(data.message+" error:  " + e); 
    				alert("文件上传失败!");
    			}
    		});
    		return false;
    	});
    	
    	$("#targetFile").change(function(){
    		var filename = $(this).val();
    		$("#originalTargetFileName").val(filename);
    	});
    	
    	$("#targetUpload").submit(function(){
    		$.ajaxFileUpload({
    			type: "post",
    			url: '${pageContext.request.contextPath}/upload.do?type=target',
    			secureuri:false,
    			fileElementId:'targetFile',
    			dataType: "text",
    			success: function(result,status) {
    				result = result.replace("<pre>", "");
    				result = result.replace("</pre>", "");
    				var remsg = result.split("|");
    				if (remsg[0] == "1") {
    					alert("上传文件成功！");
    					$("#target_upload_info").html("<div>"+"文件:"+remsg[1]+"   <a href='javascript:void(0)' onclick='deletefile("+"\""+remsg[1]+"\",\"target\")'>删除</a>"+"<br/></div>");
    					$("#target_upload_info").css("display", "block");
    					$("#targetFileName").val(remsg[1]);
    				} else {
    					$("#target_upload_info").html("文件上传失败: " + remsg[2]);
    					$("#target_upload_info").css({"display":"block", "color":"red"});
    				}
    			},
    			error: function(data, status, e) {
    				alert(data.status);  
    	            alert(data.message+" error:  "+e); 
    				alert("文件上传失败!");
    			}
    		});
    		return false;
    	});
    	
    	$("#rollback").click(function(){
    		//弹出选择之前版本的对话框
    		
    	});
    	
    	$("#compare").submit(function(){
    		var sourceType=$("#sourceType").val();
    		if (sourceType == "0") {
    			if($("#url").val()==""||$("#username").val()==""||$("#password").val()=="") {
    				alert("点击数据库单选按钮，填写数据库相关信息");
    				return false;
    			} 
    		} else {
    			if($("#sourceFileName").val()=="") {
    				alert("基准数据文件还没上传，请点击选择文件，点击上传");
    				return false;
    			}
    		}
    		
    		if($("#targetFileName").val() == "") {
    			alert("要比对的目标文件还没上传，请点击选择文件，点击上传");
    			return false;
    		}
    		$("#stableDataModelFileName").val($("#targetFileName").val());
    		return true;
    	});
    	
    	$("#storeForStable").submit(function(){
    		$.ajax({
    			url: "${pageContext.request.contextPath}/storeForStable.do",
    			method: "post",
    			data: "stableDataModelFileName="+$("#stableDataModelFileName"),
    			dataType: "json",
    			success: function(data, status){
    				
    			}
    		});
    	});
    });  
	
</script>
</head>
<body>
<div>
	<label>基准数据来源：</label>
	<label><input type="radio" name="sourceType" value="0">数据库</label>
	<label><input type="radio" name="sourceType" value="1" checked="checked">文件</label>
</div>
<div>
		<div id="sourceDiv" style="display:block">
			<form id="sourceUpload"> 
	     	   <span>基准数据：</span>
	     	   <input type="text" onclick="$('#sourceFile').click()" id="originalSourceFileName" size="40" placeholder="选择CSV文件..."/> 
	           <input type="button" onclick="$('#sourceFile').click()" value="浏览"/>
	           <input type="hidden" name="type" value="source">
	           <input type="file" id="sourceFile" name="upFile" style="display:none;"/> &nbsp;
	           <input type="submit" value="上传"> 
		    </form>
		</div>
		<div id="source_upload_info" style="width:100%;border:1px solid #809db9;display:none" ></div>
    	<div id="targetDiv">
		<form id="targetUpload"> 
     	   <span>目标数据：</span>
     	   <input type="text" onclick="$('#targetFile').click()" id="originalTargetFileName" size="40" placeholder="选择CSV文件..."/> 
           <input type="button" onclick="$('#targetFile').click()" value="浏览"/>
           <input type="hidden" name="type" value="target">
           <input type="file" id="targetFile" name="upFile" style="display:none;"/> &nbsp;
           <input type="submit" value="上传">&nbsp;<input id="rollback" type="button" value="回滚" />
	    </form>
       </div>
       
       <div id="target_upload_info" style="width:100%;border:1px solid #809db9;display:none" ></div>
    <form action="${pageContext.request.contextPath}/compare.do" method="post" target="rightDown">
		<div>
			<input id="url" type="hidden" name="url" />
			<input id="username" type="hidden" name="username" />
			<input id="password" type="hidden" name="password" />
			<input id="sourceFileName" type="hidden" name="sourceFileName" />
			<input id="targetFileName" type="hidden" name="targetFileName" />
			<input id="sourceType" type="hidden" name="sourceType" />
			<input id="status" type="hidden" name="status" />
			<input id="compare" type="submit" value="比对" />
		</div><!-- 比对结束后提示是否加入到stable中  -->
	</form>
	<form action="${pageContext.request.contextPath}/storeForStable.do" method="post">
		<input id="stableDataModelFileName" type="hidden" name="stableDataModelFileName"> 
		<input id="storeForStable" type="submit" value="保存为稳定版" />
	</form>
</div>
</body>
</html>