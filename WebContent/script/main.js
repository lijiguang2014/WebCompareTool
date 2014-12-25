/**
 * 各种页面用到的函数
 */

//填写数据库基本信息弹窗
function databaseInfo()
{
	var diag = new Dialog();
	diag.Title = "数据库基本信息";
	diag.URL = "databaseInfo.html";
	diag.OKEvent = function(){
			$id('sourceDiv').innerHTML = "数据库链接：" + diag.innerFrame.contentWindow.document.getElementById('url').value + ";username="
												+ diag.innerFrame.contentWindow.document.getElementById('username').value + ";password="
												+ diag.innerFrame.contentWindow.document.getElementById('password').value;
			$id('url').value=diag.innerFrame.contentWindow.document.getElementById('url').value;
			$id('username').value=diag.innerFrame.contentWindow.document.getElementById('username').value;
			$id('password').value=diag.innerFrame.contentWindow.document.getElementById('password').value;
		    $id('sourceDiv').style="diplay:block";
			diag.close();
	};
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

//填写导出功能的数据库基本信息
function exportDatabaseInfo() {
	var diag = new Dialog();
	diag.Title = "数据库基本信息";
	diag.URL = "databaseInfo.html";
	diag.OKEvent = function(){
			$id('url').value=diag.innerFrame.contentWindow.document.getElementById('url').value;
			$id('username').value=diag.innerFrame.contentWindow.document.getElementById('username').value;
			$id('password').value=diag.innerFrame.contentWindow.document.getElementById('password').value;
			if($id('url').value==""||$id('username').value==""||$id('password').value=="") {
				alert("请填写完整的数据库信息！");
			} else {
				exportFileFromDB();
				diag.close();
			}
	};
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

//更新最新稳定版本记录
function updateLatestHistoryForStable(latestHistory) {
	var latestHistoryContent = "";
	latestHistoryContent += "<tr><td>版本号</td><td>比对日期</td><td>模板</td><td>alter脚本</td><td>比对报告</td></tr>";
	latestHistoryContent += "<tr><td>" + latestHistory.version + "</td><td>" + latestHistory.compareDate + "</td><td>" + getFileNameFromFilePath(latestHistory.templateFilePath)
	+ "</td><td>" + "<a href=\"${pageContext.request.contextPath}/downloadFile.do?filePath=" + latestHistory.alterSqlFilePath + "\">" 
	+ getFileNameFromFilePath(latestHistory.alterSqlFilePath) + "</a></td><td>" 
	+ "<a href=\"javascript:void(0)\" onclick=\"displayReport(\'"+latestHistory.reportFilePath+"\')\">"+getFileNameFromFilePath(latestHistory.reportFilePath)
	+ "</a></td></tr>";
	$("#latestHistoryForStable").empty();
	$("#latestHistoryForStable").append(latestHistoryContent);
}



//显示比对报告
function displayReport(reportPath) {
	$.ajax({
		type: "post",
		url: "getReportContent.do?reportPath=" + reportPath,
		dataType: "json",
		success: function(data, status){
			if ("1" == data.success) {
				$("#reportDiv").css("display","block");
				$("#latestReport").html(data.content);
			} else {
				alert(data.content);
			}
		}
   });
}

//填充主界面比对记录列表
function fillHistoryList(data, status) {
	var pageNo = data.pageNo;
	if(!pageNo) {
		return;
	}
	$("#pageNo").val(pageNo);
	var totalPages = data.totalPages;
	var histories = data.recordList;
	$("#historyDetailList").empty();
	$("#historyDetailList").append("<tr><td>版本号</td><td>比对日期</td><td>模板</td><td>alter脚本</td><td>比对报告</td></tr>");
	var historyContent = "";
	$.each(histories, function(i, history) {
		historyContent += "<tr><td>" + history.version + "</td>"
		+ "<td>" + history.compareDate + "</td>" 
		+ "<td>" + getFileNameFromFilePath(history.templateFilePath)
		+ "</td><td>" + "<a href=\"downloadFile.do?filePath=" + history.alterSqlFilePath + "\">" 
		+ getFileNameFromFilePath(history.alterSqlFilePath) + "</a></td><td>" 
		+ "<a href=\"showReport.do?reportPath="+history.reportFilePath+"\">"
		+"<img src='images/terminal.gif'>" + "</a></td></tr>";
		$("#historyDetailList").append(historyContent);
		historyContent = "";
	});
	
	var pagenation = "";
	pagenation += "<tr><td></td><td></td><td></td><td colspan='2' align='right'>";
	if (pageNo <= 1) {
		pagenation += "<input type='button' value=\"上页\" disabled='disabled' />";
	} else {
		var prePage = pageNo-1;
		pagenation += "<input type='button' onclick='getHistoryList(\"" + $("#projectName").val() + "\"," + prePage + ")' value=\"上页\" />";
	}
	
	if (pageNo >= totalPages) {
		pagenation += "<input type='button' value=\"下页\" disabled='disabled' /></td></tr>";
	} else {
		var nextPage = pageNo+1;
		pagenation += "<input type='button' onclick='getHistoryList(\"" + $("#projectName").val() + "\"," + nextPage + ")' value=\"下页\" />";
	}
	pagenation += "</td></tr>";
	$("#historyDetailList").append(pagenation);
}

//填充左侧版本列表
function fillLeftHistoryList(data, status) {
	var pageNo = data.pageNo;
	if(!pageNo) {
		return;
	}
	$("#pageNo").val(pageNo);
	var totalPages = data.totalPages;
	
	var histories = data.recordList;
	$("#historyList").empty();
	$("#historyList").append("<tr><td>版本号</td><td>生成时间</td><td>基准</td><td>目标</td></tr>");
	$.each(histories, function(i, history) {
		var tBody="";
		tBody += "<tr><td><a href=\"downloadFile.do?filePath=" + history.targetFilePath + "\">" + history.version + "</a></td><td>" + history.compareDate + "</td>"
		+ "<td><input type=\"radio\" name=\"stableSourceFilePath\" onclick=\"changeSourceFile()\" value=\"" + history.targetFilePath + "\"/></td>"
		+ "<td><input type=\"radio\" name=\"stableTargetFilePath\" onclick=\"changeTargetFile()\" value=\"" + history.targetFilePath + "\"/></td></tr>";
		$("#historyList").append(tBody);
	});
	
	var pagenation = "";
	pagenation += "<tr><td></td><td></td><td colspan='2' align='right'>";
	if (pageNo <= 1) {
		pagenation += "<input type='button' value=\"上页\" disabled='disabled' />";
	} else {
		var prePage = pageNo-1;
		pagenation += "<input type='button' onclick='getHistoryList(\"" + $("#projectName").val() + "\"," + prePage + ")' value=\"上页\" />";
	}
	
	if (pageNo >= totalPages) {
		pagenation += "<td><input type='button' value=\"下页\" disabled='disabled' /></td></tr>";
	} else {
		var nextPage = pageNo+1;
		pagenation += "<td><input type='button' onclick='getHistoryList(\"" + $("#projectName").val() + "\"," + nextPage + ")' value=\"下页\" /></td></tr>";
	}
	$("#historyList").append(pagenation);
}

/**
 * 下面是一些公用函数
 */
function showMask() {
	$("#bg").css("display", "block");
	$("#show").css("display", "block");
}

function closeMask(){
	$("#bg").css("display", "none");
	$("#show").css("display", "none");
}

function getFileNameFromFilePath(filePath) {
	var ss = filePath.split("/");
	return ss[ss.length-1];
}

function clearCmpCondition() {
	$("#source_upload_info").css("visibility", "hidden");
	$("#target_upload_info").css("visibility", "hidden");
	$("#url").val("");
	$("#username").val("");
	$("#password").val("");
	$("#sourceFileRelativePath").val("");
	$("#targetFileRelativePath").val("");
}

function changeTargetFile() {
	$("#targetFileRelativePath").val($("input[name='stableTargetFilePath'][type='radio']:checked").val());	
	$("#originalTargetFileName").val(getFileNameFromFilePath($("input[name='stableTargetFilePath'][type='radio']:checked").val()));
}

function changeSourceFile() {
	$("#sourceFileRelativePath").val($("input[name='stableSourceFilePath'][type='radio']:checked").val());	
	$("#originalSourceFileName").val(getFileNameFromFilePath($("input[name='stableSourceFilePath'][type='radio']:checked").val()));
}

function getFileExtend(filename) {
	return filename.substr(filename.indexOf("."));
}

function checkCompareCondition() {
	var compareFileType=$("input[name='compareFileType'][type='radio']:checked").val();
	var sourceType=$("#sourceType").val();
	if (sourceType == "0") {
		if($("#url").val()==""||$("#username").val()==""||$("#password").val()=="") {
			alert("点击数据库单选按钮，填写数据库相关信息");
			return false;
		} 
	} else {
		if($("#sourceFileRelativePath").val()=="") {
			alert("基准数据文件还没上传，请点击选择文件，点击上传");
			return false;
		} else {
			if(getFileExtend($("#originalSourceFileName").val()) != compareFileType) {
				alert("上传的基准文件类型和选定的比对文件类型不匹配");
				return false;
			}
		}
	}
	
	if($("#targetFileRelativePath").val() == "") {
		alert("要比对的目标文件还没上传，请点击选择文件，点击上传");
		return false;
	} else {
		if(getFileExtend($("#originalTargetFileName").val()) != compareFileType) {
			alert("上传的目标文件类型和选定的比对文件类型不匹配");
			return false;
		}
	}
	
	return true;
}
