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
    xmlns:cce="http://cce.mitre.org"
>

  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:variable name="cce-id" />
  <xsl:param name="URI" />
  <xsl:param name="CATEGORY" />
  <xsl:param name="INFOSOURCE_NAME" />
  <xsl:param name="CREATE_DATE" />
  <xsl:param name="UPDATE_DATE" />
  <xsl:param name="AUTH_LEVEL" />
  <xsl:param name="HIT_COUNTER" />

  <!--root(cce)-->
  <xsl:template match="/">
    <rdf:RDF>

      <xsl:apply-templates select="/cce:cce_list/cce:cces/cce:cce"/>

    </rdf:RDF>
  </xsl:template>

  <!--cce-->
  <xsl:template match="cce:cce">
    <xsl:variable name="cce_id" select="@cce_id" />
<!--
    <rdf:Description rdf:about="&ontology;CCE">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <cce>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      </cce>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;cce" />
      <rdfs:subClassOf rdf:resource="&ontology;CCE" />
      <ontology:SecurityInformation>CCE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cce_id"/></ontology:ID>
      <terms:platform><xsl:value-of select="@platform"/></terms:platform>
      <terms:modified><xsl:value-of select="@modified"/></terms:modified>
    </rdf:Description>

    <xsl:apply-templates select="*">
      <xsl:with-param name="cce_id" select="$cce_id"/>
    </xsl:apply-templates>
    
  </xsl:template>

  <!--description -->
  <xsl:template match="/cce:cce_list/cce:cces/cce:cce/cce:description">
    <xsl:param name="cce_id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      <ontology:InformationSummary><xsl:value-of select="."/></ontology:InformationSummary>
      <terms:description><xsl:value-of select="."/></terms:description>
    </rdf:Description>
  </xsl:template>

  <!--parameter-->
  <xsl:template match="/cce:cce_list/cce:cces/cce:cce/cce:parameters/cce:parameter">
    <xsl:param name="cce_id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      <terms:parameter><xsl:value-of select="."/></terms:parameter>
    </rdf:Description>
  </xsl:template>

  <!--technical_mechanism-->
  <xsl:template match="/cce:cce_list/cce:cces/cce:cce/cce:technical_mechanisms/cce:technical_mechanism">
    <xsl:param name="cce_id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      <terms:technical_mechanism><xsl:value-of select="."/></terms:technical_mechanism>
    </rdf:Description>
  </xsl:template>

  <!--reference-->
  <xsl:template match="/cce:cce_list/cce:cces/cce:cce/cce:references/cce:reference">
    <xsl:param name="cce_id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CCE/<xsl:value-of select="$cce_id"/></xsl:attribute>
      <terms:resource_id><xsl:value-of select="@resource_id"/></terms:resource_id>
      <terms:reference><xsl:value-of select="."/></terms:reference>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
