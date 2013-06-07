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
    xmlns:scap-core="http://scap.nist.gov/schema/scap-core/0.1" 
    xmlns:patch="http://scap.nist.gov/schema/patch/0.1" 
    xmlns:cpe-lang="http://cpe.mitre.org/language/2.0" 
    xmlns:nvd="http://scap.nist.gov/schema/feed/vulnerability/2.0" 
    xmlns:vuln="http://scap.nist.gov/schema/vulnerability/0.4" 
    xmlns:cvss="http://scap.nist.gov/schema/cvss-v2/0.2" 

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

      <xsl:apply-templates select="/nvd:nvd/nvd:entry"/>

    </rdf:RDF>
  </xsl:template>

  <!--entry-->
  <xsl:template match="nvd:entry">
    <xsl:variable name="nvd-id" select="@id" />
<!--
    <rdf:Description rdf:about="&ontology;NVD">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <nvd:entry>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      </nvd:entry>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;NVD" />

      <ontology:SecurityInformation>NVD</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$nvd-id"/></ontology:ID>
      <ontology:InformationSummary><xsl:value-of select="vuln:summary"/></ontology:InformationSummary>
      <terms:summary><xsl:value-of select="vuln:summary"/></terms:summary>
      <terms:cwe-id><xsl:value-of select="vuln:cwe/@id"/></terms:cwe-id>
      <terms:cve-id><xsl:value-of select="vuln:cve-id"/></terms:cve-id>
      <terms:published-datetime><xsl:value-of select="vuln:published-datetime"/></terms:published-datetime>
      <terms:last-modified-datetime><xsl:value-of select="vuln:last-modified-datetime"/></terms:last-modified-datetime>
    </rdf:Description>

    <xsl:apply-templates select="vuln:vulnerable-configuration"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="vuln:vulnerable-software-list/*"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="vuln:assessment_check"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="vuln:references"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="vuln:scanner"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="vuln:cvss"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>

  </xsl:template>

  <!-- vuln:vuln:vulnerable-configuration -->
  <xsl:template match="vuln:vulnerable-configuration">
    <xsl:param name="nvd-id"/>
    <xsl:apply-templates select="cpe-lang:logical-test"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
  </xsl:template>

  <!-- cpe-lang:logical-test -->
  <xsl:template match="cpe-lang:logical-test">
    <xsl:param name="nvd-id"/>
    <xsl:apply-templates select="cpe-lang:logical-test"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
    <xsl:apply-templates select="cpe-lang:fact-ref"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
  </xsl:template>

  <!-- fact-ref -->
  <xsl:template match="cpe-lang:fact-ref">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:fact-ref><xsl:value-of select="@name"/></terms:fact-ref>
    </rdf:Description>
  </xsl:template>

  <!-- product -->
  <xsl:template match="vuln:product">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:product><xsl:value-of select="."/></terms:product>
    </rdf:Description>
  </xsl:template>

  <!-- vuln:assessment_check -->
  <xsl:template match="vuln:assessment_check ">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:assessment_check-name><xsl:value-of select="@name"/></terms:assessment_check-name>
      <terms:assessment_check-href><xsl:value-of select="@href"/></terms:assessment_check-href>
    </rdf:Description>
  </xsl:template>

  <!-- vuln:references -->
  <xsl:template match="vuln:references">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:reference_type><xsl:value-of select="@reference_type"/></terms:reference_type>
      <terms:reference-source><xsl:value-of select="vuln:source"/></terms:reference-source>
      <terms:reference-href><xsl:value-of select="vuln:reference/@href"/></terms:reference-href>
      <terms:reference><xsl:value-of select="vuln:reference/."/></terms:reference>
    </rdf:Description>
  </xsl:template>

  <!-- vuln:scanner -->
  <xsl:template match="vuln:scanner">
    <xsl:param name="nvd-id"/>
    <xsl:apply-templates select="vuln:definition"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
  </xsl:template>
  <!-- vuln:scanner -->
  <xsl:template match="vuln:definition">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:definition-name><xsl:value-of select="@name"/></terms:definition-name>
      <terms:definition-href><xsl:value-of select="@href"/></terms:definition-href>
      <terms:definition-system><xsl:value-of select="@system"/></terms:definition-system>
    </rdf:Description>
  </xsl:template>

  <!-- vuln:cvss -->
  <xsl:template match="vuln:cvss">
    <xsl:param name="nvd-id"/>
    <xsl:apply-templates select="cvss:base_metrics"><xsl:with-param name="nvd-id" select="$nvd-id"/></xsl:apply-templates>
  </xsl:template>
  <!-- cvss:base_metrics -->
  <xsl:template match="cvss:base_metrics">
    <xsl:param name="nvd-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/NVD/<xsl:value-of select="$nvd-id"/></xsl:attribute>
      <terms:score><xsl:value-of select="cvss:score/."/></terms:score>
      <terms:access-vector><xsl:value-of select="cvss:access-vector/."/></terms:access-vector>
      <terms:access-complexity><xsl:value-of select="cvss:access-complexity/."/></terms:access-complexity>
      <terms:authentication><xsl:value-of select="cvss:authentication/."/></terms:authentication>
      <terms:confidentiality-impact><xsl:value-of select="cvss:confidentiality-impact/."/></terms:confidentiality-impact>
      <terms:integrity-impact><xsl:value-of select="cvss:integrity-impact/."/></terms:integrity-impact>
      <terms:availability-impact><xsl:value-of select="cvss:availability-impact/."/></terms:availability-impact>
      <terms:source><xsl:value-of select="cvss:source/."/></terms:source>
      <terms:generated-on-datetime><xsl:value-of select="cvss:generated-on-datetime/."/></terms:generated-on-datetime>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
