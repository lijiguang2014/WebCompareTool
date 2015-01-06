<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Content_Left">
	<div id="menus">
		<div class="menu">
			<a class="task-icon-link" href="main.jsp">
				<img style="width: 24px; height: 24px; margin: 0px;" class="icon-user icon-md" src="images/VersionManager.png">
			</a>&nbsp;
			<a class="task-link" href="main.jsp">版本管理</a>
		</div>
		<div class="menu">
			<a class="task-icon-link" href="merge.jsp">
				<img style="width: 24px; height: 24px; margin: 2px;" class="icon-user icon-md" src="images/VersionManager.png">
			</a>&nbsp;
			<a class="task-link" href="merge.jsp">XML合并</a>
		</div>
		<div class="menu">
			<a class="task-icon-link" href="export.jsp">
				<img style="width: 24px; height: 24px; margin: 2px;" class="icon-user icon-md" src="images/download.png">
			</a>&nbsp;
			<a class="task-link" href="export.jsp">模型导出</a>
		</div>
		<div class="menu">
			<a class="task-icon-link" href="generate.jsp">
				<img style="width: 24px; height: 24px; margin: 2px;" class="icon-user icon-md" src="images/download.png">
			</a>&nbsp;
			<a class="task-link" href="generate.jsp">模型生成</a>
		</div>
		<div class="menu">
			<a class="task-icon-link" href="compare.jsp">
				<img class="icon-user icon-md" src="images/new.png">
			</a>&nbsp;
			<a class="task-link" href="compare.jsp">新建比对</a>
		</div>
	</div>
	<div id="compareHistory">
		<div class="row">
			<div class="pane-header">
				Compare History
			</div>
		</div>
		<div class="pane-content">
			<table id="historyList">
			</table>
		</div>
	</div>
</div>
<input name="projectName" type="hidden" id="projectName" value="${projectName}" />
<input name="pageNo" type="hidden" id="pageNo" value="${pageNo}"/>