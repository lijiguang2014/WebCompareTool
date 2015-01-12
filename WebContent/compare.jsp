<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="common/checkIsLogin.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>数据模型比对</title>
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
	//把比对记录存储成稳定版本
	function storeHistoryForStable() {
		var formData = $("#latestHistoryForm").serializeArray();
		$.ajax({
			url: "compareHistory/storeForStable.do?projectName=" + $("#projectName").val(),
			method: "post",
			data: formData,
			dataType: "json",
			success: function(data, status){
				if(data.success == "1") {
					updateLatestHistoryForStable(data.history);
					updateLeftHistory($("#projectName").val(), $("#pageNo").val());
					alert("版本保存成功");
				} else {
					alert(data.msg);
				}
			}
		});
	}
	
	function updateLeftHistory(projectName, pageNo) {
		if (pageNo == "") {
			pageNo=1;
		}
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

	//初始化主界面
	function getHistoryList(projectName, pageNo) {
		if (pageNo == "") {
			pageNo=1;
		}
		$.ajax({
			type:"POST",
			contentType : "application/json",  
			dataType: "json",
			url: "compareHistory/getList.do?projectName="+projectName+"&pageNo="+pageNo,
			success: init,
			error: function(error) {
				alert("比对历史加载失败!");
			}
		});
	}

	function init(data, status) {
		var pageNo = data.pageNo;
		if(!pageNo) {
			return;
		}
		fillLeftHistoryList(data, status);
		updateLatestHistoryForStable(data.latestHistory);
	}
	
	$(document).ready(function(){
		//在页面载入的时候，加载比对记录列表
		getHistoryList($("#projectName").val(), $("#pageNo").val());
		
		$("input[name='compareFileType'][type='radio']").change(function(){
			$("#compareFileType").val($(this).val());
		});

		$("input[name='databaseType'][type='radio']").change(function(){
			$("#databaseType").val($(this).val());
		});
		
		$("input[name='sourceType'][type='radio']").change(function(){
			$("#sourceType").val($(this).val());	
		});
		
		$("input[name='sourceType'][type='radio']").click(function(){
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
				url: 'upload.do',
				secureuri:false,
				fileElementId:'sourceFile',
				dataType: "json",
				success: function(result, status) {
					if (result.success == "1") {
						alert("上传文件成功！");
						var filename=getFileNameFromFilePath(result.fileRelativePath);
						$("#source_upload_info").html("<div>文件:"+ filename +"   <a href='javascript:void(0)' onclick='deletefile("+"\""+result.fileRelativePath+"\",\"source\")'>删除</a>"+"<br/></div>");
						$("#source_upload_info").css("visibility", "visible");
						$("#sourceFileRelativePath").val(result.fileRelativePath);
					} else {
						$("#source_upload_info").html("文件上传失败: " + result.msg);
						$("#source_upload_info").css({"visibility":"visible", "color":"red"});
					}
				},
				complete: function(xmlHttpRequest, status) {
					$("#sourceFile").replaceWith("<input type=\"file\" id=\"sourceFile\" name=\"upFile\" style=\"display:none;\"/>");
					$("#sourceFile").change(function(){
						var filename = $(this).val();
						$("#originalSourceFileName").val(filename);
					});
				},
				error: function(data, status, e) {
		            alert("文件上传失败!" + data.message+" error:  " + e); 
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
				url: "upload.do",
				secureuri:false,
				fileElementId:"targetFile",
				dataType: "json",
				success: function(result,status) {
					if (result.success == "1") {
						alert("上传文件成功！");
						var filename=getFileNameFromFilePath(result.fileRelativePath);
						$("#target_upload_info").html("<div>"+"文件:"+filename+"   <a href='javascript:void(0)' onclick='deletefile("+"\""+result.fileRelativePath+"\",\"target\")'>删除</a>"+"<br/></div>");
						$("#target_upload_info").css("visibility", "visible");
						$("#targetFileRelativePath").val(result.fileRelativePath);
					} else {
						$("#target_upload_info").html("文件上传失败: " + result.msg);
						$("#target_upload_info").css({"visibility":"visible", "color":"red"});
					}
				},
				complete: function(xmlHttpRequest, status) {
					$("#targetFile").replaceWith("<input type=\"file\" id=\"targetFile\" name=\"upFile\" style=\"display:none;\"/>");
					$("#targetFile").change(function(){
						var filename = $(this).val();
						$("#originalTargetFileName").val(filename);
					});
				},
				error: function(data, status, e) {
					alert("文件上传失败!");
				}
			});
			return false;
		});
		
		
		$("#compare").click(function(){
			if(!checkCompareCondition()) {
				return;
			}
			var compareCondition = $("#compareCondition").serializeArray();
			$.ajax({
				type: "POST",
				url: "compare.do",
				data: compareCondition,
				beforeSend: function(xmlHttpRequest) {
					$("#show p").text("正在比对，请耐心等待");
					showMask();
				},
				success: function(data) {
					if (data.success == "1") {
						var latestHistory = data.latestHistory;
						var content = "";
						content += "<tr><td>比对日期</td><td>模板</td><td>中间结果</td><td>alter脚本</td><td>比对报告</td><td>操作</td></tr>";
						content += "<tr><td>" + latestHistory.compareDate + "</td><td>" + getFileNameFromFilePath(latestHistory.templateFilePath)
						+ "</td><td>" + "<a href=\"downloadFile.do?filePath=" + latestHistory.alterSqlFilePath + "\">" 
						+ getFileNameFromFilePath(latestHistory.alterSqlFilePath) + "</a>" + "</td><td>" 
						+ "<a href=\"javascript:void(0)\" onclick=\"displayReport(\'" + latestHistory.reportFilePath + "\')\">" 
						+getFileNameFromFilePath(latestHistory.reportFilePath) + "</a></td>";
						content += "<td><input type=\"button\" onclick=\"storeHistoryForStable()\" value=\"保存为稳定版本\"></td></tr>";
						
						$("#latestHistoryForTemp").empty();
						$("#latestHistoryForTemp").append(content);
						$("#latestHistoryForTempDiv").css("display", "block");
						
						$("#version").val(latestHistory.version);
						$("#compareDate").val(latestHistory.compareDate);
						$("#srcFilePath").val(latestHistory.srcFilePath);
						$("#targetFilePath").val(latestHistory.targetFilePath);
						$("#templateFilePath").val(latestHistory.templateFilePath);
						$("#middleResultFilePath").val(latestHistory.middleResultFilePath);
						$("#alterSqlFilePath").val(latestHistory.alterSqlFilePath);
						$("#reportFilePath").val(latestHistory.reportFilePath);
						$("#status").val(latestHistory.status);
						
						alert("比对结束，请看下面最新比对记录");
					} else {
						alert("比对失败： " + data.error);
					}
				},
				complete:function(xmlHttpRequest, status) {
					closeMask();
				}
			});
			clearCmpCondition();
		});
	});
</script>
</head>
<body>
	<div id="bg"></div>
	<div id="show">
		<p>正在比对，请耐心等待。。。</p>
		<img src="images/waiting.gif" />
	</div>
	
	<div id="Container">
		<%@ include file="common/header.jsp"%>
		<div id="Content">
			<%@ include file="common/content_left.jsp"%>
			<%@ include file="common/compareContent.jsp" %>
		</div>
	</div>
</body>
</html>