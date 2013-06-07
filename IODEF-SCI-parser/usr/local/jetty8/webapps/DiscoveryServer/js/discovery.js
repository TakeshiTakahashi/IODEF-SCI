/**
 * Copyright (C） National Institute of Information and Communications Technology 2013
 */
var PDS_URL = '';
var DS_URL = '';
var DS_PAGE = 50;
var DS_LIMIT = 10;
var DS_PORLING = 60;
var MSG_NEW_LIST = 'Waiting for New Entries.';
var MSG_RESULT_LIST = 'Waiting for Query Results.';
var MSG_RESULT_TOO_LARGE = 'Result set is too large. Please add more conditions.';
var Topologies = new Array();
var Clients = new Array();

var IS_OPEN = "-";
var IS_CLOSE = "+";

function loadNetInfo(callback,isMulti,url) {
	if ( url == undefined )
		url = DS_URL;
	var url2 = url + "?msg=NET_INFO_DS";
	$.ajax({
		url: url2,
		dataType: "text", 
		success: function(data, dataType){
			var lines = data.split('\n');
			for ( var i in lines ) {
				var line = lines[i];
				var ss = line.split('=');
				switch ( ss[0] ) {
				case 'PDS_URL': PDS_URL = ss[1]; break;
				case 'DS_PAGE': DS_PAGE = ss[1]; break;
				case 'DS_LIMIT': DS_LIMIT = ss[1]; break;
				case 'DS_PORLING': DS_PORLING = ss[1]; break;
				case 'MSG_RESULT_TOO_LARGE': MSG_RESULT_TOO_LARGE = ss[1]; break;
				case 'TOPOLOGY':
					var tp = ss[1].split(',');
					for ( var i in tp )
						Topologies.push(tp[i].trim());
					break;
				case 'CLIENTS':
					var ss2 = ss[1].split(',');
					for ( var key in ss2 )
						Clients[key] = key;
					break;
				}
			}
			
			if ( callback != undefined )
				callback();
		},
		error: function(XMLHttpRequest, textStatus, errorThrown){
			// 通常はここでtextStatusやerrorThrownの値を見て処理を切り分けるか、  
			// 単純に通信に失敗した際の処理を記述します。  this; 
			// thisは他のコールバック関数同様にAJAX通信時のオプションを示します。
		},
	});
}

var clickedLevel = 0;
var PrevParam = '';

var leavBtn = function(e) {
	webSocket.leave = true;
	webSocket.send("user1", "LEAVE_DS");
	location.href = DS_URL + "?msg=LEAVE_DS";
};

var treeToggle = function (e) {
	var node = $(e.target);
	var text = node.text();
	var show = (text == IS_CLOSE);
	treeToggleBody(node, show, true);
	clickedLevel = 0;
};
function treeToggleBody(node,show,clevel) {
	var li = $(node.closest('li')[0]);
	var text = li.text();
	var level = getLevel(li) + 1;
	if ( level < 0 ) return;
	
	if ( clevel != undefined )
		clickedLevel = level;

	node.text(show ? IS_OPEN : IS_CLOSE);
	//var nextClass = '.tree'+level;
	if ( show ) {
		//1レベルだけ
		var nexts = li.nextAll();
		nexts.each(function () {
			var nli = $(this);
			var nlevel = getLevel(nli);
			if ( nlevel == clickedLevel ) {
				nli.show();
				//var nextNode = nli.children('.tree');
				//nextNode.text(IS_OPEN);
			} else {
				return (nlevel >= clickedLevel);	//違う枝に達した
			}
		});
	} else {
		//これより下のレベル全部
		var nexts = li.nextAll();
		nexts.each(function () {
			var nli = $(this);
			var nlevel = getLevel(nli);
			if ( nlevel < level )
				return (nlevel >= clickedLevel);
			
			nli.hide();
			var nextNode = nli.children('.tree');
			nextNode.text(IS_CLOSE);
		});
	}
}
function getLevel(node) {
	var c = node.attr('class');
	if ( c == undefined )
		return -1;
	var level = Number(c.substring(4));
	return level;
}

function openDialog2(dialog,id) {
	var dialog = $('#'+id);
	dialog.fadeIn();
}
function openDialog(e,id) {
	var obj = e.target;
	var btn = $(obj);
	var dialog = $('#'+id);
	var str = btn.attr('id');
	if ( str == null || str == undefined )
		str = btn.text();
	var ss = str.split('-');
	var title = dialog.find('#'+id+'-title');
	title.text(ss[0]);
	dialog.fadeIn();
}
function closeDialog(id) {
	var dialog = $('#'+id);
	dialog.fadeOut();
}
function sendMessage(url) {
	try {
		$.get(url);
	} catch(ex) {
		alert(ex);
	}
}
function searchFunc(e, id, url, fixPaging) {
	var selector = '#'+id+'-inner';
	var selector_all = selector + '>*';
	var selector_tmp = '#loading-tmp';
	var selector_tmp_all = selector_tmp + '>*';
	var panel = $(selector);
	var tmp = $(selector_tmp);
	$(selector_all).remove();
	panel.append('<p>'+MSG_RESULT_LIST+'</p>');
	if ( fixPaging ) {
		hidePaging(selector);
	}
	//AJAX通信で結果を取得する
	try {
		//送信実行・コールバック
		tmp.load(url,null,function() {
			//生成されたHTML断片をpanelに埋め込む
			$(selector_all).remove();
			$(selector_tmp_all).appendTo(selector);
			$(selector_tmp_all).remove();
			if ( fixPaging ) {
				fixPagingExec(selector);
			}
		});
	} catch (ex) {
		alert(ex);
	}
	if ( e != null ) {
		$('#err_message').text('');
		$('#result_count').text('');
		openDialog(e,id);
	}
}
function executeQuery(e,urlParam, page) {
	urlParam += '&PARSE=1';
	PrevParam = urlParam;
	urlParam += ('&PAGE='+page+'&PAGE_SIZE='+DS_PAGE+'&PAGE_LIMIT='+DS_LIMIT);
	//alert('executeQuery url='+DS_URL+urlParam);
	searchFunc(e,'resultList',urlParam, true);
}
function pagingBtnFunc(e, id) {
	var btn = $(e.target);
	var bid = btn.attr('id');
	var page = bid.substring(1);
	var url = PrevParam+'&PAGE='+page;
	$('span.paging').addClass('link');
	btn.removeClass('link');
	//alert('paging panel id='+id+' URL='+url);
	searchFunc(null,'resultList',url);
}
function hidePaging() {
	$('span.paging').each(function() {
		$(this).hide();
	});
}
function fixPagingExec(selector) {
	var resultCount = $(selector+' > span.resultCount').text();
	var count = 0;
	if ( resultCount != null && resultCount != undefined && resultCount != "" && resultCount != "null" ) {
		count = Number(resultCount);
	} else {
		//エラー表示
		var msg = $(selector+' > span.returnVal').text();
		$('#err_message').text('Query Error! '+msg);
		return;
	}
	var maxPage = Math.ceil(count / DS_PAGE);
	$('span.paging').each(function() {
		var id = $(this).attr('id');
		var page = id.substring(1);
		var pageNum = Number(page);
		if ( pageNum <= maxPage )
			$(this).show();
		else
			$(this).hide();
	});
	$('#result_count').text(resultCount);
	var max = DS_LIMIT*DS_PAGE;
	if ( count > max ) {
		//「もっと絞り込んで」のアドバイス
		$('#err_message').text(MSG_RESULT_TOO_LARGE);
		$('#result_count').text('More than '+max);
	}
}
function getWebSocketLocation() {
	var location = document.location.toString().replace('http://','ws://').replace('https://','wss://');
	return location;
}
function initWebSocket() {
	if ( !window.WebSocket && window.MozWebSocket )
		window.WebSocket=window.MozWebSocket;
	if (!window.WebSocket)
		alert("WebSocket not supported by this browser");
}
var webSocket = {
	init : function(handler) {
		var orgAddress = location.href.replace("https:","wss:").replace("http:","ws:");
		var pos = orgAddress.lastIndexOf("/");
		var address = orgAddress.substr(0,pos);
		this.ws = new WebSocket(address+"/ws","JOIN_DS");
		this.ws.onopen = this.onOpen;
		this.ws.onmessage = this.onMessage;
		this.ws.onclose = this.onClose;
		this.ws.handler = this.handler = handler;
	},
	leave : false,
	handler : null,
	onOpen : function() {
        this.send('JOIN_DS');
	},
	onMessage : function(msg) {
        if ( msg.data ) {
        	if ( this.handler != null )
        		this.handler();
        }
	},
	onClose : function() {
		if ( this.leave )
			this.send('LEAVE_DS');
		else
	        this.send('JOIN_DS');
	},
	send : function(message) {
        if (this.ws)
          this.ws.send(message);
	}
};
