<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%@ page import="discovery.ds.*" %>
<%
String info = this.getServletInfo();
String name = this.getServletName();
ServletContext context = this.getServletContext();
ServletBase.initializeStatic(context);
Config cfg = Config.load();
String[] registers = cfg.register();
String result = (String)request.getAttribute("result");
String[] servers = DiscoveryServerImpl.getServers(result);
String PrimaryServerURL = cfg.primaryServer()+"/msg?msg=FIND_DS";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Discovery Server | welcome</title>
</head>
<body>
This is DiscoveryServer top page.<br/>
version : <%= cfg.version() %><br>
type : <%= cfg.type().toString() %><br/>
name : <%= cfg.name() %><br/>
url : <%= cfg.url() %><br/>
<% for (int i=0; i < registers.length; i++ ) { %>
registers : <%= "["+i+"] "+registers[i] %><br/>
<% } %>
<% if ( servers != null ) { %>
<div id="ServerList">
<p>Primary Server</p>
Discovery Servers List : <br/>
<%   for (int i=0; i < servers.length; i++ ) { %>
<%     String[] svr = servers[i].split("="); %>
<%="["+i+"] "%><a href="<%= svr[1]%>msg?msg=JOIN_DS"><%=svr[0] %></a><br/>
<%   } %>
</div>
<% } %>
<a href="<%= PrimaryServerURL %>">To PrimaryServer</a>
<a href="log_ds.jsp">Log viewer</a>
</body>
</html>