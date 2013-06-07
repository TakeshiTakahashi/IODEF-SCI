<?xml version="1.0" encoding="UTF-8" ?>
<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%
String orgLogName = "Registry.log";
final String CHECKED = "checked=\"checked\"";
String change = request.getParameter("change");
String info = (change == null || request.getParameter("info") != null) ? CHECKED : "";
String fine = (change == null || request.getParameter("fine") != null) ? CHECKED : "";
String logType = request.getParameter("log");
boolean isServlet = (logType != null && logType.equals("servlet"));
String servletLog = isServlet ? CHECKED : "";
String orgLog  = isServlet ? "" : CHECKED;

String logName = isServlet ? "servletbase.log" : orgLogName;
ServletContext context = this.getServletContext();
ServletBase.initializeStatic(context);
Config cnf = Config.load();
FileUtil.pushBasePath(cnf.map.get("LOG_PATH"));
String xml = FileUtil.loadText(logName);
FileUtil.popBasePath();
List<String> log = ConvertXML.divideItems(xml, "record");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Registry | Log Viewer</title>
<style>
td.nowrap { white-space:nowrap; }
th span { float: left; }
td { border-bottom:1px solid #d5d5d5; }
th { border-bottom:1px solid black; }
div.scrollable {
	height:480px;
	display:block;
	overflow:auto;
}
</style>
</head>
<body>
<form method="get" action="log_rg.jsp">
<input type="hidden" name="change" value="on"/>
INFO:<input type="checkbox" name="info" <%= info %> />&nbsp;
FINE:<input type="checkbox" name="fine" <%= fine %> />&nbsp;
Servlet LOG:<input type="radio" name="log" <%= servletLog %> value="servlet"/>&nbsp;
Registry LOG:<input type="radio" name="log" <%= orgLog %> value="org"/>&nbsp;
<input type="submit"/>
</form>
<div class="scrollable">
<table>
<tr><th><span>Date</span></th><th><span>Type</span></th><th><span>Method</span></th><th><span>Message</span></th></tr>
<% for ( String record : log ) { %>
<%   String level = ConvertXML.findElement(record, "level", 0); %>
<%   if ( level.equals("INFO") && !info.equals(CHECKED) ) continue; %>
<%   if ( level.equals("FINE") && !fine.equals(CHECKED) ) continue; %>
<tr>
<td><%= level %></td>
<td class="nowrap"><%= ConvertXML.findElement(record, "date", 0) %></td>
<td><%= ConvertXML.findElement(record, "method", 0) %></td>
<td><%= ConvertXML.findElement(record, "message", 0) %></td>
</tr>
<% } %>
</table>
</div>
</body>
</html>