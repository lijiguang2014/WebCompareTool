/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.53
 * Generated at: 2015-01-06 08:43:57 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class merge_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(4);
    _jspx_dependants.put("/common/checkIsLogin.jsp", Long.valueOf(1419414035000L));
    _jspx_dependants.put("/common/mergeContent.jsp", Long.valueOf(1420533529803L));
    _jspx_dependants.put("/common/content_left.jsp", Long.valueOf(1420508635646L));
    _jspx_dependants.put("/common/header.jsp", Long.valueOf(1419816108429L));
  }

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
 String path = request.getContextPath(); String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/"; 
      out.write(" \r\n");
      out.write("<base href=\"");
      out.print(basePath);
      out.write("\">\r\n");

if(session.getAttribute("projectName")==null ){
	response.sendRedirect("login.jsp");
}

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("<title>模型导出</title>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/css/main.css\" type=\"text/css\"></link>\r\n");
      out.write("<link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/css/content_left.css\" type=\"text/css\"></link>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/script/jquery-1.11.1.min.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/script/ajaxfileupload.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/script/main.js\" type=\"text/javascript\"></script>\r\n");
      out.write("<style type=\"text/css\">\r\n");
      out.write("\t#bg{ display: none;  position: absolute;  top: 0%;  left: 0%;  width: 100%;  height: 100%;  background-color: black;  z-index:1001;  -moz-opacity: 0.5;  opacity:0.5;  filter: alpha(opacity=50);}\r\n");
      out.write("    #show{display: none;  position: absolute;  top: 25%;  left: 22%;  width: 53%;  height: 49%;  padding: 8px;  border: 8px solid #E8E9F7;  background-color: white;  z-index:1002;  overflow: auto; text-align:center; line-height: 49%; font-size: 18px;}\r\n");
      out.write("</style>\r\n");
      out.write("<script type=\"text/javascript\">\r\n");
      out.write("\t\r\n");
      out.write("\t//从数据库导出数据模型文件（支持Excel和Xml格式）\r\n");
      out.write("\tfunction merge() {\r\n");
      out.write("\t\tvar formData = $(\"#mergeCondition\").serializeArray();\r\n");
      out.write("\t\t$.ajax({\r\n");
      out.write("\t\t\ttype: \"post\",\r\n");
      out.write("\t\t\turl: \"merge.do\",\r\n");
      out.write("\t\t\tdata: formData,\r\n");
      out.write("\t\t\tbeforeSend: function(xmlHttpRequest) {\r\n");
      out.write("\t\t\t\t$(\"#show p\").text(\"正在合并，请耐心等待\");\r\n");
      out.write("\t\t\t\tshowMask();\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tsuccess: function(data) {\r\n");
      out.write("\t\t\t\tif(data.success == \"0\") {\r\n");
      out.write("\t\t\t\t\talert(\"合并framework，entity， type失败： \" + data.msg);\r\n");
      out.write("\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t   var form = $(\"<form>\");   //定义一个form表单\r\n");
      out.write("\t\t\t       form.attr('style','display:none');   //在form表单中添加查询参数\r\n");
      out.write("\t\t\t       form.attr('target','');\r\n");
      out.write("\t\t\t       form.attr('method','post');\r\n");
      out.write("\t\t\t       form.attr('action',\"downloadFile.do\");\r\n");
      out.write("\t\r\n");
      out.write("\t\t\t       var input1 = $('<input>'); \r\n");
      out.write("\t\t\t       input1.attr('type','hidden'); \r\n");
      out.write("\t\t\t       input1.attr('name','filePath'); \r\n");
      out.write("\t\t\t       input1.attr('value',data.filePath); \r\n");
      out.write("\t\t\t       $('body').append(form);  //将表单放置在web中\r\n");
      out.write("\t\t\t       form.append(input1);   //将查询参数控件提交到表单上\r\n");
      out.write("\t\t\t       form.submit();   //表单提交\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t},\r\n");
      out.write("\t\t\tcomplete:closeMask\r\n");
      out.write("\t\t});\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction changeFrameworkFileName() {\r\n");
      out.write("\t\tvar filename = $(this).val();\r\n");
      out.write("\t\t$(\"#originalFrameworkFileName\").val(filename);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction changeEntityFileName() {\r\n");
      out.write("\t\tvar filename = $(this).val();\r\n");
      out.write("\t\t$(\"#originalEntityFileName\").val(filename);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\tfunction changeTypeFileName() {\r\n");
      out.write("\t\tvar filename = $(this).val();\r\n");
      out.write("\t\t$(\"#originalTypeFileName\").val(filename);\r\n");
      out.write("\t}\r\n");
      out.write("\t\r\n");
      out.write("\t$(document).ready(function(){\r\n");
      out.write("\t\t//在页面载入的时候，加载比对记录列表\r\n");
      out.write("\t\tgetLeftHistoryList($(\"#projectName\").val(), $(\"#pageNo\").val());\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#frameworkFile\").change(changeFrameworkFileName);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#frameworkUpload\").submit(function(){\r\n");
      out.write("\t\t\t$.ajaxFileUpload({\r\n");
      out.write("\t\t\t\ttype: \"post\",\r\n");
      out.write("\t\t\t\turl: 'upload.do',\r\n");
      out.write("\t\t\t\tsecureuri:false,\r\n");
      out.write("\t\t\t\tfileElementId:'frameworkFile',\r\n");
      out.write("\t\t\t\tdataType: \"json\",\r\n");
      out.write("\t\t\t\tsuccess: function(result, status) {\r\n");
      out.write("\t\t\t\t\tif (result.success == \"1\") {\r\n");
      out.write("\t\t\t\t\t\talert(\"上传文件成功！\");\r\n");
      out.write("\t\t\t\t\t\tvar filename=getFileNameFromFilePath(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t\t$(\"#framework_upload_info\").html(\"<div>文件:\"+ filename +\"   <a href='javascript:void(0)' onclick='deletefile(\"+\"\\\"\"+result.fileRelativePath+\"\\\",\\\"framework\\\")'>删除</a>\"+\"<br/></div>\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#framework_upload_info\").css(\"visibility\", \"visible\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#frameworkFileRelativePath\").val(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t$(\"#framework_upload_info\").html(\"文件上传失败: \" + result.msg);\r\n");
      out.write("\t\t\t\t\t\t$(\"#framework_upload_info\").css({\"visibility\":\"visible\", \"color\":\"red\"});\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\tcomplete: function(xmlHttpRequest, status) {\r\n");
      out.write("\t\t\t\t\t$(\"#frameworkFile\").replaceWith(\"<input type=\\\"file\\\" id=\\\"frameworkFile\\\" name=\\\"upFile\\\" style=\\\"display:none;\\\"/>\");\r\n");
      out.write("\t\t\t\t\t$(\"#frameworkFile\").change(changeFrameworkFileName);\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\terror: function(data, status, e) {\r\n");
      out.write("\t\t            alert(\"文件上传失败!\" + data.message+\" error:  \" + e); \r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#entityFile\").change(changeEntityFileName);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#entityUpload\").submit(function(){\r\n");
      out.write("\t\t\t$.ajaxFileUpload({\r\n");
      out.write("\t\t\t\ttype: \"post\",\r\n");
      out.write("\t\t\t\turl: 'upload.do',\r\n");
      out.write("\t\t\t\tsecureuri:false,\r\n");
      out.write("\t\t\t\tfileElementId:'entityFile',\r\n");
      out.write("\t\t\t\tdataType: \"json\",\r\n");
      out.write("\t\t\t\tsuccess: function(result, status) {\r\n");
      out.write("\t\t\t\t\tif (result.success == \"1\") {\r\n");
      out.write("\t\t\t\t\t\talert(\"上传文件成功！\");\r\n");
      out.write("\t\t\t\t\t\tvar filename=getFileNameFromFilePath(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t\t$(\"#entity_upload_info\").html(\"<div>文件:\"+ filename +\"   <a href='javascript:void(0)' onclick='deletefile(\"+\"\\\"\"+result.fileRelativePath+\"\\\",\\\"entity\\\")'>删除</a>\"+\"<br/></div>\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#entity_upload_info\").css(\"visibility\", \"visible\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#entityFileRelativePath\").val(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t$(\"#entity_upload_info\").html(\"文件上传失败: \" + result.msg);\r\n");
      out.write("\t\t\t\t\t\t$(\"#entity_upload_info\").css({\"visibility\":\"visible\", \"color\":\"red\"});\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\tcomplete: function(xmlHttpRequest, status) {\r\n");
      out.write("\t\t\t\t\t$(\"#entityFile\").replaceWith(\"<input type=\\\"file\\\" id=\\\"entityFile\\\" name=\\\"upFile\\\" style=\\\"display:none;\\\"/>\");\r\n");
      out.write("\t\t\t\t\t$(\"#entityFile\").change(changeEntityFileName);\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\terror: function(data, status, e) {\r\n");
      out.write("\t\t            alert(\"文件上传失败!\" + data.message+\" error:  \" + e); \r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#typeFile\").change(changeTypeFileName);\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#typeUpload\").submit(function(){\r\n");
      out.write("\t\t\t$.ajaxFileUpload({\r\n");
      out.write("\t\t\t\ttype: \"post\",\r\n");
      out.write("\t\t\t\turl: 'upload.do',\r\n");
      out.write("\t\t\t\tsecureuri:false,\r\n");
      out.write("\t\t\t\tfileElementId:'typeFile',\r\n");
      out.write("\t\t\t\tdataType: \"json\",\r\n");
      out.write("\t\t\t\tsuccess: function(result, status) {\r\n");
      out.write("\t\t\t\t\tif (result.success == \"1\") {\r\n");
      out.write("\t\t\t\t\t\talert(\"上传文件成功！\");\r\n");
      out.write("\t\t\t\t\t\tvar filename=getFileNameFromFilePath(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t\t$(\"#type_upload_info\").html(\"<div>文件:\"+ filename +\"   <a href='javascript:void(0)' onclick='deletefile(\"+\"\\\"\"+result.fileRelativePath+\"\\\",\\\"type\\\")'>删除</a>\"+\"<br/></div>\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#type_upload_info\").css(\"visibility\", \"visible\");\r\n");
      out.write("\t\t\t\t\t\t$(\"#typeFileRelativePath\").val(result.fileRelativePath);\r\n");
      out.write("\t\t\t\t\t} else {\r\n");
      out.write("\t\t\t\t\t\t$(\"#type_upload_info\").html(\"文件上传失败: \" + result.msg);\r\n");
      out.write("\t\t\t\t\t\t$(\"#type_upload_info\").css({\"visibility\":\"visible\", \"color\":\"red\"});\r\n");
      out.write("\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\tcomplete: function(xmlHttpRequest, status) {\r\n");
      out.write("\t\t\t\t\t$(\"#typeFile\").replaceWith(\"<input type=\\\"file\\\" id=\\\"typeFile\\\" name=\\\"upFile\\\" style=\\\"display:none;\\\"/>\");\r\n");
      out.write("\t\t\t\t\t$(\"#typeFile\").change(changeTypeFileName);\r\n");
      out.write("\t\t\t\t},\r\n");
      out.write("\t\t\t\terror: function(data, status, e) {\r\n");
      out.write("\t\t            alert(\"文件上传失败!\" + data.message+\" error:  \" + e); \r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t});\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t});\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t$(\"#merge\").click(merge);\r\n");
      out.write("\t});\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("\t<div id=\"bg\"></div>\r\n");
      out.write("\t<div id=\"show\">\r\n");
      out.write("\t\t<p>正在比对，请耐心等待。。。</p>\r\n");
      out.write("\t\t<img src=\"images/waiting.gif\" />\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t<div id=\"Container\">\r\n");
      out.write("\t\t");
      out.write("\r\n");
      out.write("<div id=\"Header\">\r\n");
      out.write("\t<div class=\"logo\" style=\"float:left;\">\r\n");
      out.write("\t\t<img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/images/logo.png\">\r\n");
      out.write("\t\t<img width=\"139\" height=\"34\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/images/title.png\">\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"logoutPanel\" style=\"float:right;\">\r\n");
      out.write("\t\t项目组： ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectName}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write(" <a href=\"login.jsp\">登出</a>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>");
      out.write("\r\n");
      out.write("\t\t<div id=\"Content\">\r\n");
      out.write("\t\t\t");
      out.write("\r\n");
      out.write("<div id=\"Content_Left\">\r\n");
      out.write("\t<div id=\"menus\">\r\n");
      out.write("\t\t<div class=\"menu\">\r\n");
      out.write("\t\t\t<a class=\"task-icon-link\" href=\"main.jsp\">\r\n");
      out.write("\t\t\t\t<img style=\"width: 24px; height: 24px; margin: 0px;\" class=\"icon-user icon-md\" src=\"images/VersionManager.png\">\r\n");
      out.write("\t\t\t</a>&nbsp;\r\n");
      out.write("\t\t\t<a class=\"task-link\" href=\"main.jsp\">版本管理</a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"menu\">\r\n");
      out.write("\t\t\t<a class=\"task-icon-link\" href=\"merge.jsp\">\r\n");
      out.write("\t\t\t\t<img style=\"width: 24px; height: 24px; margin: 2px;\" class=\"icon-user icon-md\" src=\"images/VersionManager.png\">\r\n");
      out.write("\t\t\t</a>&nbsp;\r\n");
      out.write("\t\t\t<a class=\"task-link\" href=\"merge.jsp\">XML合并</a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"menu\">\r\n");
      out.write("\t\t\t<a class=\"task-icon-link\" href=\"export.jsp\">\r\n");
      out.write("\t\t\t\t<img style=\"width: 24px; height: 24px; margin: 2px;\" class=\"icon-user icon-md\" src=\"images/download.png\">\r\n");
      out.write("\t\t\t</a>&nbsp;\r\n");
      out.write("\t\t\t<a class=\"task-link\" href=\"export.jsp\">模型导出</a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"menu\">\r\n");
      out.write("\t\t\t<a class=\"task-icon-link\" href=\"generate.jsp\">\r\n");
      out.write("\t\t\t\t<img style=\"width: 24px; height: 24px; margin: 2px;\" class=\"icon-user icon-md\" src=\"images/download.png\">\r\n");
      out.write("\t\t\t</a>&nbsp;\r\n");
      out.write("\t\t\t<a class=\"task-link\" href=\"generate.jsp\">模型生成</a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"menu\">\r\n");
      out.write("\t\t\t<a class=\"task-icon-link\" href=\"compare.jsp\">\r\n");
      out.write("\t\t\t\t<img class=\"icon-user icon-md\" src=\"images/new.png\">\r\n");
      out.write("\t\t\t</a>&nbsp;\r\n");
      out.write("\t\t\t<a class=\"task-link\" href=\"compare.jsp\">新建比对</a>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("\t<div id=\"compareHistory\">\r\n");
      out.write("\t\t<div class=\"row\">\r\n");
      out.write("\t\t\t<div class=\"pane-header\">\r\n");
      out.write("\t\t\t\tCompare History\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t<div class=\"pane-content\">\r\n");
      out.write("\t\t\t<table id=\"historyList\">\r\n");
      out.write("\t\t\t</table>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div>\r\n");
      out.write("<input name=\"projectName\" type=\"hidden\" id=\"projectName\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${projectName}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\" />\r\n");
      out.write("<input name=\"pageNo\" type=\"hidden\" id=\"pageNo\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageNo}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write('"');
      out.write('/');
      out.write('>');
      out.write("\r\n");
      out.write("\t\t\t");
      out.write("\r\n");
      out.write("<div id=\"Main_Panel\">\r\n");
      out.write("\t<div id=\"Main_Panel_Content\">\r\n");
      out.write("\t\t<table style=\"text-align:left;\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td><span>上传Framework.xml：</span></td>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<div id=\"frameworkDiv\">\r\n");
      out.write("\t\t\t\t\t\t<form id=\"frameworkUpload\"> \r\n");
      out.write("\t\t\t\t     \t   <input type=\"text\" onclick=\"$('#frameworkFile').click()\" id=\"originalFrameworkFileName\" size=\"40\" /> \r\n");
      out.write("\t\t\t\t           <input type=\"button\" onclick=\"$('#frameworkFile').click()\" value=\"浏览\"/>\r\n");
      out.write("\t\t\t\t           <input type=\"file\" id=\"frameworkFile\" name=\"upFile\" style=\"display:none;\"/> &nbsp;\r\n");
      out.write("\t\t\t\t           <input type=\"submit\" value=\"上传\"> \r\n");
      out.write("\t\t\t\t\t    </form>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<div id=\"framework_upload_info\" style=\"width:100%;height:20px;visibility:hidden\" ></div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td><span>上传Entity.xml：</span></td>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<div id=\"entityDiv\">\r\n");
      out.write("\t\t\t\t\t\t<form id=\"entityUpload\"> \r\n");
      out.write("\t\t\t\t     \t   <input type=\"text\" onclick=\"$('#entityFile').click()\" id=\"originalEntityFileName\" size=\"40\" /> \r\n");
      out.write("\t\t\t\t           <input type=\"button\" onclick=\"$('#entityFile').click()\" value=\"浏览\"/>\r\n");
      out.write("\t\t\t\t           <input type=\"file\" id=\"entityFile\" name=\"upFile\" style=\"display:none;\"/> &nbsp;\r\n");
      out.write("\t\t\t\t           <input type=\"submit\" value=\"上传\"> \r\n");
      out.write("\t\t\t\t\t    </form>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<div id=\"entity_upload_info\" style=\"width:100%;height:20px;visibility:hidden\" ></div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<span>上传Type.xml：</span>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t<td>\r\n");
      out.write("\t\t\t\t\t<div id=\"typeDiv\">\r\n");
      out.write("\t\t\t\t\t\t<form id=\"typeUpload\"> \r\n");
      out.write("\t\t\t\t     \t   <input type=\"text\" onclick=\"$('#typeFile').click()\" id=\"originalTypeFileName\" size=\"40\" /> \r\n");
      out.write("\t\t\t\t           <input type=\"button\" onclick=\"$('#typeFile').click()\" value=\"浏览\"/>\r\n");
      out.write("\t\t\t\t           <input type=\"file\" id=\"typeFile\" name=\"upFile\" style=\"display:none;\"/> &nbsp;\r\n");
      out.write("\t\t\t\t           <input type=\"submit\" value=\"上传\"> \r\n");
      out.write("\t\t\t\t\t    </form>\r\n");
      out.write("\t\t\t\t\t</div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<div id=\"type_upload_info\" style=\"width:100%;height:20px;visibility:hidden\" ></div>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t<div>\r\n");
      out.write("\t\t\t<form id=\"mergeCondition\">\r\n");
      out.write("\t\t\t\t<input id=\"frameworkFileRelativePath\" name=\"frameworkFileRelativePath\" type=\"hidden\" value=\"\">\r\n");
      out.write("\t\t\t\t<input id=\"entityFileRelativePath\" name=\"entityFileRelativePath\" type=\"hidden\" value=\"\">\r\n");
      out.write("\t\t\t\t<input id=\"typeFileRelativePath\" name=\"typeFileRelativePath\" type=\"hidden\" value=\"\">\r\n");
      out.write("\t\t\t</form>\r\n");
      out.write("\t\t\t<input id=\"merge\" type=\"button\" value=\"合并\">\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</div> ");
      out.write("\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}