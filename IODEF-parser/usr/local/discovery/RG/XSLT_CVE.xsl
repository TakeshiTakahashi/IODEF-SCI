<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:ontology="http://discovery.nict.go.jp/ontology#"
    xmlns:terms="http://discovery.nict.go.jp/terms#"
    xmlns:cve="http://cve.mitre.org/cve/downloads"
>
  
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:variable name="cve-id" />
  <xsl:param name="URI" />
  <xsl:param name="CATEGORY" />
  <xsl:param name="INFOSOURCE_NAME" />
  <xsl:param name="CREATE_DATE" />
  <xsl:param name="UPDATE_DATE" />
  <xsl:param name="AUTH_LEVEL" />
  <xsl:param name="HIT_COUNTER" />

  <!--root(cve)-->
  <xsl:template match="/">
    <rdf:RDF>

      <xsl:apply-templates select="/cve:cve/cve:item"/>

    </rdf:RDF>
  </xsl:template>

  <!--item-->
  <xsl:template match="cve:item">
    <xsl:variable name="cve-id" select="@name" />
<!--
    <rdf:Description rdf:about="&ontology;CVE">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ontology:item>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      </ontology:item>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CVE" />
      <ontology:SecurityInformation>CVE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="@name"/></ontology:ID>
      <terms:type><xsl:value-of select="@type"/></terms:type>
      <terms:seq><xsl:value-of select="@seq"/></terms:seq>
      <xsl:apply-templates select="cve:status"/>
      <xsl:apply-templates select="cve:phase"/>
      <xsl:apply-templates select="cve:desc"/>
    </rdf:Description>

    <xsl:apply-templates select="cve:refs">
      <xsl:with-param name="cve-id" select="$cve-id"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="cve:votes">
      <xsl:with-param name="cve-id" select="$cve-id"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="cve:comments">
      <xsl:with-param name="cve-id" select="$cve-id"/>
    </xsl:apply-templates>

  </xsl:template>

  <!--status-->
  <xsl:template match="cve:status">
    <terms:status><xsl:value-of select="."/></terms:status>
  </xsl:template>
  
  <!--phase-->
  <xsl:template match="cve:phase">
    <terms:phase-date><xsl:value-of select="@date"/></terms:phase-date>
    <terms:phase><xsl:value-of select="."/></terms:phase>
  </xsl:template>

  <!--desc-->
  <xsl:template match="cve:desc">
    <ontology:InformationSummary><xsl:value-of select="."/></ontology:InformationSummary>
    <terms:desc><xsl:value-of select="."/></terms:desc>
  </xsl:template>

  <!--ref-->
  <xsl:template match="/cve:cve/cve:item/cve:refs/cve:ref">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:ref><xsl:value-of select="."/></terms:ref>
      <terms:ref-source><xsl:value-of select="@source"/></terms:ref-source>
      <terms:ref-url><xsl:value-of select="@url"/></terms:ref-url>
    </rdf:Description>
  </xsl:template>

  <!--accept-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:accept">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:accept><xsl:value-of select="."/></terms:accept>
    </rdf:Description>
  </xsl:template>

  <!--modify-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:modify">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:modify><xsl:value-of select="."/></terms:modify>
    </rdf:Description>
  </xsl:template>

  <!--noop-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:noop">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:noop><xsl:value-of select="."/></terms:noop>
    </rdf:Description>
  </xsl:template>

  <!--recast-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:recast">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:recast><xsl:value-of select="."/></terms:recast>
    </rdf:Description>
  </xsl:template>

  <!--reject-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:reject">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:reject><xsl:value-of select="."/></terms:reject>
    </rdf:Description>
  </xsl:template>

  <!--reviewing-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:reviewing">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:reviewing><xsl:value-of select="."/></terms:reviewing>
    </rdf:Description>
  </xsl:template>

  <!--revote-->
  <xsl:template match="/cve:cve/cve:item/cve:votes/cve:revote">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:revote><xsl:value-of select="."/></terms:revote>
    </rdf:Description>
  </xsl:template>

  <!--comment-->
  <xsl:template match="/cve:cve/cve:item/cve:comments/cve:comment">
    <xsl:param name="cve-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CVE/<xsl:value-of select="$cve-id"/></xsl:attribute>
      <terms:voter><xsl:value-of select="@voter"/></terms:voter>
      <terms:comment><xsl:value-of select="."/></terms:comment>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
