<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:jvn="http://purl.org/rss/1.0/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
    xmlns:sec="http://jvn.jp/rss/mod_sec/"
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

      <xsl:apply-templates select="/rdf:RDF/jvn:item"/>

    </rdf:RDF>
  </xsl:template>

  <!--channel-->
  <xsl:template match="channel"></xsl:template>

  <!--item-->
  <xsl:template match="jvn:item">
<!--
    <xsl:variable name="head_len" select="string-length('http://jvn.jp/') + 1" />
    <xsl:variable name="rdfabout" select="@rdf:about" />
    <xsl:variable name="jvn_id_len" select="string-length($rdfabout)" />
    <xsl:variable name="jvn_id_len2" select="$jvn_id_len - $head_len" />
    <xsl:variable name="jvn_id_org" select="substring($rdfabout,$head_len,$jvn_id_len2)" />
    <xsl:variable name="jvn-id" select="substring-after($jvn_id_org,'/')" />
    
    <rdf:Description rdf:about="&ontology;JVN">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ontology:item>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/JVN/<xsl:value-of select="$jvn-id"/></xsl:attribute>
      </ontology:item>
    </rdf:Description>
-->
    <xsl:variable name="jvn-id-org" select="dc:identifier/." />
    <xsl:variable name="jvn-id" select="translate($jvn-id-org,'#','')" />

    <rdf:Description>
<!--
<xsl:attribute name="head_len"><xsl:value-of select="$head_len"/></xsl:attribute>
<xsl:attribute name="len"><xsl:value-of select="$jvn_id_len"/></xsl:attribute>
<xsl:attribute name="len2"><xsl:value-of select="$jvn_id_len2"/></xsl:attribute>
<xsl:attribute name="id1"><xsl:value-of select="$jvn_id_org"/></xsl:attribute>
<xsl:attribute name="id2"><xsl:value-of select="$jvn-id"/></xsl:attribute>
<xsl:attribute name="tagName"><xsl:value-of select="name()"/></xsl:attribute>
-->
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVN/<xsl:value-of select="$jvn-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;JVN" />

      <ontology:SecurityInformation>JVN</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$jvn-id-org"/></ontology:ID>
      <ontology:InformationSummary><xsl:value-of select="jvn:title/."/></ontology:InformationSummary>

      <terms:title><xsl:value-of select="jvn:title/."/></terms:title>
      <terms:link><xsl:value-of select="jvn:link/."/></terms:link>
      <terms:description><xsl:value-of select="jvn:description/."/></terms:description>
      <terms:publisher><xsl:value-of select="dc:publisher/."/></terms:publisher>
      <terms:creator><xsl:value-of select="dc:creator/."/></terms:creator>
      <terms:identifier><xsl:value-of select="dc:identifier/."/></terms:identifier>
      <terms:date><xsl:value-of select="dc:date/."/></terms:date>
      <terms:issued><xsl:value-of select="dcterms:issued/."/></terms:issued>
      <terms:modified><xsl:value-of select="dcterms:modified/."/></terms:modified>

      <terms:cvss-vector><xsl:value-of select="sec:cvss/@vector"/></terms:cvss-vector>
      <terms:cvss-score><xsl:value-of select="sec:cvss/@score"/></terms:cvss-score>
      <terms:cvss-severity><xsl:value-of select="sec:cvss/@severity"/></terms:cvss-severity>
      <terms:cvss-version><xsl:value-of select="sec:cvss/@version"/></terms:cvss-version>

      <xsl:apply-templates select="dc:relation"/>
      <xsl:apply-templates select="sec:references"/>
      <xsl:apply-templates select="sec:cpe-item"/>

    </rdf:Description>

  </xsl:template>

  <!--relation-->
  <xsl:template match="dc:relation">
    <terms:relation><xsl:value-of select="."/></terms:relation>
  </xsl:template>

  <!--references-->
  <xsl:template match="sec:references">
    <terms:references><xsl:value-of select="."/></terms:references>
  </xsl:template>

  <!--cpe-item-->
  <xsl:template match="sec:cpe-item">
    <terms:cpe-item-name><xsl:value-of select="@name"/></terms:cpe-item-name>
    <terms:cpe-item-vname><xsl:value-of select="sec:vname/."/></terms:cpe-item-vname>
    <terms:cpe-item-title><xsl:value-of select="sec:title/."/></terms:cpe-item-title>
  </xsl:template>

</xsl:stylesheet>
