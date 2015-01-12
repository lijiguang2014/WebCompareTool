<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Main_Panel">
	<div id="Main_Panel_Content">
	<div>
		<div class="condition">
			<label>数据库类型：</label>
			<label><input type="radio" name="databaseType" value="oracle" checked="checked">Oracle</label>
			<label><input type="radio" name="databaseType" value="mySql" >MySQL</label>
		</div>
		<div class="condition">
			<label>比对文件类型：</label>
			<label><input type="radio" name="compareFileType" value=".xml" checked="checked">XML</label>
			<label><input type="radio" name="compareFileType" value=".xls" >Excel</label>
		</div>
		<div class="condition">
			<label>基准数据来源：</label>
			<label><input type="radio" name="sourceType" value="0">数据库</label>
			<label><input type="radio" name="sourceType" value="1" checked="checked">文件</label>
		</div>
		<div id="sourceDiv" class="condition">
			<form id="sourceUpload"> 
	     	   <span>基准数据：</span>
	     	   <input type="text" onclick="$('#sourceFile').click()" id="originalSourceFileName" size="40" /> 
	           <input type="button" onclick="$('#sourceFile').click()" value="浏览"/>
	           <input type="hidden" name="type" value="source">
	           <input type="file" id="sourceFile" name="upFile" style="display:none;"/> &nbsp;
	           <input type="submit" value="上传"> 
		    </form>
		</div>
		<div id="source_upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
		
	   	<div id="targetDiv" class="condition">
			<form id="targetUpload"> 
	     	   <span>目标数据：</span>
	     	   <input type="text" onclick="$('#targetFile').click()" id="originalTargetFileName" size="40" /> 
	           <input type="button" onclick="$('#targetFile').click()" value="浏览"/>
	           <input type="hidden" name="type" value="target">
	           <input type="file" id="targetFile" name="upFile" style="display:none;"/> &nbsp;
	           <input type="submit" value="上传">
		    </form>
	      </div>
	      <div id="target_upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
		       
	     <form id="compareCondition" action="${pageContext.request.contextPath}/compare.do" method="post">
			<div>
				<input id="url" type="hidden" name="url" />
				<input id="username" type="hidden" name="username" />
				<input id="password" type="hidden" name="password" />
				<input id="sourceFileRelativePath" type="hidden" name="sourceFileRelativePath" />
				<input id="targetFileRelativePath" type="hidden" name="targetFileRelativePath" />
				<input id="sourceType" type="hidden" name="sourceType" value="1"/>
				<input id="compareFileType" type="hidden" name="compareFileType" value=".xml"/>
				<input id="databaseType" type="hidden" name="databaseType" value="oracle"/>
				<input name="projectName" type="hidden" id="projectName" value="${projectName}" />
				<input name="pageNo" type="hidden" id="pageNo" value="1"/>
				<input id="compare" type="button" value="比对" />
			</div>
		 </form>
	  </div>
	  
	  <div id="History_Report">
			<label>最新稳定版本记录：</label><br/>
			<div class="latestHistoryForStableDiv">
				<table id="latestHistoryForStable">
				</table>
			</div>
			<div id="latestHistoryForTempDiv" style="display:none">
				<label>最新比对记录：</label><br/>
				<table id="latestHistoryForTemp">
				</table>
				<form id="latestHistoryForm">
					<input id="version" name="version" type="hidden"/>
					<input id="compareDate" name="compareDate" type="hidden"/>
					<input id="srcFilePath" name="srcFilePath" type="hidden"/>
					<input id="targetFilePath" name="targetFilePath" type="hidden"/>
					<input id="templateFilePath" name="templateFilePath" type="hidden"/>
					<input id="middleResultFilePath" name="middleResultFilePath" type="hidden"/>
					<input id="alterSqlFilePath" name="alterSqlFilePath" type="hidden"/>
					<input id="reportFilePath" name="reportFilePath" type="hidden"/>
					<input id="status" name="status" type="hidden"/>
				</form>
			</div>
			<div class="latestReport">
				<label>最新比对报告：</label><br/>
				<textarea id="latestReport" rows="10" cols="105"></textarea>
			</div>
		</div>
	</div>
</div>