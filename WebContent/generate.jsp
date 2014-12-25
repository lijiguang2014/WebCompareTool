<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/checkIsLogin.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>模型生成</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" type="text/css"></link>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/content_left.css" type="text/css"></link>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/ajaxfileupload.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/main.js" type="text/javascript"></script>
<style type="text/css">
	#bg{ display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.5;  opacity:0.5;  filter: alpha(opacity=50);}
    #show{display: none;  position: absolute;  top: 25%;  left: 22%;  width: 53%;  height: 49%;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;  z-index:1002;  overflow: auto; text-align:center; line-height: 49%; font-size: 18px;}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("#upFile").change(function(){
			var filename = $(this).val();
			$("#originalUploadFileName").val(filename);
		});
		
		$("#upload").submit(function(){
			$.ajaxFileUpload({
				type: "post",
				url: '${pageContext.request.contextPath}/upload.do',
				secureuri:false,
				fileElementId:'upFile',
				dataType: "json",
				success: function(result, status) {
					if (result.success == "1") {
						alert("上传文件成功！");
						var filename=getFileNameFromFilePath(result.fileRelativePath);
						$("#upload_info").html("<div>文件:"+ filename +"   <a href='javascript:void(0)' onclick='deletefile("+"\""+result.fileRelativePath+"\",\"source\")'>删除</a>"+"<br/></div>");
						$("#upload_info").css("visibility", "visible");
						$("#designRelativeFilePath").val(result.fileRelativePath);
					} else {
						$("#upload_info").html("文件上传失败: " + result.msg);
						$("#upload_info").css({"visibility":"visible", "color":"red"});
					}
				},
				complete: function(xmlHttpRequest, status) {
					$("#upFile").replaceWith("<input type=\"file\" id=\"upFile\" name=\"upFile\" style=\"display:none;\"/>");
					$("#upFile").change(function(){
						var filename = $(this).val();
						$("#originalUploadFileName").val(filename);
					});
				},
				error: function(data, status, e) {
		            alert("文件上传失败!" + data.message+" error:  " + e); 
				}
			});
			return false;
		});
	});
	
	$("#generate").click(function(){
		var designRelativeFilePath = $("#designRelativeFilePath").val();
		if(designFilePath == "") {
			alert("请上传数据库设计文件!");
			return;
		}
		$.ajax({
			type:"post",
			url: "generate.do?designRelativeFilePath="+designRelativeFilePath,
			beforeSend: function(xmlHttpRequest) {
				$("#show p").text("正在比对，请耐心等待");
				showMask();
			},
			success: function(data, status) {
				if(data.success == "0") {
					alert("数据模型生成失败： " + data.msg);
				} else {
				   var form = $("<form>");   //定义一个form表单
			       form.attr('style','display:none');   //在form表单中添加查询参数
			       form.attr('target','');
			       form.attr('method','post');
			       form.attr('action',"downloadFile.do");
	
			       var input1 = $('<input>'); 
			       input1.attr('type','hidden'); 
			       input1.attr('name','filePath'); 
			       input1.attr('value',data.filePath); 
			       $('body').append(form);  //将表单放置在web中
			       form.append(input1);   //将查询参数控件提交到表单上
			       form.submit();   //表单提交
				}	
			}
			
		});
	});
</script>
</head>
<body>
	<div id="bg"></div>
	<div id="show">
		<p>createTable脚本正在生成，请耐心等待。。。</p>
		<img src="images/waiting.gif" />
	</div>

	<div id="Container">
		<%@ include file="common/header.jsp"%>
		<div id="Content">
			<%@ include file="common/content_left.jsp"%>
			<%@ include file="common/generateContent.jsp" %>
		</div>
	</div>
</body>
</html>