@echo off

rd /S /Q result
mkdir result


call generateIODEF -v

call generateIODEF -h

call generateIODEF -new result/test1.xml

call generateIODEF -configfile a.config_generateIODEF -new result/test_conf.xml

@rem AttackPattern
@rem new
echo ****AttackPattern start****
call generateIODEF -new result/test_ap01.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234
echo:
call generateIODEF -new result/test_ap02.xml -AttackPattern id http://xml/metadataSharing2.xsd MMDEF-1235
echo:
call generateIODEF -new result/test_ap03.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_ap04.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_ap05.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -new result/test_ap06.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -new result/test_ap07.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml
echo:
call generateIODEF -new result/test_ap08.xml -AttackPattern xml http://xml/metadataSharing2.xsd sample/eicar.xml
echo:
call generateIODEF -new result/test_ap09.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_ap10.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_ap11.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_ap12.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:

@rem add
echo:
call generateIODEF -new result/test_ap_add.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing2.xsd MMDEF-1235
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1235 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing2.xsd sample/eicar.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_ap_add.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:

echo ****AttackPattern end****
echo:
echo:

@rem Platform
echo ****Platform start****
@rem new
call generateIODEF -new result/test_pl01.xml -Platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_pl02.xml -Platform id http://cpe.mitre.org/dictionary/2.0.X CPE-1999-0001
echo:

call generateIODEF -new result/test_pl03.xml -Platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_pl04.xml -Platform xml http://cpe.mitre.org/dictionary/2.0.X sample/cpe__a_3com_3c15100d.xml
echo:

@rem add
call generateIODEF -new result/test_pl_add.xml
echo:
call generateIODEF -add result/test_pl_add.xml -Platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_pl_add.xml -Platform id http://cpe.mitre.org/dictionary/2.0.X CPE-1999-0001
echo:

call generateIODEF -add result/test_pl_add.xml -Platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_pl_add.xml -Platform xml http://cpe.mitre.org/dictionary/2.0.X sample/cpe__a_3com_3c15100d.xml
echo:

echo ****Platform end****
echo:
echo:

@rem Vulnerability
echo ****Vulnerability start****
@rem new
call generateIODEF -new result/test_vul01.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001
echo:
call generateIODEF -new result/test_vul02.xml -Vulnerability id http://cve.mitre_test.org/cve/downloads/1.0 CVE-1999-0001
echo:
call generateIODEF -new result/test_vul03.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_vul04.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_vul05.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -new result/test_vul06.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -new result/test_vul07.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_vul08.xml -Vulnerability xml http://cve.mitre_test.org/cve/downloads/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_vul09.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_vul10.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_vul11.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_vul12.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_vul13.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_vul14.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_vul15.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_vul16.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:

@rem add
call generateIODEF -new result/test_vul_add.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre_test.org/cve/downloads/1.0 CVE-1999-0001
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre_test.org/cve/downloads/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_vul_add.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:


echo ****Vulnerability end****
echo:
echo:

@rem Scoring
echo ****Scoring start****
@rem new
call generateIODEF -new result/test_sc01.xml -Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_sc02.xml -Scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:

@rem add
call generateIODEF -new result/test_sc_add.xml
echo:
call generateIODEF -add result/test_sc_add.xml -Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_sc_add.xml -Scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:

echo ****Scoring end****
echo:
echo:

@rem Weakness
echo ****Weakness start****
@rem new
@rem 正常系　※IanaTblに有効なnamespaceが無いため、Extのみ。
call generateIODEF -new result/test_wk02.xml -Weakness id http://weakness.org/ test-1999-0001
echo:
call generateIODEF -new result/test_wk03.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_wk04.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -new result/test_wk05.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -new result/test_wk06.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -new result/test_wk08.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml
echo:
call generateIODEF -new result/test_wk09.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_wk10.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_wk11.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -new result/test_wk12.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -new result/test_wk13.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_wk14.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_wk15.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_wk16.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:

@rem add
@rem 正常系　※IanaTblに有効なnamespaceが無いため、Extのみ。
call generateIODEF -new result/test_wk_add.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness id http://weakness.org/ test-1999-0001
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness id http://weakness.org/ test-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary2/2.0 CPE-1999-0003
echo:

call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0002 platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0003
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -add result/test_wk_add.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:

echo ****Weakness end****
echo:
echo:


@rem EventReport
echo ****EventReport start****
@rem new
call generateIODEF -new result/test_er01.xml -EventReport id http://cee.mitre.org CEE-1999-0001
echo:
call generateIODEF -new result/test_er02.xml -EventReport id http://cee.mitre2.org CEE-1999-0001
echo:

call generateIODEF -new result/test_er03.xml -EventReport xml http://cee.mitre.org sample/cee-example-event-1.xml
echo:
call generateIODEF -new result/test_er04.xml -EventReport xml http://cee.mitre2.org sample/cee-example-event-1.xml
echo:

@rem add
call generateIODEF -new result/test_er_add.xml
echo:
call generateIODEF -add result/test_er_add.xml -EventReport id http://cee.mitre.org CEE-1999-0001
echo:
call generateIODEF -add result/test_er_add.xml -EventReport id http://cee.mitre2.org CEE-1999-0001
echo:

call generateIODEF -add result/test_er_add.xml -EventReport xml http://cee.mitre.org sample/cee-example-event-1.xml
echo:
call generateIODEF -add result/test_er_add.xml -EventReport xml http://cee.mitre2.org sample/cee-example-event-1.xml

echo ****EventReport end****
echo:
echo:

@rem Verification
echo ****Verification start****
@rem new
call generateIODEF -new result/test_ve01.xml -Verification id http://oval.mitre.org/XMLSchema/oval-results-5 CCE-1999-0001
echo:
call generateIODEF -new result/test_ve02.xml -Verification id http://oval.mitre2.org/XMLSchema/oval-results-5 CCE-1999-0001
echo:

call generateIODEF -new result/test_ve03.xml -Verification xml http://oval.mitre.org/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:
call generateIODEF -new result/test_ve04.xml -Verification xml http://oval.mitre2.org/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:

@rem add
call generateIODEF -new result/test_ve_add.xml
echo:
call generateIODEF -add result/test_ve_add.xml -Verification id http://oval.mitre.org/XMLSchema/oval-results-5 CCE-1999-0001
echo:
call generateIODEF -add result/test_ve_add.xml -Verification id http://oval.mitre2.org/XMLSchema/oval-results-5 CCE-1999-0001
echo:

call generateIODEF -add result/test_ve_add.xml -Verification xml http://oval.mitre.org/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:
call generateIODEF -add result/test_ve_add.xml -Verification xml http://oval.mitre2.org/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:

echo ****Verification end****
echo:
echo:

@rem Remediation
echo ****Remediation start****
@rem new
call generateIODEF -new result/test_rm02.xml -Remediation id http://test.com/XMLSchema/oval-results-5 CCE-1999-0001
echo:
call generateIODEF -new result/test_rm04.xml -Remediation xml http://test.com/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:

@rem add
call generateIODEF -new result/test_rm_add.xml
echo:
call generateIODEF -add result/test_rm_add.xml -Remediation id http://test.com/XMLSchema/oval-results-5 CCE-1999-0001
echo:
call generateIODEF -add result/test_rm_add.xml -Remediation xml http://test.com/XMLSchema/oval-results-5 sample/CCE-13-3.xml
echo:

echo ****Remediation end****
echo:
echo:

echo ****複合 start****
call generateIODEF -new result/test_all01.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 -Vulnerability id http://cve.mitre.org/cve/downloads/1.0 CVE-1999-0001 -Weakness id http://weakness.org/ test-1999-0001 -Platform id http://cpe.mitre.org/dictionary/2.0 CPE-1999-0001 -EventReport id http://cee.mitre.org CEE-1999-0001 -Verification id http://oval.mitre.org/XMLSchema/oval-results-5 CCE-1999-0001 -Remediation id http://test.com/XMLSchema/oval-results-5 CCE-1999-0001 -Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_all02.xml -AttackPattern id http://xml/metadataSharing2.xsd MMDEF-1234 -Vulnerability id http://cve.mitre.org/cve/downloads2/1.0 CVE-1999-0001 -Weakness id http://weakness.org2/ test-1999-0001 -Platform id http://cpe.mitre.org2/dictionary2/2.0 CPE-1999-0001 -EventReport id http://cee.mitre.org2 CEE-1999-0001 -Verification id http://oval.mitre.org/XMLSchema2/oval-results-5 CCE-1999-0001 -Remediation id http://test.com/XMLSchema2/oval-results-5 CCE-1999-0001 -Scoring http://scap.nist.gov/schema/cvss-42/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_all02.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 -Vulnerability id http://cve.mitre.org/cve/downloads2/1.0 CVE-1999-0001 -Weakness id http://weakness.org2/ test-1999-0001 -Platform id http://cpe.mitre.org2/dictionary2/2.0 CPE-1999-0001 -EventReport id http://cee.mitre.org2 CEE-1999-0001 -Verification id http://oval.mitre.org/XMLSchema2/oval-results-5 CCE-1999-0001 -Remediation id http://test.com/XMLSchema2/oval-results-5 CCE-1999-0001 -Scoring http://scap.nist.gov/schema/cvss-42/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_all03.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml -Vulnerability xml http://cve.mitre.org/cve/downloads/1.0 sample/CVE-1999-0001.xml -Weakness xml http://weakness.org/ sample/CWE-5.xml -Platform xml http://cpe.mitre.org/dictionary/2.0 sample/cpe__a_3com_3c15100d.xml -EventReport xml http://cee.mitre.org sample/cee-example-event-1.xml -Verification xml http://oval.mitre.org/XMLSchema/oval-results-5 sample/CCE-13-3.xml -Remediation xml http://test.com/XMLSchema/oval-results-5 sample/CCE-13-3.xml -Scoring http://scap.nist.gov/schema/cvss-v2/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_all04.xml -AttackPattern xml http://xml/metadataSharing2.xsd sample/eicar.xml -Vulnerability xml http://cve.mitre.org/cve/downloads2/1.0 sample/CVE-1999-0001.xml -Weakness xml http://weakness.org2/ sample/CWE-5.xml -Platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml -EventReport xml http://cee.mitre.org2 sample/cee-example-event-1.xml -Verification xml http://oval.mitre.org/XMLSchema2/oval-results-5 sample/CCE-13-3.xml -Remediation xml http://test.com/XMLSchema2/oval-results-5 sample/CCE-13-3.xml -Scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo:
call generateIODEF -new result/test_all05.xml -AttackPattern xml http://xml/metadataSharing.xsd sample/eicar.xml -Vulnerability xml http://cve.mitre.org/cve/downloads2/1.0 sample/CVE-1999-0001.xml -Weakness xml http://weakness.org2/ sample/CWE-5.xml -Platform xml http://cpe.mitre.org/dictionary2/2.0 sample/cpe__a_3com_3c15100d.xml -EventReport xml http://cee.mitre.org2 sample/cee-example-event-1.xml -Verification xml http://oval.mitre.org/XMLSchema2/oval-results-5 sample/CCE-13-3.xml -Remediation xml http://test.com/XMLSchema2/oval-results-5 sample/CCE-13-3.xml -Scoring http://scap.nist.gov/schema/cvss-v4/1.0 sample/CVE-1999-0001.xml
echo ****Vulnerability end****
echo:
echo:

echo ***IODEF編集 start***
call generateIODEF -new result/test_edit.xml
echo:
call generateIODEF -add result/test_edit.xml -edit //Incident/IncidentID editIncidentID
echo:
call generateIODEF -add result/test_edit.xml -edit //Incident/IncidentID/@name aaa.bbb.com
echo ****IODEF編集 end****
echo:
echo:

echo ***IODEF検証 start***
call generateIODEF -new result/test_validate.xml
echo:
call generateIODEF -validate result/test_validate.xml
echo ****IODEF検証 end****
echo:
echo:

echo ***IODEF ReportTime更新 start***
call generateIODEF -new result/test_report.xml
echo:
call generateIODEF -add result/test_report.xml -AttackPattern id http://xml/metadataSharing.xsd MMDEF-1234 -ReportTime_now
echo ****IODEF ReportTime更新 end****
echo:
echo:

echo ***IODEF IANAテーブル指定 start***
call generateIODEF -new result/test_iana.xml -AttackPattern id http://xml/metadataSharing2.xsd MMDEF-1234 -ReportTime_now
echo:
call generateIODEF -add result/test_iana.xml -setIana iana2.tbl -AttackPattern id http://xml/metadataSharing2.xsd MMDEF-1234 -ReportTime_now
echo ****IODEF IANAテーブル指定 end****
echo:
echo:
