===============================
�@�@���\��
===============================

���@���s��
JDK/JRE 1.6
���ϐ�PATH��JRE���܂߂�

���@�t�@�C���ꗗ

lib/
	���C�u�����t�H���_
lib/ExchangeIODEF.jar
	�v���O�����{��
Config.properties
	�ݒ�t�@�C��

===============================
�@�@������@
===============================

���@�ݒ�t�@�C������̏ꍇ
java -jar lib/ExchangeIODEF.jar xmlFilePath

xmlFilePath
	���MXML�t�@�C��

���@�ݒ�t�@�C���Ȃ��̏ꍇ
java -jar lib/ExchangeIODEF.jar -url parserURL xmlFilePath

parserURL
	IODEF�p�[�T��URL�B'/source'�܂Ŏw�肷��B
	��jhttps://abc.com/IodefParser/source


===============================
�@�@�ݒ�t�@�C��
===============================

���ݒ�t�@�C���̖���
Config.properties
�t�@�C�����͌Œ�B

���ݒ�t�@�C���̃p�X
�v���O�������s���̃J�����g�p�X

���ݒ荀��
url=URL������
    ��jurl=http://abc.com/InformationSource/msg

proxy=Proxy��URL
    ��) proxy=http://proxy.abc.com

<<�f�o�b�O�p>>
credential=SSL�F�؃^�C�v
    ���ȏ����T�[�o�ؖ�����F�߂�
    ��jcredential=ALLOW_SELF_CREDENTIAL

