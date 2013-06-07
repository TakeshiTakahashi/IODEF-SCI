// 名前空間：Discovery
Discovery = function(){};
Discovery.ctx = null;
// 全画面描画
Discovery.drawAll = function() {
	Discovery.ctx.fillStyle = 'white';
	Discovery.ctx.fillRect(0, 0, Discovery.width, Discovery.height);
	Discovery.ctx.fill();
	for ( var id in Discovery.Node.all )
		Discovery.Node.all[id].drawConnection();
	for ( var id in Discovery.Node.all )
		Discovery.Node.all[id].draw();
};

// クラス：Discovery.Node
Discovery.Node = function (ctx,id,x,y,color) {
	this.ctx = ctx;
	this.id = id;
	this.x = x;
	this.y = y;
	this.w = 32;
	this.h = 20;
	this.color = color;
	this.hilight = false;
	this.connections = new Array();
	Discovery.Node.all[id] = this;
};
// エクステント
Discovery.Node.all = new Array();
// メソッド
Discovery.Node.prototype = {
	//相対移動
	move : function(x,y) {
		this.x += x;
		this.y += y;
		return this;
	},
	//絶対移動
	moveTo : function(x,y) {
		this.x = x;
		this.y = y;
		return this;
	},
	//接続を描画
	drawConnection : function() {
		for ( var i in this.connections )
			this.connections[i].draw();
	},
	//描画
	draw : function() {
		this.ctx.beginPath();
		this.ctx.moveTo(this.x-this.w/2, this.y-this.h/2);
		this.ctx.lineTo(this.x+this.w/2, this.y-this.h/2);
		this.ctx.lineTo(this.x+this.w/2, this.y+this.h/2);
		this.ctx.lineTo(this.x-this.w/2, this.y+this.h/2);
		this.ctx.closePath();
		this.ctx.fillStyle = this.color;
		this.ctx.strokeStyle = this.hilight ? 'red' : 'black';
		this.ctx.fill();
		this.ctx.stroke();
		this.ctx.fillStyle = 'black';
		this.ctx.strokeStyle = 'black';
		this.ctx.fillText(this.id,this.x-this.w/2+4,this.y);
		return this;
	},
	//接続
	connect : function(node) {
		this.connections[node.id] = new Discovery.Connection(this.ctx,this,node);
		return this;
	},
};

//クラス：Discovery.Connection
Discovery.Connection = function(ctx,start,end) {
	this.ctx = ctx;
	this.start = start;
	this.end = end;
	this.hilight = false;
	this.isStrong = false;
};
//メソッド
Discovery.Connection.prototype = {
	//描画
	draw : function(color,width) {
		if ( color == undefined )
			color = this.color;
		if ( width == undefined )
			width = this.width;
		
		this.ctx.beginPath();
		this.ctx.moveTo(this.start.x, this.start.y);
		this.ctx.lineTo(this.end.x, this.end.y);
		this.ctx.closePath();
		this.ctx.strokeStyle = this.hilight ? 'red' : 'black';
		this.ctx.lineWidth = this.isStrong ? 2 : 1;
		this.ctx.stroke();
	}
};

