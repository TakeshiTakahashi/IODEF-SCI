<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%
String info = this.getServletInfo();
String name = this.getServletName();
ServletContext context = this.getServletContext();
ServletBase.initializeStatic(context);
Config cfg = Config.load();
String[] registers = cfg.register();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Registry | welcome</title>
</head>
<body>
This is Registry top page.<br>
version : <%= cfg.version() %><br>
type : <%= cfg.type() %><br>
name : <%= cfg.name() %><br>
url : <%= cfg.url() %><br>
categories : <%= cfg.map.get("categories") %><br>
<% for (int i=0; i<registers.length; i++ ) { %>
register : <%= "["+i+"] "+registers[i] %><br>
<% } %>
<form id="form01" method="post" action="/Registry/msg">
<input type="hidden" name="msg" value="QUERY_RG">
SPARQL : <textarea name="QUERY" rows="20" cols="80"></textarea><br/>
<input type="submit" value="Query"/><br/>
</form>
<a href="log_rg.jsp">Log viewer</a>
<!-- 
<br/>
<br/>
<br/>
<form id="form02" method="post" action="/Registry/msg">
<input type="hidden" name="msg" value="FORMAT_RG">
<input type="hidden" name="TYPE" value="ALL">
Format All Data in RDF Store : <input type="submit" value="Execute Format"/><br/>
</form>
 -->
</body>
</html>