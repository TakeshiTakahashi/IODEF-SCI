<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String xml = (String)request.getAttribute("result");
out.println(xml);
//out.println("xml.jsp");
%>
