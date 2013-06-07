<?xml version="1.0" encoding="UTF-8" ?>
<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Discovery Client | Main page</title>
</head>
<body>
<form id="query_new_form" method="post" action="msg?msg=QUERY_DS&TYPE=SELECT_NEW">
Time stamp : <input type="text" name="TIMESTAMP"/><input type="submit" value="Send Query"/>
</form>
<form id="query_category_form" method="post" action="msg?msg=QUERY_DS&TYPE=SELECT_CATEGORY">
Category : <input type="text" name="CATEGORY"/><input type="text" name="PAGE" value="0"/><input type="submit" value="Send Query"/>
</form>
<form id="query_keyword_form" method="post" action="msg?msg=QUERY_DS&TYPE=SELECT_KEYWORD">
Keyword : <input type="text" name="KEYWORD"/><input type="text" name="PAGE" value="0"/><input type="submit" value="Send Query"/>
</form>
<form id="query_detail_form" method="post" action="msg?msg=QUERY_DS&TYPE=SELECT_DETAIL">
Condition1 : <input type="text" name="NAME1"/><input type="text" name="VALUE1"/><input type="text" name="EXT1"/><br/>
Condition2 : <input type="text" name="NAME2"/><input type="text" name="VALUE2"/><input type="text" name="EXT2"/><br/>
Condition3 : <input type="text" name="NAME3"/><input type="text" name="VALUE3"/><input type="text" name="EXT3"/><br/>
Condition4 : <input type="text" name="NAME4"/><input type="text" name="VALUE4"/><input type="text" name="EXT4"/><br/>
Condition5 : <input type="text" name="NAME5"/><input type="text" name="VALUE5"/><input type="text" name="EXT5"/><br/>
<input type="text" name="PAGE" value="0"/><input type="submit" value="Send Query"/>
</form>
<div id="query_result">
</div>
</body>
</html>