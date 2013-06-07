<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:jvnipedia="http://purl.org/rss/1.0/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
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

      <xsl:apply-templates select="/rdf:RDF/jvnipedia:item"/>

    </rdf:RDF>
  </xsl:template>

  <!--channel-->
  <xsl:template match="channel"></xsl:template>

  <!--item-->
  <xsl:template match="jvnipedia:item">
    <xsl:variable name="jvnipedia-id" select="dc:identifier/." />
<!--
    <rdf:Description rdf:about="&ontology;JVNiPedia">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ontology:item>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      </ontology:item>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;JVNiPedia" />

      <ontology:SecurityInformation>JVNiPedia</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$jvnipedia-id"/></ontology:ID>
    </rdf:Description>

    <xsl:apply-templates select="*">
      <xsl:with-param name="jvnipedia-id" select="$jvnipedia-id"/>
    </xsl:apply-templates>

  </xsl:template>

  <!--title-->
  <xsl:template match="jvnipedia:title">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:title><xsl:value-of select="."/></terms:title>
      <ontology:InformationSummary><xsl:value-of select="."/></ontology:InformationSummary>
    </rdf:Description>
  </xsl:template>

  <!--link-->
  <xsl:template match="jvnipedia:link">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:link><xsl:value-of select="."/></terms:link>
    </rdf:Description>
  </xsl:template>

  <!--description-->
  <xsl:template match="jvnipedia:description">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:description><xsl:value-of select="."/></terms:description>
    </rdf:Description>
  </xsl:template>

  <!--publisher-->
  <xsl:template match="dc:publisher">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:publisher><xsl:value-of select="."/></terms:publisher>
    </rdf:Description>
  </xsl:template>

  <!--identifier-->
  <xsl:template match="dc:identifier">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:identifier><xsl:value-of select="."/></terms:identifier>
    </rdf:Description>
  </xsl:template>

  <!--relation-->
  <xsl:template match="dc:relation">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:relation><xsl:value-of select="."/></terms:relation>
    </rdf:Description>
  </xsl:template>

  <!--sec:identifier-->
  <xsl:template match="sec:identifier">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:sec-identifier><xsl:value-of select="."/></terms:sec-identifier>
    </rdf:Description>
  </xsl:template>

  <!--sec:references-->
  <xsl:template match="sec:references">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:sec-references-source><xsl:value-of select="@source"/></terms:sec-references-source>
      <terms:sec-references-id><xsl:value-of select="@id"/></terms:sec-references-id>
      <terms:sec-references><xsl:value-of select="."/></terms:sec-references>
    </rdf:Description>
  </xsl:template>

  <!--sec:cpe-item-->
  <xsl:template match="sec:cpe-item">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:sec-cpe-item-name><xsl:value-of select="@name"/></terms:sec-cpe-item-name>
      <terms:sec-cpe-item-vname><xsl:value-of select="sec:vname"/></terms:sec-cpe-item-vname>
      <terms:sec-cpe-item-title><xsl:value-of select="sec:title"/></terms:sec-cpe-item-title>
    </rdf:Description>
  </xsl:template>

  <!--sec:cvss-->
  <xsl:template match="sec:cvss">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:sec-cvss-version><xsl:value-of select="@version"/></terms:sec-cvss-version>
      <terms:sec-cvss-severity><xsl:value-of select="@severity"/></terms:sec-cvss-severity>
      <terms:sec-cvss-score><xsl:value-of select="@score"/></terms:sec-cvss-score>
      <terms:sec-cvss-vector><xsl:value-of select="@vector"/></terms:sec-cvss-vector>
    </rdf:Description>
  </xsl:template>

  <!--date-->
  <xsl:template match="dc:date">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:date><xsl:value-of select="."/></terms:date>
    </rdf:Description>
  </xsl:template>

  <!--dcterms:issued-->
  <xsl:template match="dcterms:issued">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:issued><xsl:value-of select="."/></terms:issued>
    </rdf:Description>
  </xsl:template>

  <!--dcterms:modified-->
  <xsl:template match="dcterms:modified">
    <xsl:param name="jvnipedia-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/JVNiPedia/<xsl:value-of select="$jvnipedia-id"/></xsl:attribute>
      <terms:modified><xsl:value-of select="."/></terms:modified>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
