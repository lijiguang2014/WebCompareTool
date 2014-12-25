<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; %> 
<base href="<%=basePath%>">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:out value="<%=basePath%>" />
<form action="upload.do" method="post" enctype="multipart/form-data">

<%-- 类型enctype用multipart/form-data，这样可以把文件中的数据作为流式数据上传，不管是什么文件类型，均可上传。--%>
请选择要上传的文件
<input type="file" name="file" size="50">
<input type="submit" value="提交">
</form>
<h1>Upload Successful</h1>   
    <c:forEach var="month" items="${files}">   
        <li><a href="${pageContext.request.contextPath}/download/${month}.do">${month}</a></li>   
    </c:forEach>  
</body>
</html>