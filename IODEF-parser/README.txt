��2013/5/16���_�̍ŐV�Ń��C�u�����ł̎菇�ƂȂ�܂��B

���ȍ~�̍�Ƃ�root�ōs���܂��B
�P�DVM���CentOS 64bit�����\�z
�Q�DJdk1.6(jdk-6u45-linux-x64-rpm.bin)�C���X�g�[��
�@�E�C���X�g�[��
�@�@http://www.oracle.com/technetwork/java/javase/downloads/jdk6downloads-1902814.html
�@�@��L�œ��肵��jdk-6u45-linux-x64-rpm.bin�����s���Ă��������B
�R�Djetty8(jetty-distribution-8.1.10.v20130312.tar.gz)
�@�Ejetty�̃C���X�g�[��
�@�@http://download.eclipse.org/jetty/stable-8/dist/
�@�@��L�œ��肵��jetty���𓀂��āA/usr/local������jetty8�Ƃ������O�Ŕz�u���܂��B
  �Ework�f�B���N�g���̍쐬
    mkdir /usr/local/jetty8/work
�S�DMySQL�̃C���X�g�[��
�@�ERPM�R�}���h�ŏ�L���C���X�g�[��
�@�@MySQL-client-5.6.11-2.linux_glibc2.5.x86_64.rpm
�@�@MySQL-devel-5.6.11-2.linux_glibc2.5.x86_64.rpm
�@�@MySQL-server-5.6.11-2.linux_glibc2.5.x86_64.rpm
�@�@������1��
�@�@�@MySQL5.6��Discovery���̂��̂ƃC���X�g�[���菇���傫���قȂ�܂��̂ł����ӂ��������B
�@�@�@�{readme.txt�ł͈ȉ��̃T�C�g���Q�l�ɂ��Ă��܂��B
�@�@�@http://d.hatena.ne.jp/akishin999/20130207/1360241401
�@�@������2��
�@�@�@CentOS6.3�̏ꍇ�A�f�t�H���g��mysql-libs-5.1.61-4.el6���C���X�g�[������Ă���
�@�@�@�ꍇ������܂��B���̍ۂ�rpm�R�}���h�̃I�v�V������--force��t�^���ăC���X�g�[����
�@�@�@���Ă��������B
�@�EMySQL�̋N��
�@�@service mysql start
�@�Eroot�p�X���[�h�̊m�F
�@�@MySQL5.6�̏ꍇ�A�����C���X�g�[������root�p�X���[�h�͎�����������Ă��܂��B
�@�@�ȉ��̃R�}���h�Ńp�X���[�h���m�F���Ă��������B
�@�@cat /root/.mysql_secret
�@�@�\�����ꂽ�����̕������p�X���[�h�ƂȂ�܂��B
�@�E�p�X���[�h�̕ύX
�@�@mysql -u root -p
�@�@mysql> SET PASSWORD FOR root@localhost=PASSWORD('discovery');
�@�EDB�쐬
�@�@mysql -u root -p
�@�@mysql> create database iodef;
�T�DWebAP�̔z�u
�@�E�t�@�C���ꎮ�z�u
�@�@DiscoveryServer
�@�@Registry
�@�@InformationSource
�@�@��/usr/local/jetty8/webapps/�ɃR�s�[
�U�D�ݒ�t�@�C�����̔z�u
�@/usr/local/discovery��DS�ARG�AIS��z�u���Ă��������B
�V�DJetty�̋N��
�@/usr/local/jetty8/bin/jetty.sh start
�@�����s���Ă��������B
�W�D����m�F
�@�u���E�U�ɂĈȉ���URL�ɃA�N�Z�X���A������m�F���Ă��������B
�ERegisty
�@http://localhost:8080/Registry/index.jsp
�@��Registry��Welcom��ʂ��\�������Ί����ł��B
�EInformationSource
�@http://localhost:8080/InformationSource/index.jsp
�@��XML File��Generator���W���[���Ő�������IODEF-SCI�t�@�C�����w�肵�Ă��������B
�@�@�uRegister XML Data�v������������AXML�`���ŁuSUCCESS�v�ƕ\�������Ί����ł��B
�EDiscoveryServer
�@http://localhost:8080/DiscoveryServer/msg?msg=FIND_DS
�@��DS-01�����N��I�����A������ʂֈړ����Ă��������B
�@�@���̉�ʂ�Detail Search��IncidentID��InformationSource�œo�^����IODEF-SCI�t�@�C����IncidentID��
�@�@���͂��A�uSend Query�v�{�^�����������Ă��������B�o�^����IODEF-SCI�̏�񂪕\��������
�@�@�����ł��B
