<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="application/force-download; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String fileName = (String)request.getAttribute("FILE_NAME");
response.setHeader("Content-Disposition","attachment; filename=" + fileName);
String xml = (String)request.getAttribute("result");
out.println(xml);
//out.println("download.jsp "+fileName);
%>
