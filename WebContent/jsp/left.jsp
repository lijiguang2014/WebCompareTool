<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="/tlds/comparetool.tld" prefix="comparetool" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/script/jquery-1.11.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/script/portal-common.js" type="text/javascript"></script>
<script type="text/javascript">
function setFormAction() {
    var form = document.forms[0];
    form.target = "_self";
    form.action ="<c:out value='${pageContext.request.contextPath}' />/compareHistory/getList.do";
}
</script>
</head>
<body>
<form>
	<table>
		<tr>
			<td>版本号</td>
			<td>生成时间</td>
		</tr>
		<c:forEach items="${returnList}" var="compareHistory">
			<tr>
			    <td>${compareHistory.version}</td>        
			    <td>${compareHistory.compareDate}</td>
		  	</tr>
		</c:forEach>
		<tr>
			<td></td>
			<td>
				<comparetool:pagenation type="simple" pageNoProperty="pageNo" totalPagesProperty="totalPages" recordCountProperty="recordCount" callBack="setFormAction" />
			</td>
		</tr>
	</table>
</form>
</body>
</html>