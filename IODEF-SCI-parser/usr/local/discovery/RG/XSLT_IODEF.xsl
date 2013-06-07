<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:iodef="urn:ietf:params:xml:ns:iodef-1.0"
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
  
  <!-- Serial Number. -->
  <xsl:param name="SERIAL_NUM" />

  <!--root(rdf:RDF)-->
  <xsl:template match="/">
    <rdf:RDF>

      <xsl:apply-templates select="/iodef:IODEF-Document/iodef:Incident"/>

    </rdf:RDF>
  </xsl:template>

  <!--Incident-->
  <xsl:template match="iodef:Incident">
    <xsl:variable name="iodef-id-name" select="iodef:IncidentID/@name" />
    <xsl:variable name="iodef-id" select="iodef:IncidentID/." />
    <xsl:variable name="id" select="$SERIAL_NUM" />
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/IODEF/<xsl:value-of select="$id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;IODEF" />

      <ontology:SecurityInformation>IODEF</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$id"/></ontology:ID>

      <terms:IncidentID-name><xsl:value-of select="$iodef-id-name"/></terms:IncidentID-name>
      <terms:IncidentID><xsl:value-of select="$iodef-id"/></terms:IncidentID>
      <terms:ReportTime><xsl:value-of select="iodef:ReportTime/."/></terms:ReportTime>
      <terms:Description><xsl:value-of select="iodef:Description/."/></terms:Description>
      <terms:Assessment-Impact-completion><xsl:value-of select="iodef:Impact/@completion"/></terms:Assessment-Impact-completion>
      <terms:Assessment-Impact-type><xsl:value-of select="iodef:Impact/@type"/></terms:Assessment-Impact-type>

      <xsl:apply-templates select="iodef:Contact"/>
      <xsl:apply-templates select="iodef:System"/>

      <terms:Expectation-action><xsl:value-of select="iodef:Expectation/@action"/></terms:Expectation-action>
      <terms:Expectation><xsl:value-of select="iodef:Expectation/."/></terms:Expectation>

      <xsl:apply-templates select="iodef:HistoryItem"/>
      <xsl:apply-templates select="iodef:RecordData"/>

    </rdf:Description>

  </xsl:template>

  <!-- Contact -->
  <xsl:template match="iodef:Contact">
    <terms:Contact-role><xsl:value-of select="@role"/></terms:Contact-role>
    <terms:Contact-type><xsl:value-of select="@type"/></terms:Contact-type>
    <terms:ContactName><xsl:value-of select="iodef:ContactName/."/></terms:ContactName>
    <terms:RegistryHandle-registry><xsl:value-of select="iodef:RegistryHandle/@registry"/></terms:RegistryHandle-registry>
    <terms:RegistryHandle><xsl:value-of select="iodef:RegistryHandle/."/></terms:RegistryHandle>
    <terms:Email><xsl:value-of select="iodef:Email/."/></terms:Email>
    <xsl:apply-templates select="iodef:Contact"/>
  </xsl:template>

  <!-- System -->
  <xsl:template match="iodef:System">
    <terms:System-category><xsl:value-of select="@category"/></terms:System-category>
    <terms:Address-category><xsl:value-of select="Address/@category"/></terms:Address-category>
    <terms:Address><xsl:value-of select="Address"/></terms:Address>
    <terms:Counter-type><xsl:value-of select="Counter/@type"/></terms:Counter-type>
    <terms:Counter><xsl:value-of select="Counter"/></terms:Counter>
    <terms:Service-ip_protocol><xsl:value-of select="Service/@ip_protocol"/></terms:Service-ip_protocol>
    <terms:Service><xsl:value-of select="Service/Port"/></terms:Service>
  </xsl:template>

  <!-- RecordData -->
  <xsl:template match="iodef:RecordData">
    <terms:DateTime><xsl:value-of select="iodef:DateTime/."/></terms:DateTime>
    <terms:Description><xsl:value-of select="iodef:Description/."/></terms:Description>
    <terms:RecordItem-dtype><xsl:value-of select="iodef:RecordItem/@dtype"/></terms:RecordItem-dtype>
    <terms:RecordItem><xsl:value-of select="iodef:RecordItem/."/></terms:RecordItem>
  </xsl:template>

  <!-- HistoryItem -->
  <xsl:template match="iodef:HistoryItem">
    <terms:HistoryItem-action><xsl:value-of select="@action"/></terms:HistoryItem-action>
    <terms:DateTime><xsl:value-of select="iodef:DateTime/."/></terms:DateTime>
    <terms:Description><xsl:value-of select="iodef:Description/."/></terms:Description>
  </xsl:template>

</xsl:stylesheet>
