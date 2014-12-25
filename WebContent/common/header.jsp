<%@ page language="java" pageEncoding="utf-8"%>
<div id="Header">
	<div class="logo">
		<img src="${pageContext.request.contextPath}/images/logo.png">
		<img width="139" height="34" src="${pageContext.request.contextPath}/images/title.png">
	</div>
	<div id="logoutPanel" align="right">
		项目组： ${projectName} <a href="login.jsp">登出</a>
	</div>
</div>