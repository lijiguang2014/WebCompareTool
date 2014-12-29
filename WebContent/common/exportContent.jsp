<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Main_Panel">
	<div id="Main_Panel_Content">
		<form id="exportCondition">
			<label>请选择数据库类型：</label>
			<ul>
				<li>
					<input type="radio" name="databaseType" value="oracle" checked="checked">Oracle
				</li>
				<li>
					<input type="radio" name="databaseType" value="mySql">MySQL
				</li>
			</ul>
			<label>请选择导出文件类型：</label>
			<ul>
				<li>
					<input type="radio" name="exportType" value="xml" checked="checked">XML
				</li>
				<li>
					<input type="radio" name="exportType" value="excel">EXCEL
				</li>
			</ul>
			<label>请填写数据库基本信息</label>
			<table>
				<tr>
					<td>url:</td>
					<td><input name="url" type="text" size="40"></td>
				</tr>
				<tr>
					<td>username:</td>
					<td><input name="username" type="text" size="40"></td>
				</tr>
				<tr>
					<td>password:</td>
					<td><input name="password" type="text" size="40"></td>
				</tr>
				<tr>
					<td colspan="3" align="right">
						<input id="exportType" type="button" value="Type导出">
						<input id="exportEntity" type="button" value="Entity导出">
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>