<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%
String info = this.getServletInfo();
String name = this.getServletName();
ServletContext context = this.getServletContext();
ServletBase.initializeStatic(context);
Config cfg = Config.load();
String url = cfg.url().trim();
String[] registers = cfg.register();
List<String> categories = FileUtil.loadTextList("Category.tags");
CategoryDef[] defs = CategoryDef.loadAll();
String admin = request.getParameter("ADMIN");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Information Source | welcome</title>
<script type="text/javascript" charset="utf-8" src="js/jquery-1.7.2.js"></script>
<script type="text/javascript" charset="utf-8" src="js/discovery.js"></script>
<script type="text/javascript">
$(function() {
	$('#format-btn').bind('click', doFormat);
	$('#register-btn').bind('click', checkCategory);
});
var formatType = null;
var doFormat = function(e) {
	formatType = $('#format-type').val();
	if ( formatType == null || formatType == '' ) {
		alert('No Format type is specified.');
	} else if ( window.confirm('DELETE All XML data of Format ['+formatType+']. OK ?') ) {
		//RDFStoreからの削除をInfoSourceに要請する
		var url = "<%= cfg.url() %>/msg?msg=DELETE_IS&TYPE="+formatType+"&URI=<%= url %>";
		sendMessage(url, function() {
			$('#format-type').val("----");
			alert('Delete data of Format '+formatType+' Done.');
		});
	}
	return false;
};
var checkCategory = function(e) {
	var cat = $('#category').val();
	if ( cat == null || cat == undefined || cat == '' ) {
		alert('Please select Category.');
		return false;
	}
	var path = $('#path').val();
	if ( path == null || path == undefined || path == '' ) {
		alert('Please select XML data file.');
		return false;
	}
	return true;
};
</script>
</head>
<body>
This is Information Source top page.<br>
Servlet version : <%= cfg.version() %><br>
Servlet type : <%= cfg.type() %><br>
Servlet name : <%= cfg.name() %><br>
Servlet url : <%= cfg.url() %><br>
<% for (int i=0; i<registers.length; i++ ) { %>
Servlet register : <%= "["+i+"] "+registers[i] %><br>
<% } %>
<form id="form01" method="post" action="/InformationSource/msg" enctype="multipart/form-data">
<input type="hidden" name="msg" value="REGISTRATION_IS">
<input type="hidden" id="category" name="category" value="Root/Incident Database">
<input type="hidden" id="type" name="type" value="IODEF">
<!-- 
Category : 
<select id="category" name="category">
<% for ( String cat : categories ) { %>
<%     String[] ss = cat.split("/");%>
<%     String catName = ss[ss.length-1];%>
<%     if ( catName.equals("Root") ) continue; %>
<option value="<%= cat %>" selected="selected"><%= catName %></option>
<% } %>
</select>
<br/>
Format type : 
<select id="type" name="type">
<option value="">----</option>
<% for ( CategoryDef def : defs ) { %>
<option value="<%= def.name() %>"><%= def.displayName() %></option>
<% } %>
</select>
<br/>
 -->
XML File : <input type="file" id="path" name="path"/>
<br/>
<input type="submit" id="register-btn" value="Register XML Data"/>
</form>
<br/>
<br/>
<% if ( admin != null && admin.equals("FORMAT") ) { %>
Format All Data in RDF Store of this type : 
<select id="format-type">
<option value="">----</option>
<% for ( CategoryDef def : defs ) { %>
<option value="<%= def.name() %>"><%= def.displayName() %></option>
<% } %>
</select>
<br/>
<input type="button" id="format-btn" value="Execute Format"/><br/>
<% } %>
<br/>
<a href="log_is.jsp">Log viewer</a>
</body>
</html>