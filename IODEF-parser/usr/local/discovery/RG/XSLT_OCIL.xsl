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
    xmlns:ocil="http://www.mitre.org/ocil/1.0"
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

      <xsl:apply-templates select="/ocil:ocil/ocil:questionnaire"/>
      <xsl:apply-templates select="/ocil:ocil/ocil:boolean_question_test_action"/>
      <xsl:apply-templates select="/ocil:ocil/ocil:boolean_question"/>

    </rdf:RDF>
  </xsl:template>

  <!-- questionnaire -->
  <xsl:template match="ocil:questionnaire">
    <xsl:variable name="ocil-id" select="@id" />
    <xsl:variable name="ocil-id-uri" select="translate($ocil-id,':','_')" />
<!--
    <rdf:Description rdf:about="&ontology;OCIL">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ocil:questionnaire>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/<xsl:value-of select="$CATEGORY"/>/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      </ocil:questionnaire>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;OCIL" />
      <ontology:SecurityInformation>OCIL</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$ocil-id"/></ontology:ID>
      <terms:priority><xsl:value-of select="@priority"/></terms:priority>
    </rdf:Description>

    <xsl:apply-templates select="*"><xsl:with-param name="ocil-id-uri" select="$ocil-id-uri"/></xsl:apply-templates>

  </xsl:template>

  <!-- title -->
  <xsl:template match="ocil:title">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:title><xsl:value-of select="."/></terms:title>
    </rdf:Description>
  </xsl:template>

  <!-- description -->
  <xsl:template match="ocil:description">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:description><xsl:value-of select="."/></terms:description>
    </rdf:Description>
  </xsl:template>

  <!-- actions -->
  <xsl:template match="ocil:actions">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:actions-priority><xsl:value-of select="@priority"/></terms:actions-priority>
      <terms:actions-operation><xsl:value-of select="@operation"/></terms:actions-operation>
      <terms:actions-test_action_ref-priority><xsl:value-of select="test_action_ref/@priority"/></terms:actions-test_action_ref-priority>
      <terms:actions-test_action_ref><xsl:value-of select="test_action_ref"/></terms:actions-test_action_ref>
      <terms:actions-priority><xsl:value-of select="@priority"/></terms:actions-priority>
    </rdf:Description>
  </xsl:template>





  <!-- boolean_question_test_action -->
  <xsl:template match="ocil:boolean_question_test_action">
    <xsl:variable name="ocil-id" select="@id" />
    <xsl:variable name="ocil-id-uri" select="translate($ocil-id,':','_')" />
<!--
    <rdf:Description rdf:about="&ontology;OCIL">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ocil:boolean_question_test_action>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      </ocil:boolean_question_test_action>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;OCIL" />

      <ontology:SecurityInformation>OCIL</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$ocil-id"/></ontology:ID>
      <terms:question_ref><xsl:value-of select="@question_ref"/></terms:question_ref>
    </rdf:Description>

    <xsl:apply-templates select="*"><xsl:with-param name="ocil-id-uri" select="$ocil-id-uri"/></xsl:apply-templates>

  </xsl:template>

  <!-- when_true -->
  <xsl:template match="ocil:when_true">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:when_true-result><xsl:value-of select="result"/></terms:when_true-result>
    </rdf:Description>
  </xsl:template>

  <!-- when_false -->
  <xsl:template match="ocil:when_false">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:when_false-result><xsl:value-of select="result"/></terms:when_false-result>
    </rdf:Description>
  </xsl:template>





  <!-- boolean_question -->
  <xsl:template match="ocil:boolean_question">
    <xsl:variable name="ocil-id" select="@id" />
    <xsl:variable name="ocil-id-uri" select="translate($ocil-id,':','_')" />
<!--
    <rdf:Description rdf:about="&ontology;OCIL">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <ocil:boolean_question>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      </ocil:boolean_question>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;OCIL" />

      <ontology:SecurityInformation>OCIL</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$ocil-id"/></ontology:ID>
      <terms:model><xsl:value-of select="@model"/></terms:model>
    </rdf:Description>

    <xsl:apply-templates select="*"><xsl:with-param name="ocil-id-uri" select="$ocil-id-uri"/></xsl:apply-templates>

  </xsl:template>

  <!-- question_text -->
  <xsl:template match="ocil:question_text">
    <xsl:param name="ocil-id-uri"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/OCIL/<xsl:value-of select="$ocil-id-uri"/></xsl:attribute>
      <terms:question_text><xsl:value-of select="."/></terms:question_text>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
