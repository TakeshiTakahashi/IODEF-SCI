===============================
　　環境構成
===============================

■　実行環境
JDK/JRE 1.6
環境変数PATHにJREを含める

■　ファイル一覧

lib/
	ライブラリフォルダ
lib/toolsIODEF.jar
	プログラム本体
lib/iana.tbl
	IANAテーブルファイル
lib/.config_generateIODEF -jar lib/iodefTools.jar
	デフォルト設定ファイル
lib/.usage
	ヘルプファイル

schema/
	スキーマフォルダ
schema/iodef-sci.xsd
	iodefスキーマファイル
schema/iodef_schema.xsd
	iodef拡張スキーマファイル
schema/dc.xsd
	DublinCoreスキーマ
schema/dcmitype.xsd
	DublinCoreデータ型スキーマ
schema/dcterms.xsd
	DublinCore Termsスキーマ
schema/cee.xsd
	CEEスキーマ
schema/common.xsd
	CVRFスキーマ
schema/cpe-dictionary_2.3.xml
	CPE dictionaryスキーマ
schema/cpe-naming_2.3.xml
	CPE namingスキーマ
schema/cpe-language_2.3.xsd
	CPE languageスキーマ
schema/cve_1.0.xsd
	CVEスキーマ
schema/cvss-v2_0.9.xsd
	CVSSスキーマ
schema/cwe_schema_v5.1.xsd
schema/MAEC_v1.1.xsd
	MAECスキーマ
schema/metadataSharing.xsd
	MMDEFスキーマ
schema/observables_v0.4.xsd
	CAPECスキーマ
schema/ocil-2.0.xml
	OCILスキーマ
schema/oval-common-schema.xsd
	OVAL commonスキーマ
schema/oval-definitions-schema.xsd
	OVAL definitionsスキーマ
schema/oval-results-schema.xsd
	OVAL resultsスキーマ
schema/oval-system-characteristics-schema.xsd
	OVAL system characteristicsスキーマ
schema/results_3.1.xsd
	JVNDBスキーマ
schema/xccdf_1.2.xml
	XCCDFスキーマ
schema/xml.xsd
	XMLスキーマ
schema/xmldsig-core-schema.xsd
	XML Signatureスキーマ
schema/XMLSchema.xsd
	XML Schemaスキーマ

sample/
	テスト用データファイル
sample/CCE-13-3-err.xml
	CCEデータファイル　エラー版
sample/CCE-13-3.xml
	CCEデータファイル
sample/cee-example-event-1-err.xml
	CEEデータファイル　エラー版
sample/cee-example-event-1.xml
	CEEデータファイル
sample/cpe__a_3com_3c15100d-err.xml
	CPEデータファイル　エラー版
sample/cpe__a_3com_3c15100d.xml
	CPEデータファイル
sample/CVE-1999-0001-err.xml
	CVEデータファイル　エラー版
sample/CVE-1999-0001.xml
	CVEデータファイル
sample/cvss01-err.xml　エラー版
	CVSSデータファイル
sample/cvss01.xml
	CVSSデータファイル
sample/CWE-5-err.xml
	CWEデータファイル　エラー版
sample/CWE-5.xml
	CWEデータファイル
sample/CWE-5-org.xml
	CWEデータファイル　(修正前版・参考用)
sample/eicar-err.xml
	MMDEFデータファイル　エラー版
sample/eicar.xml
	MMDEFデータファイル
sample/ios-sample-1.0.xccdf-err.xml
	XCCDFデータファイル　エラー版
sample/ios-sample-1.0.xccdf.xml
	XCCDFデータファイル
sample/maec-example-act-1-err.xml
	MAECデータファイル　エラー版
sample/maec-example-act-1.xml
	MAECデータファイル
sample/oval-definitions-2011-err.xml
	OVAL definitionsデータファイル　エラー版
sample/oval-definitions-2011.xml
	OVAL definitionsデータファイル
sample/scap-win2000-OCIL-err.xml
	OCILデータファイル　エラー版
sample/scap-win2000-OCIL.xml
	OCILデータファイル
sample/remediation-001.xml
	Remediationのテスト用サンプル

===============================
　　操作方法
===============================

■　バージョン表示
java -jar lib/iodefTools.jar -v 

<出力メッセージ>
GenerateIODEF 1.0


■　ヘルプ表示
java -jar lib/iodefTools.jar -h 

<出力メッセージ>
sage: [-v -h] [-configfile filename] [-new filename [force]]|[-add filename] [-{ExData} [id|xml] namespace [dataID|xmlFilename] [platform [id|xml] namespace [dataID|xmlFilename]] [scoring namespace xmlFilename]]
       {ExData}=[AttackPatten|Vulnerability|Weakness|Platform|EventReport|Verification|Remediation|Scoring]


■　新規作成 成功
<<XML埋め込み>>
java -jar lib/iodefTools.jar -new test.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml

<出力メッセージ>
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
selected ApplicableClass : AttackPattern
add Element <iodef-sci:AttackPattern>
ReportTime was updated.
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.55 sec

<<ID指定>>
java -jar lib/iodefTools.jar -new test.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234

<出力メッセージ>
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
selected ApplicableClass : AttackPattern
add Attribute AttackPatternID=MMDEF-1234
ReportTime was updated.
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.17 sec

■　新規作成 失敗 既存ファイル
java -jar lib/iodefTools.jar -new test.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml

<出力メッセージ>
test.xml is already exists,


■　新規作成 成功 既存ファイル 強制上書き
java -jar lib/iodefTools.jar -new test.xml force -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml

<出力メッセージ>
test.xml is already exists,
 force overwrited.
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
selected ApplicableClass : AttackPattern
add Element <iodef-sci:AttackPattern>
ReportTime was updated.
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.18 sec


■　新規作成 失敗 コマンド指定ミス
「AttackPattern」に配置されるはずの名前空間で「-Platform」を指定した場合
java -jar lib/iodefTools.jar -new test.xml -Platform xml http://xml/metadataSharing.xsd sample/eicar.xml

<出力メッセージ>
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
Invalid ApplicableClass : AttackPattern
Please specify : Platform


■　新規作成 失敗 スキーマエラー
java -jar lib/iodefTools.jar -new test.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar-err.xml

<出力メッセージ>
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
selected ApplicableClass : AttackPattern
add Element <iodef-sci:AttackPattern>
ReportTime was updated.
test.xml validation : FAIL
cvc-complex-type.2.4.a: Invalid content was found starting with element 'qqq'. One of '{"http://xml/metadataSharing.xsd":company}' is expected.
test.xml was NOT saved
Total elapsed time : 0.22 sec


■　追加 成功
java -jar lib/iodefTools.jar -add test.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml

<出力メッセージ>
test.xml validation : SUCCESS
add Element : <AdditionalData>
IANA TABLE [Specification] Common Vulnerability and Exposures [Version] 1.0 [URI] http://cve.mitre.org/
selected ApplicableClass : Vulnerability
add Element <iodef-sci:Vulnerability>
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.18 sec


■　追加 失敗 コマンド指定ミス
「Vulnerability」に配置されるはずの名前空間で「-Platform」を指定した場合
java -jar lib/iodefTools.jar -add test.xml -Platform xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml

<出力メッセージ>
test.xml validation : SUCCESS
add Element : <AdditionalData>
IANA TABLE [Specification] Common Vulnerability and Exposures [Version] 1.0 [URI] http://cve.mitre.org/
Invalid ApplicableClass : Vulnerability
Please specify : Platform


■　追加 失敗 スキーマエラー
java -jar lib/iodefTools.jar -add test.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001-err.xml

<出力メッセージ>
test.xml validation : SUCCESS
add Element : <AdditionalData>
IANA TABLE [Specification] Common Vulnerability and Exposures [Version] 1.0 [URI] http://cve.mitre.org/
selected ApplicableClass : Vulnerability
add Element <iodef-sci:Vulnerability>
test.xml validation : FAIL
cvc-complex-type.2.4.a: Invalid content was found starting with element 'xxx'. One of '{"http://cve.mitre.org/cve/downloads/1.0":phase, "http://cve.mitre.org/cve/downloads/1.0":desc}' is expected.
test.xml was NOT saved
Total elapsed time : 0.19 sec


■　XML要素 編集 成功
java -jar lib/iodefTools.jar -add test.xml -edit //Incident/IncidentID 12345

<出力メッセージ>
test.xml validation : SUCCESS
set NodeValue: //Incident/IncidentID = 12345
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.18 sec


■　XML要素 編集 失敗
java -jar lib/iodefTools.jar -add test.xml -edit //Incident/IncidentzzID 12345

<出力メッセージ>
test.xml validation : SUCCESS
//Incident/IncidentzzID not found


■　XML属性 編集 成功
java -jar lib/iodefTools.jar -add test.xml -edit //Incident/IncidentID/@name aaa.bbb.com

<出力メッセージ>
test.xml validation : SUCCESS
set Attribute: //Incident/IncidentID/@name = aaa.bbb.com
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.18 sec


■　XML属性 編集 失敗
java -jar lib/iodefTools.jar -add test.xml -edit //Incident/IncidentIDzz/@name aaa.bbb.com

<出力メッセージ>
test.xml validation : SUCCESS
//Incident/IncidentIDzz/@name not found


■　デフォルト値設定ファイル切り替え
java -jar lib/iodefTools.jar -configfile a.config_generateIODEF -new test.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml

<出力メッセージ>
a.config_generateIODEF validation : SUCCESS
add Element : <AdditionalData>
IANA TABLE [Specification] Malware Metadata Exchange Format [Version] 1.2 [URI] http://standards.ieee.org/develop/indconn/icsg/mmdef.html
selected ApplicableClass : AttackPattern
add Element <iodef-sci:AttackPattern>
ReportTime was updated.
test.xml validation : SUCCESS
test.xml was saved.
Total elapsed time : 0.21 sec


■　新規作成 or 追加で指定可能な名前空間

ドラフトのIANAテーブルの候補となっているもののうち、別表にまとめた名前空間が利用可能です。
指定方法のサンプルを下記に示します。

-AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml
-AttackPattern xml http://xml/metadataSharing.xsd sample/eicar-err.xml
-AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234

-AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
-AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d-err.xml
-AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 platform id http://cpe.mitre.org/dictionary/2.0 cpe:/a:3com:3c15100d

-Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml
-Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001-err.xml
-Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001

-Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/cvss01.xml
-Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/cvss01-err.xml

-Weakness xml http://cwe.mitre.org/5.0 sample/CWE-5.xml
-Weakness xml http://cwe.mitre.org/5.0 sample/CWE-5-err.xml
-Weakness id http://cwe.mitre.org/5.0  CWE-5

-Platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
-Platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d-err.xml
-Platform id http://cpe.mitre.org/dictionary/2.0 cpe__a_3com_3c15100d

-EventReport xml http://cee.mitre.org sample/cee-example-event-1.xml
-EventReport xml http://cee.mitre.org sample/cee-example-event-1-err.xml
-EventReport id http://cee.mitre.org cee-example-event-1

-EventReport xml http://maec.mitre.org/XMLSchema/maec-core-2 sample/maec-example-act-1.xml
-EventReport xml http://maec.mitre.org/XMLSchema/maec-core-2 sample/maec-example-act-1-err.xml
-EventReport id http://maec.mitre.org/XMLSchema/maec-core-2 maec-example-act-1

-Verification xml http://cce.mitre.org sample/CCE-13-3.xml
-Verification xml http://cce.mitre.org sample/CCE-13-3-err.xml
-Verification id http://cce.mitre.org CCE-13-3

-Remediation xml http://remediation.org sample/remediation-001.xml
-Remediation id http://remediation.org sample/remediation-001
	→ドラフトのIANAテーブル欄に記載なし、暫定のものを登録してテストしています。

-Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/cvss01.xml
-Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/cvss01-err.xml
