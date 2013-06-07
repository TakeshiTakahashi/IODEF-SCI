<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%@ page import="discovery.ds.*" %>
<%
	String xml = (String) request.getAttribute("result");
	if (request.getParameter("PARSE") == null) {
		out.println(xml);
		return;
	}
	ResultParser parser = new ResultParser();
	List<String[]> results = parser.parse(xml);
%>
<span class="resultCount" style="display:none"><%= parser.count %></span>
<span class="returnVal" style="display:none"><%= parser.returnVal %></span>
<table>
<tbody>
<tr>
<%	for ( String colName : parser.columns ) { %>
<th><%= colName %></th>
<%	} %>
</tr>
<%	for ( String[] row : results) { %>
<tr>
<%
		for ( int idx = 0; idx < parser.columns.size(); idx++ ) {
			String value = row[idx];
			if ( value.startsWith("XF:qmail-leng no longer exists;") )
				xml = value;//for break point
%>
<td><%= value %></td>
<%		} %>
</tr>
<%	} %>
</tbody>
</table>