<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="Main_Panel">
	<div id="Main_Panel_Content">
		<table style="text-align:left;">
			<tr>
				<td><span>上传Framework.xml：</span></td>
				<td>
					<div id="frameworkDiv">
						<form id="frameworkUpload"> 
				     	   <input type="text" onclick="$('#frameworkFile').click()" id="originalFrameworkFileName" size="40" /> 
				           <input type="button" onclick="$('#frameworkFile').click()" value="浏览"/>
				           <input type="file" id="frameworkFile" name="upFile" style="display:none;"/> &nbsp;
				           <input type="submit" value="上传"> 
					    </form>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="framework_upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
				</td>
			</tr>
			<tr>
				<td><span>上传Entity.xml：</span></td>
				<td>
					<div id="entityDiv">
						<form id="entityUpload"> 
				     	   <input type="text" onclick="$('#entityFile').click()" id="originalEntityFileName" size="40" /> 
				           <input type="button" onclick="$('#entityFile').click()" value="浏览"/>
				           <input type="file" id="entityFile" name="upFile" style="display:none;"/> &nbsp;
				           <input type="submit" value="上传"> 
					    </form>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="entity_upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
				</td>
			</tr>
			<tr>
				<td>
					<span>上传Type.xml：</span>
				</td>
				<td>
					<div id="typeDiv">
						<form id="typeUpload"> 
				     	   <input type="text" onclick="$('#typeFile').click()" id="originalTypeFileName" size="40" /> 
				           <input type="button" onclick="$('#typeFile').click()" value="浏览"/>
				           <input type="file" id="typeFile" name="upFile" style="display:none;"/> &nbsp;
				           <input type="submit" value="上传"> 
					    </form>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="type_upload_info" style="width:100%;height:20px;visibility:hidden" ></div>
				</td>
			</tr>
		</table>
		
		<div>
			<form id="mergeCondition">
				<input id="frameworkFileRelativePath" name="frameworkFileRelativePath" type="hidden" value="">
				<input id="entityFileRelativePath" name="entityFileRelativePath" type="hidden" value="">
				<input id="typeFileRelativePath" name="typeFileRelativePath" type="hidden" value="">
			</form>
			<input id="merge" type="button" value="合并">
		</div>
	</div>
</div> 