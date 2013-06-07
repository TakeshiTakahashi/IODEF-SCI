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
    xmlns:cdf="http://checklists.nist.gov/xccdf/1.0"
    xmlns:cdfp="http://www.cisecurity.org/xccdf/platform/0.2.3"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:htm="http://www.w3.org/1999/xhtml"
    xmlns:dsig="http://www.w3.org/2000/09/xmldsig#"
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

      <xsl:apply-templates select="/cdf:Benchmark"/>

    </rdf:RDF>
  </xsl:template>

  <!-- cdf:Benchmark -->
  <xsl:template match="cdf:Benchmark">
    <xsl:variable name="xccdf-id" select="@id" />
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;XCCDF" />

      <ontology:SecurityInformation>XCCDF</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$xccdf-id"/></ontology:ID>

      <terms:status-date><xsl:value-of select="cdf:status/@date"/></terms:status-date>
      <terms:status><xsl:value-of select="cdf:status/."/></terms:status>
      <terms:title><xsl:value-of select="cdf:title/."/></terms:title>
      <terms:description><xsl:value-of select="cdf:description/."/></terms:description>
      <terms:notice><xsl:value-of select="cdf:notice/."/></terms:notice>
      <terms:notice-id><xsl:value-of select="cdf:notice/@id"/></terms:notice-id>
      <terms:front-matter><xsl:value-of select="cdf:front-matter//."/></terms:front-matter>

      <xsl:apply-templates select="cdf:reference">
          <xsl:with-param name="xccdf-id" select="$xccdf-id"/>
      </xsl:apply-templates>

      <xsl:apply-templates select="//cdf:Group">
          <xsl:with-param name="xccdf-id" select="$xccdf-id"/>
      </xsl:apply-templates>

      <xsl:apply-templates select="cdfp:platform-definitions/*">
          <xsl:with-param name="xccdf-id" select="$xccdf-id"/>
      </xsl:apply-templates>

    </rdf:Description>
  </xsl:template>

  <!-- cdf:reference -->
  <xsl:template match="cdf:reference">
      <terms:reference><xsl:value-of select="."/></terms:reference>
      <terms:reference-href><xsl:value-of select="@href"/></terms:reference-href>
      <terms:reference-identifier><xsl:value-of select="dc:identifier/."/></terms:reference-identifier>
      <terms:reference-creator><xsl:value-of select="dc:creator/."/></terms:reference-creator>
      <terms:reference-title><xsl:value-of select="dc/title/."/></terms:reference-title>
  </xsl:template>

  <!-- cdfp:os -->
  <xsl:template match="cdfp:os">
      <terms:os-title><xsl:value-of select="cdfp:title/."/></terms:os-title>
      <terms:os-remark><xsl:value-of select="cdfp:remark/."/></terms:os-remark>
      <terms:os-vendortitle><xsl:value-of select="cdfp:vendor/."/></terms:os-vendortitle>
      <terms:os-family><xsl:value-of select="cdfp:family/."/></terms:os-family>
      <terms:os-level><xsl:value-of select="cdfp:level/."/></terms:os-level>
      <terms:os-version-range_min-inclusive><xsl:value-of select="cdfp:version-range/."/></terms:os-version-range_min-inclusive>
      <terms:os-version-range_max-inclusive><xsl:value-of select="cdfp:version-range/."/></terms:os-version-range_max-inclusive>
      <terms:os-id><xsl:value-of select="@id"/></terms:os-id>
  </xsl:template>

  <!-- cdf:Group -->
  <xsl:template match="cdf:Group">
    <xsl:param name="xccdf-id" />
    <xsl:variable name="group-id" select="@id" />
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <terms:selected><xsl:value-of select="@selected"/></terms:selected>
      <terms:prohibitChanges><xsl:value-of select="@prohibitChanges"/></terms:prohibitChanges>
      <terms:weight><xsl:value-of select="@weight"/></terms:weight>
    </rdf:Description>

  </xsl:template>

  <!-- cdf:title -->
  <xsl:template match="cdf:title">
    <xsl:param name="xccdf-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <terms:title><xsl:value-of select="."/></terms:title>
    </rdf:Description>
  </xsl:template>

  <!-- cdf:description -->
  <xsl:template match="cdf:description">
    <xsl:param name="xccdf-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <terms:description><xsl:value-of select="."/></terms:description>
    </rdf:Description>
  </xsl:template>

  <!-- cdf:requires -->
  <xsl:template match="cdf:requires">
    <xsl:param name="xccdf-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <terms:requires-idref><xsl:value-of select="@idref"/></terms:requires-idref>
    </rdf:Description>
  </xsl:template>

  <!-- cdf:Rule -->
  <xsl:template match="cdf:Rule">
    <xsl:param name="xccdf-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/XCCDF/<xsl:value-of select="$xccdf-id"/></xsl:attribute>
      <terms:Rule-id><xsl:value-of select="@id"/></terms:Rule-id>
      <terms:Rule-selected><xsl:value-of select="@selected"/></terms:Rule-selected>
      <terms:Rule-weight><xsl:value-of select="@weight"/></terms:Rule-weight>
      <terms:Rule-prohibitChanges><xsl:value-of select="@prohibitChanges"/></terms:Rule-prohibitChanges>
      <terms:Rule-hidden><xsl:value-of select="@hidden"/></terms:Rule-hidden>
      <terms:Rule-abstract><xsl:value-of select="@abstract"/></terms:Rule-abstract>
      <terms:Rule-cluster-id><xsl:value-of select="@cluster-id"/></terms:Rule-cluster-id>
      <terms:Rule-title><xsl:value-of select="cdf:title"/></terms:Rule-title>
      <terms:Rule-description><xsl:value-of select="cdf:description"/></terms:Rule-description>
      <terms:Rule-question><xsl:value-of select="cdf:question"/></terms:Rule-question>
      <terms:Rule-check-system><xsl:value-of select="cdf:check/@system"/></terms:Rule-check-system>
      <terms:Rule-check-content-ref-href><xsl:value-of select="cdf:check/cdf:check-content-ref/@href"/></terms:Rule-check-content-ref-href>
      <terms:Rule-check-content-ref-name><xsl:value-of select="cdf:check/cdf:check-content-ref/@name"/></terms:Rule-check-content-ref-name>
      <terms:Rule-check-export-value-id><xsl:value-of select="cdf:check/cdf:check-export/@value-id"/></terms:Rule-check-export-value-id>
      <terms:Rule-check-export-name><xsl:value-of select="cdf:check/cdf:check-export/@export-name"/></terms:Rule-check-export-name>
      <terms:Rule-check-content-ref-href><xsl:value-of select="cdf:check/cdf:check-content-ref/@href"/></terms:Rule-check-content-ref-href>
      <terms:Rule-check-content-ref-name><xsl:value-of select="cdf:check/cdf:check-content-ref/@name"/></terms:Rule-check-content-ref-name>
      <terms:Rule-fix><xsl:value-of select="cdf:fix"/></terms:Rule-fix>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
