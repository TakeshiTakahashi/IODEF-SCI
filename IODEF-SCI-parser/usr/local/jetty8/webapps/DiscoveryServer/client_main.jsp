<?xml version="1.0" encoding="UTF-8" ?>
<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%@ page import="discovery.ds.*" %>
<%
ServletContext context = this.getServletContext();
ServletBase.initializeStatic(context);
Config cfg = null;
try {
	cfg = Config.load();
} catch ( IOException ex ) {
	response.sendRedirect("msg?msg=JOIN_DS");
	return;
}
String PrimaryServerURL = cfg.primaryServer()+"/msg";
String ServerURL = cfg.url()+"/msg";
String ServerName = cfg.name();
String PageSize = cfg.map.get("PAGE_SIZE");
String PageLimit = cfg.map.get("PAGE_LIMIT");
Map<String,String> map = FileUtil.loadTextMap("Client.msgs");
String MSG_RESULT_TOO_LARGE = map.get("MSG_RESULT_TOO_LARGE");
String MSG_NEW_LIST = map.get("MSG_WAIT_NEW");
String MSG_RESULT_LIST = map.get("MSG_WAIT_QUERY");

List<TreeNode> categories = TreeNode.loadNodes("Category.tags","");
String categoriesAct = "catAct";

List<TreeNode> tagTree = TreeNode.loadNodes("TagTree.tags","ontology:,terms:");
String tagTreeAct = "tagTreeAct";

@SuppressWarnings("unchecked")
Map<String,String> args = (Map<String,String>)request.getAttribute("args");
if ( args == null ) {
	response.sendRedirect(PrimaryServerURL+"?msg=FIND_DS");
	return;
}
List<String[]> configList = DiscoveryServerImpl.getNewsConfig(args);

Map<String,String> nameTable = FileUtil.loadTextMap("CategoryNames.tbl");
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Discovery Client | Main page</title>
<link rel="stylesheet" type="text/css" media="all" href="css/discovery.css"/>
<script type="text/javascript" charset="utf-8" src="js/jquery-1.7.2.js"></script>
<script type="text/javascript" charset="utf-8" src="js/discovery.js"></script>
<script>
	$(function() {
		PDS_URL = '<%= PrimaryServerURL %>';
		DS_URL = '<%= ServerURL %>';
		DS_PAGE = <%= PageSize %>;
		DS_LIMIT = <%= PageLimit %>;
		MSG_NEW_LIST = '<%= MSG_NEW_LIST %>';
		MSG_RESULT_LIST = '<%= MSG_RESULT_LIST %>';
		MSG_RESULT_TOO_LARGE = '<%= MSG_RESULT_TOO_LARGE %>';
		
		//各ボタンへの処理のバインド
		$('input.leav-btn').bind('click', leavBtn);
		$('span.catAct').bind('click', catAct);
		$('span.tagTreeAct').bind('click', tagTreeAct);
		$('span.tree').bind('click', treeToggle);
		$('input.detailSearch').bind('click', detailSearch);
		$('.close-resultList').bind('click', closeResultSet);
		$('.open-tagTree').bind('click', openTagTree);
		$('.close-tagTree').bind('click', closeTagTree);
		$('input.keyword-query').bind('click', keywordQuery);
		$('.paging').bind('click', pagingBtn);
		$('.open-newsConfig').bind('click', openNewsConfig);
		$('input.save-newsConfig').bind('click', saveNewsConfig);
		$('span.close-newsConfig').bind('click', closeNewsConfig);
		
		loadNetInfo();
		setInterval("keepAlive()", 60*1000);	//指定秒に一回、WebSocketのKeep Aliveを送信する
		setInterval("porling()", DS_PORLING*1000);	//指定秒に一回、ポーリングを開始する
		newList();
		webSocket.init(newList);
	});
	var openResultSet = function(e) {
		openDialog(e, 'resultList');
	};
	var closeResultSet = function(e) {
		closeDialog('resultList');
	};
	//タグ選択ツリーを開く
	var openTagTree = function(e) {
		openDialog(e, 'tagTree');
		var btn = $(e.target);
		var val = btn.attr('id');
		var ss = val.split('-');
		tagTreeName = ss[0];
	};
	var tagTreeName = null;
	var nameTable = {
<%
    int nameTableCount = 0; 
    for ( String name : nameTable.keySet() ) {
        String dname = nameTable.get(name);
%>
        <%= (nameTableCount++ == 0) ? "" : "," %>'<%= dname %>': '<%= name %>'
<%  } %>
	};	
	var closeTagTree = function(e) {
		closeDialog('tagTree');
	};
	var pagingBtn = function(e) {
		pagingBtnFunc(e, 'resultList');
	};
	//キーワード検索
	var keywordQuery = function(e) {
		var input = $('#KEYWORD');
		var val = encodeURI(input.val());
		var fix = $('#FIX').attr('checked');
		fix = (fix == undefined) ? 'off' : 'on';
		var urlParam = '?msg=QUERY_DS' + '&TYPE=SELECT_KEYWORD&KEYWORD=' + val + '&FIX=' + fix;
		executeQuery(e, urlParam, 0);
	};
	//カテゴリ選択ツリーのノードをクリックした際の処理
	var catAct = function(e) {
		var btn = $(e.target);
		var val = btn.text();
		var urlParam = '?msg=QUERY_DS&TYPE=SELECT_CATEGORY';
		if ( isFormatType(val) )
			urlParam += '&FORMAT_TYPE=' + getFormatType(val);
		else if ( isCategory(val) )
			urlParam += '&CATEGORY=' + getCategoryName(val);
		executeQuery(e, urlParam, 0);
	};
	function isFormatType(name) {
		return (name.charAt(name.length-1) == '*');
	}
	function getFormatType(name) {
		return isFormatType(name) ? nameTable[name.substr(0,name.length-1)] : name;
	}
	function isCategory(name) {
		return (name.indexOf(':') < 0);
	}
	function getCategoryName(name) {
		name = name.replace('&','$');
		return encodeURI(name);
	}
	function setCategoryType(name,val) {
		$('#' + tagTreeName).val(name);
		var prefix = (tagTreeName.charAt(0) == 'n') ? '#n' : '#';
		var num = tagTreeName.charAt(tagTreeName.length-1);
		$(prefix+'VALUE' + num).val(val);
		$(prefix+'FIX' + num).attr('checked','checked');
	}
	//タグ選択ツリーのノードをクリックした際の処理
	var tagTreeAct = function(e) {
		var btn = $(e.target);
		var val = btn.text();
		if ( isFormatType(val) ) {
			var fmt = getFormatType(val);
			setCategoryType('ontology:SecurityInformation',fmt);
		} else if ( isCategory(val) ) {
			var cat = val;
			setCategoryType('ontology:CATEGORY',cat);
		} else {
			$('#' + tagTreeName).val(val);
		}
		closeDialog('tagTree');
	};
	//詳細検索のボタンをクリックした際の処理
	var detailSearch = function(e) {
		var urlParam = '?msg=QUERY_DS&TYPE=SELECT_DETAIL&PARSE=1';
		urlParam = getDetailSearchParam(urlParam,'');
		executeQuery(e, urlParam, 0);
	};
	//興味情報設定のボタンをクリックした際の処理
	var openNewsConfig = function(e) {
		openDialog(e, 'newsConfig');
	};
	//興味情報保存のボタンをクリックした際の処理
	var saveNewsConfig = function(e) {
		var urlParam = '?msg=NEWSCONFIG_DS';
		urlParam = getDetailSearchParam(urlParam,'n');
		sendMessage(urlParam);
		closeNewsConfig();
	};
	var closeNewsConfig = function(e) {
		closeDialog('newsConfig');
	};
	function getDetailSearchParam(urlParam,type) {
		for ( var i = 1; i <= 5; i++ ) {
			var nameID = type+"NAME" + i;
			var name = $('#'+nameID).val();
			var valID = type+"VALUE" + i;
			var val = encodeURI( $('#'+valID).val().trim() );
			var extID = type+"EXT" + i;
			var ext = $('#'+extID).val();
			var fixID = type+"FIX" + i;
			var fix = $('#'+fixID).attr('checked');
			fix = (fix == undefined) ? 'off' : 'on';
			if ( name == "" || val == "" )
				continue;
			//Servlet側がURLエンコードされていても'&'をパラメータ区切りと判断するので'$'に置き換える
			if ( name == "ontology:CATEGORY" )
				val = val.replace('&','$');
			urlParam += ('&'+nameID+'='+name);
			urlParam += ('&'+valID+'='+val);
			urlParam += ('&'+extID+'='+ext);
			urlParam += ('&'+fixID+'='+fix);
		}
		return urlParam;
	}
	function keepAlive() {
		webSocket.send("KEEP_ALIVE");
	}
	//一定周期で新着情報を取得する
	function porling() {
		var onOff = $('#checkNewInfo').is(':checked');
		if (onOff == true)
			newList();
	}
	//新着情報取得
	function newList() {
		var urlParam = '?msg=QUERY_DS&TYPE=SELECT_NEW&PARSE=1';
		searchFunc(null, 'new-list', urlParam);
	};
</script>
</head>
<body style="min-height:480px;">

<div id="wrapper">

<div id="upper-container" class="vertical box">

<div id="keyword-search" class="vertical box">
<table class="hfill" style="height:40px;">
<tbody>
<tr><th colspan="3">Keyword Search:</th></tr>
<tr><th>Keyword</th><th>Complete Match</th><th></th></tr>
<tr>
<td><input type="text" id="KEYWORD" name="KEYWORD" class="fill"/></td>
<td class="nallow" title="Complete Match"><input type="checkbox" id="FIX" class="center-box"/></td>
<td style="width:5em"><input type="submit" id="KEYWORD-btn" value="Send Query" class="fill keyword-query" style="height:24px;"/></td>
</tr>
</tbody>
</table>
</div><!-- keyword-search -->

<div id="detail-search" class="vertical box">
<table class="fill">
<tbody>
<tr><th colspan="5">Detail Search:</th></tr>
<tr><th>Category Tag</th><th>Select Tag</th><th>Value</th><th>Complete Match</th><th>Inc/Exc</th></tr>
<tr>
<td title="Category Tag Name"><input type="text" id="NAME1" name="NAME1" class="readonly" value="terms:IncidentID" readonly="readonly"/></td>
<td title="Select Tag from Tree" class="nallow"><!-- <input type="button" id="NAME1-btn" value="..." disabled="disabled" class="open-tagTree hfill" style="hight:24px;"/> --></td>
<td title="Input value of this tag"><input type="text" id="VALUE1" name="VALUE1" class="fill"/></td>
<td title="Check for Complete Match" class="nallow"><input type="checkbox" id="FIX1" name="FIX1" class="center-box"/></td>
<td title="Select Include or Exclude this condition" class="middle">
<select id="EXT1" name="EXT1" class="fill"><option value="0">Include</option><option value="1">Exclude</option></select>
</td>
</tr>
<% for ( int i = 2; i <= 5; i++) { %>
<tr>
<td title="Category Tag Name"><input type="text" id="NAME<%= i %>" name="NAME<%= i %>" class="fill"/></td>
<td title="Select Tag from Tree" class="nallow"><input type="button" id="NAME<%= i %>-btn" value="..." class="open-tagTree hfill" style="hight:24px;"/></td>
<td title="Input value of this tag"><input type="text" id="VALUE<%= i %>" name="VALUE<%= i %>" class="fill"/></td>
<td title="Check for Complete Match" class="nallow"><input type="checkbox" id="FIX<%= i %>" name="FIX<%= i %>" class="center-box"/></td>
<td title="Select Include or Exclude this condition" class="middle">
<select id="EXT<%= i %>" name="EXT<%= i %>" class="fill"><option value="0">Include</option><option value="1">Exclude</option></select>
</td>
</tr>
<% } %>
<tr>
<td colspan="5">
<input type="submit" id="detail-search-btn" value="Send Query" class="floatright detailSearch"/>
</td>
</tr>
</tbody>
</table>
</div><!-- detail-search -->

</div><!-- upper-container -->

<!-- category-tree
<div id="lower-container" class="vertical vfill" style="min-height:200px;">
<div id="category-tree" class="horizontal box floatleft">
<span class="h3">Category:</span>
<div  class="scrollable box" style="min-height:180px;">
<ul class="tree">
<%= TreeNode.makeTree(categories, categoriesAct) %>
</ul>
</div>
</div>
-->
<!-- category-tree -->

<!-- 
<div id="new-list" class="horizontal box floatright">
-->
<div id="new-list2" class="vertical box">
<span class="h3">News:</span>&nbsp;check NewInfo:<input type="checkbox" id="checkNewInfo"/>
<!-- 
<span class="link open-newsConfig">Open NewsConfig</span>
-->
<div id="new-list-inner" class="scrollable box" style="min-height:180px;">
<p id="msg-new-list"><%= MSG_NEW_LIST %></p>
</div>
</div><!-- new-list -->
<input type="button" value="Leave from Server" class="leav-btn"/>
<!-- 
</div>
 -->
<!-- lower-container -->

</div><!-- wrapper -->

<div id="newsConfig" class="dialog-wide box2">
<span class="h3">News Config</span>
<span class="btn close-newsConfig floatright">x</span>
<div id="newsConfig-inner" class="box">
<table class="fill">
<tbody>
<tr><th>Category Tag</th><th>Select Tag</th><th>Value</th><th>Complete Match</th><th>Inc/Exc</th></tr>
<% for ( int i = 1; i <= 5; i++) { %>
<tr>
<td title="Category Tag Name"><input type="text" id="nNAME<%= i %>" name="nNAME<%= i %>" class="fill" value="<%= DiscoveryServerImpl.getConfigField(configList,i,0)%>"/></td>
<td title="Select Tag from Tree" class="nallow"><input type="button" id="nNAME<%= i %>-btn" value="..." class="open-tagTree hfill"/></td>
<td title="Input value of this tag"><input type="text" id="nVALUE<%= i %>" name="nVALUE<%= i %>" class="fill"  value="<%= DiscoveryServerImpl.getConfigField(configList,i,3)%>"/></td>
<td title="Check for Complete Match" class="nallow"><input type="checkbox" id="nFIX<%= i %>" name="nFIX<%= i %>" title="Complete Match" <%= DiscoveryServerImpl.getConfigField(configList,i,2)%> class="center-box"/></td>
<td title="Select Include or Exclude this condition" class="middle">
<select id="nEXT<%= i %>" name="nEXT<%= i %>" class="fill">
<option value="0" <%= DiscoveryServerImpl.getConfigSelect(configList,i,0)%>>Include</option>
<option value="1" <%= DiscoveryServerImpl.getConfigSelect(configList,i,1)%>>Exclude</option>
</select>
</td>
</tr>
<% } %>
<tr>
<td colspan="4">
<input type="submit" id="save-newsConfig-btn" value="Save Config" class="floatright save-newsConfig"/>
</td>
</tr>
</tbody>
</table>
</div><!-- newsConfig-inner -->
</div><!-- newsConfig -->

<div id="resultList" class="dialog-wide box2">
<span id="resultList-title" class="h3"></span>&nbsp;<span class="h3">Result List</span>
<span class="btn close-resultList floatright">x</span>
<div id="resultList-inner" class="scrollable">
<p><%= MSG_RESULT_LIST %></p>
</div><!-- resultList-inner -->
<ul class="horizontal hfill">
<li><span class="h4">Pages:</span></li>
<li><span id="p1" style="display:none;" class="link paging">&nbsp;1&nbsp;</span></li>
<li><span id="p2" style="display:none;" class="link paging">&nbsp;2&nbsp;</span></li>
<li><span id="p3" style="display:none;" class="link paging">&nbsp;3&nbsp;</span></li>
<li><span id="p4" style="display:none;" class="link paging">&nbsp;4&nbsp;</span></li>
<li><span id="p5" style="display:none;" class="link paging">&nbsp;5&nbsp;</span></li>
<li><span id="p6" style="display:none;" class="link paging">&nbsp;6&nbsp;</span></li>
<li><span id="p7" style="display:none;" class="link paging">&nbsp;7&nbsp;</span></li>
<li><span id="p8" style="display:none;" class="link paging">&nbsp;8&nbsp;</span></li>
<li><span id="p9" style="display:none;" class="link paging">&nbsp;9&nbsp;</span></li>
<li><span id="p10" style="display:none;" class="link paging">&nbsp;10&nbsp;</span></li>
<li>&nbsp;&nbsp;&nbsp;</li>
<li class="nowrap"> Total : <span id="result_count"></span> Items</li>
</ul><br/>
<div class="hfill" style="height:32px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span id="err_message" class="error"></span></div>
</div><!-- resultList -->

<div id="tagTree" class="dialog-nallow box2">
<span id="tagTree-title" class="h3"></span>&nbsp;<span class="h3">Node Select</span>
<span class="btn close-tagTree floatright">x</span>
<div id="tagTree-inner" class="scrollable box" style="height:480px;">
<ul class="tree">
<%= TreeNode.makeTree(tagTree, tagTreeAct) %>
</ul>
</div><!-- tagTree-inner -->
</div><!-- tagTree -->

<div id="loading-tmp" style="display:none;">
</div>

</body>
</html>
