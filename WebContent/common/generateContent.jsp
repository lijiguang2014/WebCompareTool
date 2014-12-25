<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Main_Panel">
	<div id="Main_Panel_Content">
		<label>上传数据库设计文件（Excel格式 .xls）:</label>
		<div id="uploadDiv">
			<form id="upload"> 
	     	   <span>基准数据：</span>
	     	   <input type="text" onclick="$('#upFile').click()" id="originalUploadFileName" size="40" /> 
	           <input type="button" onclick="$('#upFile').click()" value="浏览"/>
	           <input type="file" id="upFile" name="upFile" style="display:none;"/> &nbsp;
	           <input type="submit" value="上传"> 
		    </form>
		</div>
		<div id="upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
		<div>
			<input id="designRelativeFilePath" name="designRelativeFilePath" type="text">
			<input id="generate" type="button" value="生成">
		</div>
	</div>
</div> 