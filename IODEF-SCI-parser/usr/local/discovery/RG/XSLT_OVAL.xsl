<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:oval="http://oval.mitre.org/XMLSchema/oval-definitions-5" 
    xmlns:oval-cmn="http://oval.mitre.org/XMLSchema/oval-common-5" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:ind-def ="http://oval.mitre.org/XMLSchema/oval-definitions-5#independent" 
    xmlns:linux-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#linux" 
    xmlns:unix-def="http://oval.mitre.org/XMLSchema/oval-definitions-5#unix" 
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

      <xsl:apply-templates select="//oval:definition"/>
      <xsl:apply-templates select="//oval:tests/oval:textfilecontent_test"/>
<!--
      <xsl:apply-templates select="/oval:oval_definitions/oval:objects/*"/>
      <xsl:apply-templates select="/oval:oval_definitions/oval:states/*"/>
      <xsl:apply-templates select="/oval:oval_definitions/oval:variables/*"/>
-->
    </rdf:RDF>
  </xsl:template>

  <!--definitions-->
  <xsl:template match="oval:definition">
    <xsl:variable name="oval-id" select="@id" />
    <xsl:variable name="oval-id-uri" select="translate($oval-id,':','_')" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OVAL/<xsl:value-of select="$oval-id-uri"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;OVAL" />

      <ontology:SecurityInformation>OVAL</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$oval-id"/></ontology:ID>

      <terms:class><xsl:value-of select="@class"/></terms:class>
      <terms:id><xsl:value-of select="@id"/></terms:id>
      <terms:version><xsl:value-of select="@version"/></terms:version>

      <xsl:apply-templates select="oval:metadata"/>
      <xsl:apply-templates select="oval:criteria"/>
      <xsl:apply-templates select="oval:reference"/>
    </rdf:Description>
  </xsl:template>

  <!-- metadata -->
  <xsl:template match="oval:metadata">
      <terms:title><xsl:value-of select="oval:title/."/></terms:title>
      <terms:description><xsl:value-of select="oval:description/."/></terms:description>
      <terms:debian-date><xsl:value-of select="oval:debian/oval:date/."/></terms:debian-date>
      <terms:debian-moreinfo><xsl:value-of select="oval:debian/oval:moreinfo/."/></terms:debian-moreinfo>
      <terms:affected-family><xsl:value-of select="oval:affected/@family"/></terms:affected-family>
      <xsl:apply-templates select="oval:affected/oval:platform"/>
      <xsl:apply-templates select="oval:affected/oval:product"/>
      <xsl:apply-templates select="oval:oval_repository/oval:dates"/>
      <xsl:apply-templates select="oval:reference"/>
      <terms:status><xsl:value-of select="oval:oval_repository/oval:status/."/></terms:status>
  </xsl:template>

  <xsl:template match="oval:platform">
      <terms:affected-platform><xsl:value-of select="."/></terms:affected-platform>
  </xsl:template>
  <xsl:template match="oval:product">
      <terms:affected-product><xsl:value-of select="."/></terms:affected-product>
  </xsl:template>

  <!-- reference -->
  <xsl:template match="oval:reference">
      <terms:reference-source><xsl:value-of select="@source"/></terms:reference-source>
      <terms:reference-ref_id><xsl:value-of select="@ref_id"/></terms:reference-ref_id>
      <terms:reference-ref_url><xsl:value-of select="@ref_url"/></terms:reference-ref_url>
  </xsl:template>

  <!-- criteria -->
  <xsl:template match="oval:criteria">
      <terms:criteria-comment><xsl:value-of select="@comment"/></terms:criteria-comment>
      <terms:criteria-operator><xsl:value-of select="@operator"/></terms:criteria-operator>
      <terms:extend_definition-comment><xsl:value-of select="oval:extend_definition/@comment"/></terms:extend_definition-comment>
      <terms:extend_definition-definition_ref><xsl:value-of select="oval:extend_definition/@definition_ref"/></terms:extend_definition-definition_ref>
      <xsl:apply-templates select="*"/>
  </xsl:template>

  <!-- criterion -->
  <xsl:template match="oval:criterion">
      <terms:criterion-comment><xsl:value-of select="@comment"/></terms:criterion-comment>
      <terms:criterion-operator><xsl:value-of select="@operator"/></terms:criterion-operator>
      <terms:criterion-test_ref><xsl:value-of select="@test_ref"/></terms:criterion-test_ref>
  </xsl:template>

  <!-- dates -->
  <xsl:template match="oval:dates">
      <terms:submitted-date><xsl:value-of select="oval:submitted/@date"/></terms:submitted-date>
      <terms:submitted-contributor-organization><xsl:value-of select="oval:submitted/oval:contributor/@organization"/></terms:submitted-contributor-organization>
      <terms:submitted-contributor><xsl:value-of select="oval:submitted/oval:contributor/."/></terms:submitted-contributor>
      <xsl:apply-templates select="oval:status_change"/>
  </xsl:template>

  <!-- status_change -->
  <xsl:template match="oval:states_change">
      <terms:states_change-date><xsl:value-of select="@date"/></terms:states_change-date>
      <terms:states_change><xsl:value-of select="."/></terms:states_change>
  </xsl:template>


  <!-- tests -->
  <xsl:template match="oval:textfilecontent_test">
    <xsl:variable name="oval-id" select="@id" />
    <xsl:variable name="oval-id-uri" select="translate($oval-id,':','_')" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OVAL/<xsl:value-of select="$oval-id-uri"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;OVAL" />

      <ontology:SecurityInformation>OVAL</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$oval-id"/></ontology:ID>
      
      <terms:test-id><xsl:value-of select="@id"/></terms:test-id>
      <terms:test-version><xsl:value-of select="@version"/></terms:test-version>
      <terms:test-comment><xsl:value-of select="@comment"/></terms:test-comment>
      <terms:test-check_existence><xsl:value-of select="@check_existence"/></terms:test-check_existence>
      <terms:test-check><xsl:value-of select="@check"/></terms:test-check>

      <terms:test-type><xsl:value-of select="name()"/></terms:test-type>
      <terms:object_ref><xsl:value-of select="//*/@object_ref"/></terms:object_ref>
      <terms:state_ref><xsl:value-of select="//*/@state_ref"/></terms:state_ref>
    </rdf:Description>

  </xsl:template>

</xsl:stylesheet>
