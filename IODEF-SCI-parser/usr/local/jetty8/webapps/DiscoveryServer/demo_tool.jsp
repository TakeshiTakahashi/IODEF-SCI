<?xml version="1.0" encoding="UTF-8" ?>
<%/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="discovery.common.*" %>
<%@ page import="discovery.common.http.*" %>
<%@ page import="discovery.ds.*" %>
<%
Config cfg = Config.load();
String PrimaryServerURL = cfg.primaryServer()+"/msg";
String ServerName = cfg.name()+"/";
String heightStr = cfg.map.get("CANVAS_HEIGHT");
int height = 640;
try {
	if ( heightStr != null )
		height = Integer.parseInt(heightStr);
} catch ( NumberFormatException ex) {
	String msg = ex.getMessage();
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Discovery | Demo Tool</title>
<link rel="stylesheet" type="text/css" media="all" href="css/discovery.css"/>
<script type="text/javascript" charset="utf-8" src="js/jquery-1.7.2.js"></script>
<script type="text/javascript" charset="utf-8" src="js/discovery.js"></script>
<script type="text/javascript" charset="utf-8" src="js/demotool.js"></script>
<script>
var createTopology = function() {
	var ctx = Discovery.ctx;
	// D-Client生成
	var clientNodes = new Array();
	var y = 20;
	for ( var i in Clients ) {
		var id = Clients[i];
		clientNodes.push( new Discovery.Node(ctx,id,20, y,'silver') );
		y += 40;
	}
	// トポロジ生成
	var colors = new Array('blue','yellow','green');
	y = 20;
	for ( var idx in Topologies ) {
		var path = Topologies[idx];
		var nodes = path.split('/');
		var type = 0;
		var x = 120;
		for ( var i in nodes ) {
			var id = nodes[i];
			var color = colors[type];
			if ( Discovery.Node.all[id] == null )
				new Discovery.Node(ctx,id,x,y,color);
			x += 100;
			type++;
		}
		y += 40;
	}
	// トポロジ連結
	for ( var idx in Topologies ) {
		var path = Topologies[idx];
		var nodes = path.split('/');
		var type = 0;
		var prevNode = null;
		for ( var i in nodes ) {
			var id = nodes[i];
			var node = Discovery.Node.all[id];
			if ( type == 0 ) {
				for ( var i in clientNodes ) {
					var client = clientNodes[i];
					client.connect(node);
				}
			} else {
				prevNode.connect(node);
			}
			prevNode = node;
			type++;
		}
		prevNode = null;
	}
	// 間隔を上下に広げる

	// 画面描画
	Discovery.drawAll();
};
var drawAllTopology = function() {
	loadNetInfo(createTopology,true,'<%= PrimaryServerURL %>');
	webSocket.send("KEEP_ALIVE");
};
$(function() {
	// 描画コンテキスト取得
	var canvas = $('#topology').get(0);
	if ( canvas.getContext == undefined )
		return;
	var ctx = canvas.getContext("2d");
	Discovery.ctx = ctx;
	Discovery.width = canvas.width;
	Discovery.height = canvas.height;
	
	// ネットワーク構成情報のロード＆トポロジ作成・描画
	drawAllTopology();
	
	setInterval("drawAllTopology()", DS_PORLING*1000);	//指定秒に一回、ポーリングを開始する
});
</script>
</head>
<body style="min-height:480px;">

<div id="wrapper">

<div id="upper-container" class="vertical box">
</div>

<div id="lower-container" class="vertical box">
<canvas id="topology" width="640px" height="<%= height %>>px">
</canvas>
</div>

</div>

</body>
</html>
