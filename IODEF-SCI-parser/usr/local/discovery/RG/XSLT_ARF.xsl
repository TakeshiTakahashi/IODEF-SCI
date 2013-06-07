<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:ai="http://scap.nist.gov/schema/asset-identification/1.1"
    xmlns:arf="http://scap.nist.gov/schema/asset-reporting-format/1.1"
    xmlns:core="http://scap.nist.gov/schema/reporting-core/1.1"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xccdef="http://checklists.nist.gov/xccdf/1.1"
    xmlns:cpe="http://cpe.mitre.org/dictionary/2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
    xmlns:ontology="http://discovery.nict.go.jp/ontology#"
    xmlns:terms="http://discovery.nict.go.jp/terms#"
>
<xsl:output method="xml" encoding="UTF-8"/>

  <xsl:param name="URI" />
  <xsl:param name="CATEGORY" />
  <xsl:param name="INFOSOURCE_NAME" />
  <xsl:param name="CREATE_DATE" />
  <xsl:param name="UPDATE_DATE" />
  <xsl:param name="AUTH_LEVEL" />
  <xsl:param name="HIT_COUNTER" />

  <!--root(rdf:RDF)-->
  <xsl:template match="/">
    <rdf:RDF>

      <xsl:apply-templates select="/arf:asset-report-collection/arf:reports/arf:report"/>
      <xsl:apply-templates select="/arf:asset-report-collection/arf:assets/arf:asset"/>
      <xsl:apply-templates select="/arf:asset-report-collection/arf:report-requests/arf:report-request"/>

    </rdf:RDF>
  </xsl:template>

  <!-- arf:report -->
  <xsl:template match="arf:report">
    <xsl:variable name="arf-id" select="@id" />
<!--
    <rdf:Description rdf:about="&ontology;ARF">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <arf:report>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      </arf:report>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;ARF" />

      <ontology:SecurityInformation>ARF</ontology:SecurityInformation>
      <ontology:ITEM_TYPE>report</ontology:ITEM_TYPE>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$arf-id"/></ontology:ID>

      <xsl:apply-templates select="arf:content/xccdef:TestResult"/>

    </rdf:Description>
  </xsl:template>

  <!-- arf:TestResult -->
  <xsl:template match="xccdef:TestResult">

      <terms:version><xsl:value-of select="@version"/></terms:version>
      <terms:test-system><xsl:value-of select="@test-system"/></terms:test-system>
      <terms:start-time><xsl:value-of select="@start-time"/></terms:start-time>
      <terms:end-time><xsl:value-of select="@end-time"/></terms:end-time>

      <terms:benchmark><xsl:value-of select="./xccdef:benchmark/@href"/></terms:benchmark>
      <terms:title><xsl:value-of select="./xccdef:title/."/></terms:title>
      <terms:organization><xsl:value-of select="./xccdef:organization/."/></terms:organization>

      <terms:identity><xsl:value-of select="./xccdef:identity/."/></terms:identity>
      <terms:identity-authenticated><xsl:value-of select="./xccdef:identity/@authenticated"/></terms:identity-authenticated>
      <terms:identity-privileged><xsl:value-of select="./xccdef:identity/@privileged"/></terms:identity-privileged>

      <terms:profile><xsl:value-of select="./xccdef:profile/."/></terms:profile>
      <terms:profile-idref><xsl:value-of select="./xccdef:profile/@idref"/></terms:profile-idref>

      <xsl:apply-templates select="xccdef:target-address"/>
      <xsl:apply-templates select="xccdef:target-facts/xccdef:fact"/>
      <xsl:apply-templates select="xccdef:score"/>

  </xsl:template>

  <xsl:template match="xccdef:target-address">
      <terms:target-address><xsl:value-of select="."/></terms:target-address>
  </xsl:template>

  <xsl:template match="xccdef:fact">
      <terms:fact><xsl:value-of select="."/></terms:fact>
      <terms:fact-name><xsl:value-of select="@name"/></terms:fact-name>
      <terms:fact-type><xsl:value-of select="@type"/></terms:fact-type>
  </xsl:template>

  <xsl:template match="xccdef:score">
      <terms:score><xsl:value-of select="."/></terms:score>
      <terms:score-maximum><xsl:value-of select="@maximum"/></terms:score-maximum>
      <terms:score-system><xsl:value-of select="@system"/></terms:score-system>
  </xsl:template>


  <!-- arf:asset -->
  <xsl:template match="arf:asset">
    <xsl:variable name="arf-id" select="@id" />
<!--
    <rdf:Description rdf:about="&ontology;ARF">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <arf:assert>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      </arf:assert>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;ARF" />

      <ontology:SecurityInformation>ARF</ontology:SecurityInformation>
      <ontology:ITEM_TYPE>asset</ontology:ITEM_TYPE>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$arf-id"/></ontology:ID>

      <xsl:apply-templates select="ai:computing-device"/>

    </rdf:Description>

  </xsl:template>

  <xsl:template match="ai:computing-device">
      <terms:fqdn><xsl:value-of select="ai:fqdn/."/></terms:fqdn>
      <xsl:apply-templates select="ai:connections/ai:connection"/>
  </xsl:template>

  <xsl:template match="ai:connection">
      <terms:ip-v4><xsl:value-of select="ai:ip-address/ai:ip-v4/."/></terms:ip-v4>
  </xsl:template>


  <!-- report-request -->
  <xsl:template match="arf:report-request">
    <xsl:variable name="arf-id" select="@id" />
<!--
    <rdf:Description rdf:about="&ontology;ARF">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <arf:report-request>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      </arf:report-request>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/ARF/<xsl:value-of select="$arf-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;ARF" />

      <ontology:SecurityInformation>ARF</ontology:SecurityInformation>
      <ontology:ITEM_TYPE>report-request</ontology:ITEM_TYPE>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$arf-id"/></ontology:ID>

      <xsl:apply-templates select="arf:content/xccdef:Benchmark"/>

    </rdf:Description>

  </xsl:template>

  <!-- Benchmark -->
  <xsl:template match="xccdef:Benchmark">
      <terms:Benchmark-id><xsl:value-of select="@id"/></terms:Benchmark-id>
      <terms:title><xsl:value-of select="xccdef:title"/></terms:title>
      <terms:status-date><xsl:value-of select="xccdef:status/@date"/></terms:status-date>
      <terms:status><xsl:value-of select="xccdef:status/."/></terms:status>
      <terms:description><xsl:value-of select="xccdef:description/xhtml:strong/."/></terms:description>
      <terms:notice-id><xsl:value-of select="xccdef:notice/@id"/></terms:notice-id>
      <terms:notice><xsl:value-of select="xccdef:notice/."/></terms:notice>
      <terms:reference-href><xsl:value-of select="xccdef:reference/@href"/></terms:reference-href>
      <terms:reference-publisher><xsl:value-of select="xccdef:reference/dc:publisher"/></terms:reference-publisher>
      <terms:reference-identifier><xsl:value-of select="xccdef:reference/dc:identifier"/></terms:reference-identifier>
      <terms:platform-idref><xsl:value-of select="xccdef:platform/@idref"/></terms:platform-idref>
      <terms:version><xsl:value-of select="xccdef:version/."/></terms:version>
      <terms:metadata-creator><xsl:value-of select="xccdef:metadata/dc:creator"/></terms:metadata-creator>
      <terms:metadata-publisher><xsl:value-of select="xccdef:metadata/dc:publisher"/></terms:metadata-publisher>
      <terms:metadata-contributor><xsl:value-of select="xccdef:metadata/dc:contributor"/></terms:metadata-contributor>
      <terms:metadata-source><xsl:value-of select="xccdef:metadata/dc:source"/></terms:metadata-source>
      <terms:Profile-id><xsl:value-of select="xccdef:Profile/@id"/></terms:Profile-id>
      <terms:Profile-title><xsl:value-of select="xccdef:Profile/xccdef:title/."/></terms:Profile-title>
      <terms:Profile-description><xsl:value-of select="xccdef:Profile/xccdef:description/."/></terms:Profile-description>
      <terms:Profile-select-idref><xsl:value-of select="xccdef:Profile/xccdef:select/@idref"/></terms:Profile-select-idref>
      <terms:Profile-select-selected><xsl:value-of select="xccdef:Profile/xccdef:select/@selected"/></terms:Profile-select-selected>
      <terms:Rule-id><xsl:value-of select="@id"/></terms:Rule-id>
      <terms:Rule-selected><xsl:value-of select="xccdef:Rule/@selected"/></terms:Rule-selected>
      <terms:Rule-weight><xsl:value-of select="xccdef:Rule/@weight"/></terms:Rule-weight>
      <terms:Rule-title><xsl:value-of select="xccdef:Rule/xccdef:title/."/></terms:Rule-title>
      <terms:Rule-description><xsl:value-of select="xccdef:Rule/xccdef:description/."/></terms:Rule-description>
      <terms:Rule-ident-system><xsl:value-of select="xccdef:Rule/xccdef:ident/@system"/></terms:Rule-ident-system>
      <terms:Rule-ident><xsl:value-of select="xccdef:Rule/xccdef:ident/."/></terms:Rule-ident>
      <terms:Rule-check-system><xsl:value-of select="xccdef:Rule/xccdef:check/@system"/></terms:Rule-check-system>
<!--
      <terms:Rule-check><xsl:value-of select="xccdef:Rule/xccdef:check/."/></terms:Rule-check>
-->
      <terms:Rule-check-check-content-ref-href><xsl:value-of select="xccdef:Rule/xccdef:check/xccdef:check-content-ref/@href"/></terms:Rule-check-check-content-ref-href>
      <terms:Rule-check-check-content-ref-name><xsl:value-of select="xccdef:Rule/xccdef:check/xccdef:check-content-ref/@name"/></terms:Rule-check-check-content-ref-name>
  </xsl:template>

</xsl:stylesheet>
