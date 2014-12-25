<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/tlds/comparetool.tld" prefix="comparetool" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>历史记录和报告</title>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/portal-common.js" type="text/javascript"></script>
<script type="text/javascript">
	function setFormAction() {
	    var form = document.forms[0];
	    form.target = "_self";
	    form.action ="<c:out value='${pageContext.request.contextPath}' />/compareHistory/getList.do";
	}
	
	function displayReport(reportPath) {
		$.ajax({
			type: "post",
			url: "${pageContext.request.contextPath}/getReportContent.do?reportPath=" + reportPath,
			success: function(data, status){
				data = data.replace("<pre>", "");
				data = data.replace("</pre>", "");
				var remsg = data.split("|");
				if ("1" == remsg[0]) {
					$("#reportDiv").css("display","block");
					$("#latestReport").html(remsg[1]);
				} else {
					alert(remsg[1]);
				}
			}
	   });
	}
	
	$("document").ready(function(){
		var latestReport = "${latestReport}";
		if (latestReport != "") {
			$("#reportDiv").css("display","block");
			$("#latestReport").html(latestReport);
		}
	});
	
</script>
</head>
<body>
<form>
<div>
	<table style="border-width:1px;border-color:#000099;border-style:solid;">
		<tr>
			<td>比对日期</td>
			<td>src</td>
			<td>target</td>
			<td>sql</td>
			<td>report</td>
			<td>状态</td>
		</tr>
		<c:forEach items="${returnList}" var="compareHistory">
			<tr>
			    <td>${compareHistory.compareDate}</td>
			    <td>
				    <c:set var="srcFile" value="${compareHistory.srcFile}"></c:set>
				    <c:set var="splits1" value="${fn:split(srcFile,'/')}"></c:set>
				    <c:set var="length1" value="${fn:length(splits1)}"></c:set>
				    ${splits1[length1-1]}
			   </td>        
			    <td>
			    	<c:set var="targetFile" value="${compareHistory.targetFile}"></c:set>
				    <c:set var="splits2" value="${fn:split(targetFile,'/')}"></c:set>
				    <c:set var="length2" value="${fn:length(splits2)}"></c:set>
				    ${splits2[length2-1]}
			    </td>        
			    <td>
			    	<a href="${pageContext.request.contextPath}/downloadFile.do?filePath=${compareHistory.alterSqlFile}" >
			    		<c:set var="alterSqlFile" value="${compareHistory.alterSqlFile}"></c:set>
					    <c:set var="splits3" value="${fn:split(alterSqlFile,'/')}"></c:set>
					    <c:set var="length3" value="${fn:length(splits3)}"></c:set>
					    ${splits3[length3-1]}
			    	</a>
			    </td>        
			    <td>
			    	<a href="javascript:void(0)" onclick="displayReport('${compareHistory.reportFile}')"> 
				    	<c:set var="reportFile" value="${compareHistory.reportFile}"></c:set>
					    <c:set var="splits4" value="${fn:split(reportFile,'/')}"></c:set>
					    <c:set var="length4" value="${fn:length(splits4)}"></c:set>
					    ${splits4[length4-1]}
			    	</a>
			    </td>        
			    <td>${compareHistory.status}</td>        
		  	</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td colspan="2">
				<comparetool:pagenation type="simple" pageNoProperty="pageNo" totalPagesProperty="totalPages" recordCountProperty="recordCount" callBack="setFormAction" />
			</td>
		</tr>
	</table>
</div>
</form>
<div id="reportDiv" style="display:none">
<label>比对报告：</label><br/>
<textarea id="latestReport" rows="20" cols="50" wrap="physical"></textarea>
</div>
</body>
</html>