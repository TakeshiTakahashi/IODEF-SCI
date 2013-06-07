===============================
　　環境構成
===============================

■　実行環境
JDK/JRE 1.6
環境変数PATHにJREを含める

■　ファイル一覧

lib/
	ライブラリフォルダ
lib/ExchangeIODEF.jar
	プログラム本体
Config.properties
	設定ファイル

===============================
　　操作方法
===============================

■　設定ファイルありの場合
java -jar lib/ExchangeIODEF.jar xmlFilePath

xmlFilePath
	送信XMLファイル

■　設定ファイルなしの場合
java -jar lib/ExchangeIODEF.jar -url parserURL xmlFilePath

parserURL
	IODEFパーサのURL。'/source'まで指定する。
	例）https://abc.com/IodefParser/source


===============================
　　設定ファイル
===============================

■設定ファイルの名称
Config.properties
ファイル名は固定。

■設定ファイルのパス
プログラム実行時のカレントパス

■設定項目
url=URL文字列
    例）url=http://abc.com/InformationSource/msg

proxy=ProxyのURL
    例) proxy=http://proxy.abc.com

<<デバッグ用>>
credential=SSL認証タイプ
    自己署名サーバ証明書を認める
    例）credential=ALLOW_SELF_CREDENTIAL

