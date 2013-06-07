<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:cee="http://cee.mitre.org"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
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

      <xsl:apply-templates select="/cee:Log/cee:CEE"/>

    </rdf:RDF>
  </xsl:template>

  <!--CEE-->
  <xsl:template match="cee:CEE">
    <xsl:variable name="cee-id" select="cee:Event/cee:id/." />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CEE/<xsl:value-of select="$cee-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CEE" />

      <ontology:SecurityInformation>CEE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cee-id"/></ontology:ID>

      <xsl:apply-templates select="*"><xsl:with-param name="cee-id" select="$cee-id"/></xsl:apply-templates>
    </rdf:Description>

  </xsl:template>

  <!-- Event -->
  <xsl:template match="cee:Event">
    <xsl:param name="cee-id" />
    <terms:id><xsl:value-of select="cee:id/."/></terms:id>
    <terms:time><xsl:value-of select="cee:time/."/></terms:time>
    <terms:action><xsl:value-of select="cee:action/."/></terms:action>
    <terms:status><xsl:value-of select="cee:status/."/></terms:status>
    <terms:p_sys_id><xsl:value-of select="cee:p_sys_id/."/></terms:p_sys_id>
    <terms:p_sys_id><xsl:value-of select="cee:p_sys_id/."/></terms:p_sys_id>

    <xsl:apply-templates select="*"><xsl:with-param name="cee-id" select="$cee-id"/></xsl:apply-templates>
  </xsl:template>

  <!-- Augmentation -->
  <xsl:template match="cee:Augmentation">
    <xsl:param name="cee-id" />
    <terms:Augmentation-order><xsl:value-of select="@order"/></terms:Augmentation-order>
    <terms:Augmentation-time><xsl:value-of select="cee:time"/></terms:Augmentation-time>
    <terms:Augmentation-status><xsl:value-of select="cee:status"/></terms:Augmentation-status>
    <terms:Augmentation-p_sys_id><xsl:value-of select="cee:p_sys_id"/></terms:Augmentation-p_sys_id>
    <terms:Augmentation-p_prod_id><xsl:value-of select="cee:p_prod_id"/></terms:Augmentation-p_prod_id>
    <terms:Augmentation-Field-name><xsl:value-of select="cee:Fiels/@name"/></terms:Augmentation-Field-name>
    <terms:Augmentation-Field-name-tag><xsl:value-of select="cee:tag"/></terms:Augmentation-Field-name-tag>

    <xsl:apply-templates select="*"><xsl:with-param name="cee-id" select="$cee-id"/></xsl:apply-templates>
  </xsl:template>

  <!-- Field -->
  <xsl:template match="cee:Field">
    <xsl:param name="cee-id" />
    <terms:Field-name><xsl:value-of select="@name"/></terms:Field-name>
    <terms:Field-tag><xsl:value-of select="cee:tag"/></terms:Field-tag>
    <terms:Field-str><xsl:value-of select="cee:str"/></terms:Field-str>
    <terms:Field-binary><xsl:value-of select="cee:binary"/></terms:Field-binary>
  </xsl:template>

</xsl:stylesheet>
