★2013/5/16時点の最新版ライブラリでの手順となります。

※以降の作業はrootで行います。
１．VM上にCentOS 64bit環境を構築
２．Jdk1.6(jdk-6u45-linux-x64-rpm.bin)インストール
　・インストール
　　http://www.oracle.com/technetwork/java/javase/downloads/jdk6downloads-1902814.html
　　上記で入手したjdk-6u45-linux-x64-rpm.binを実行してください。
３．jetty8(jetty-distribution-8.1.10.v20130312.tar.gz)
　・jettyのインストール
　　http://download.eclipse.org/jetty/stable-8/dist/
　　上記で入手したjettyを解凍して、/usr/local直下にjetty8という名前で配置します。
  ・workディレクトリの作成
    mkdir /usr/local/jetty8/work
４．MySQLのインストール
　・RPMコマンドで上記をインストール
　　MySQL-client-5.6.11-2.linux_glibc2.5.x86_64.rpm
　　MySQL-devel-5.6.11-2.linux_glibc2.5.x86_64.rpm
　　MySQL-server-5.6.11-2.linux_glibc2.5.x86_64.rpm
　　★注意1★
　　　MySQL5.6はDiscovery時のものとインストール手順が大きく異なりますのでご注意ください。
　　　本readme.txtでは以下のサイトを参考にしています。
　　　http://d.hatena.ne.jp/akishin999/20130207/1360241401
　　★注意2★
　　　CentOS6.3の場合、デフォルトでmysql-libs-5.1.61-4.el6がインストールされている
　　　場合があります。その際はrpmコマンドのオプションに--forceを付与してインストールｓ
　　　してください。
　・MySQLの起動
　　service mysql start
　・rootパスワードの確認
　　MySQL5.6の場合、初期インストール時にrootパスワードは自動生成されています。
　　以下のコマンドでパスワードを確認してください。
　　cat /root/.mysql_secret
　　表示された末尾の文字がパスワードとなります。
　・パスワードの変更
　　mysql -u root -p
　　mysql> SET PASSWORD FOR root@localhost=PASSWORD('discovery');
　・DB作成
　　mysql -u root -p
　　mysql> create database iodef;
５．WebAPの配置
　・ファイル一式配置
　　DiscoveryServer
　　Registry
　　InformationSource
　　を/usr/local/jetty8/webapps/にコピー
６．設定ファイル等の配置
　/usr/local/discoveryにDS、RG、ISを配置してください。
７．Jettyの起動
　/usr/local/jetty8/bin/jetty.sh start
　を実行してください。
８．動作確認
　ブラウザにて以下のURLにアクセスし、動作を確認してください。
・Registy
　http://localhost:8080/Registry/index.jsp
　→RegistryのWelcom画面が表示されれば完了です。
・InformationSource
　http://localhost:8080/InformationSource/index.jsp
　→XML FileにGeneratorモジュールで生成したIODEF-SCIファイルを指定してください。
　　「Register XML Data」を押下した後、XML形式で「SUCCESS」と表示されれば完了です。
・DiscoveryServer
　http://localhost:8080/DiscoveryServer/msg?msg=FIND_DS
　→DS-01リンクを選択し、検索画面へ移動してください。
　　その画面のDetail SearchのIncidentIDにInformationSourceで登録したIODEF-SCIファイルのIncidentIDを
　　入力し、「Send Query」ボタンを押下してください。登録したIODEF-SCIの情報が表示されれば
　　完了です。
