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
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"

    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"

    xmlns:meta="http://scap.nist.gov/schema/cpe-dictionary-metadata/0.2"
    xmlns:cpe="http://cpe.mitre.org/dictionary/2.0"
    xmlns:ns6="http://scap.nist.gov/schema/scap-core/0.1"
    xmlns:scap-core="http://scap.nist.gov/schema/scap-core/0.3"
    xmlns:config="http://scap.nist.gov/schema/configuration/0.1"

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

      <xsl:apply-templates select="/cpe:cpe-list/cpe:cpe-item"/>

    </rdf:RDF>
  </xsl:template>

  <!-- cpe-item -->
  <xsl:template match="cpe:cpe-item">
    <xsl:variable name="cpe-id-org" select="@name" />
    <xsl:variable name="cpe-id" select="translate($cpe-id-org,'/:','__')" />
<!--
    <rdf:Description rdf:about="&ontology;CPE">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <cpe:cpe-item>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/<xsl:value-of select="$CATEGORY"/>/<xsl:value-of select="$cpe-id"/></xsl:attribute>
      </cpe:cpe-item>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CPE/<xsl:value-of select="$cpe-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CPE" />
      <ontology:SecurityInformation>CPE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cpe-id-org"/></ontology:ID>
      <ontology:InformationSummary></ontology:InformationSummary>
    </rdf:Description>

    <xsl:apply-templates select="*"><xsl:with-param name="cpe-id" select="$cpe-id"/></xsl:apply-templates>

  </xsl:template>


  <!-- title -->
  <xsl:template match="cpe:title">
    <xsl:param name="cpe-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CPE/<xsl:value-of select="$cpe-id"/></xsl:attribute>
      <terms:title-lang><xsl:value-of select="@xml:lang"/></terms:title-lang>
      <terms:title><xsl:value-of select="."/></terms:title>
    </rdf:Description>
  </xsl:template>

  <!-- meta:item-metadata -->
  <xsl:template match="meta:item-metadata">
    <xsl:param name="cpe-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CPE/<xsl:value-of select="$cpe-id"/></xsl:attribute>
      <terms:item-metadata-modification-date><xsl:value-of select="@modification-date"/></terms:item-metadata-modification-date>
      <terms:item-metadata-status><xsl:value-of select="@status"/></terms:item-metadata-status>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
