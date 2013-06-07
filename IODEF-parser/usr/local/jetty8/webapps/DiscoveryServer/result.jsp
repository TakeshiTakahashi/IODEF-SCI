<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%
String result = (String)request.getAttribute("result");
out.println(result);
%>