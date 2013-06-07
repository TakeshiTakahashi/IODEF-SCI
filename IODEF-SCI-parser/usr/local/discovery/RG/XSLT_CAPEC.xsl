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
  	xmlns:observables="http://capec.mitre.org/observables"
  	xmlns:capec="http://capec.mitre.org/data/xsd/ap_schema_v2.1.xsd"
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

      <xsl:apply-templates select="/Attack_Pattern_Catalog/Attack_Patterns/Attack_Pattern"/>
      <xsl:apply-templates select="/Attack_Pattern_Catalog/Views/View"/>
      <xsl:apply-templates select="/Attack_Pattern_Catalog/Categories/Category"/>
      <xsl:apply-templates select="/Attack_Pattern_Catalog/Environments/Environment"/>

    </rdf:RDF>
  </xsl:template>

  <!-- Attack_Pattern -->
  <xsl:template match="Attack_Pattern">
    <xsl:variable name="capec-id" select="concat('ATTACK',@ID)" />
<!--
    <rdf:Description rdf:about="&ontology;CAPEC">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <capec:Attack_Pattern>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$URI"/>/<xsl:value-of select="$CATEGORY"/>/<xsl:value-of select="$capec-id"/></xsl:attribute>
      </capec:Attack_Pattern>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CAPEC" />
      <ontology:SecurityInformation>CAPEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$capec-id"/></ontology:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Pattern_Abstraction><xsl:value-of select="@Pattern_Abstraction"/></terms:Pattern_Abstraction>
      <terms:Pattern_Completeness><xsl:value-of select="@Pattern_Completeness"/></terms:Pattern_Completeness>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
    </rdf:Description>

    <xsl:apply-templates select="*"><xsl:with-param name="capec-id" select="$capec-id"/></xsl:apply-templates>

  </xsl:template>

  <!-- Summary -->
  <xsl:template match="Summary">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Summary><xsl:value-of select="Text"/></terms:Summary>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Phase -->
  <xsl:template match="Attack_Phase">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Phase-ID><xsl:value-of select="@ID"/></terms:Attack_Phase-ID>
      <terms:Attack_Phase-Name><xsl:value-of select="@Name"/></terms:Attack_Phase-Name>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Step -->
  <xsl:template match="Attack_Step">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Step-ID><xsl:value-of select="@ID"/></terms:Attack_Step-ID>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Step_Title -->
  <xsl:template match="Attack_Step_Title">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Step_Title><xsl:value-of select="."/></terms:Attack_Step_Title>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Step_Description -->
  <xsl:template match="Attack_Step_Description">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Step_Description><xsl:value-of select="Text"/></terms:Attack_Step_Description>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Step_Technique -->
  <xsl:template match="Attack_Step_Technique">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Step_Technique-ID><xsl:value-of select="@ID"/></terms:Attack_Step_Technique-ID>
      <terms:Attack_Step_Technique_Description><xsl:value-of select="Attack_Step_Technique_Description/Text"/></terms:Attack_Step_Technique_Description>
      <terms:Attack_Step_Technique-Environments><xsl:value-of select="Environments"/></terms:Attack_Step_Technique-Environments>
    </rdf:Description>
  </xsl:template>

  <!-- Indicator -->
  <xsl:template match="Indicator">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Indicator-ID><xsl:value-of select="@ID"/></terms:Indicator-ID>
      <terms:Indicator-type><xsl:value-of select="@type"/></terms:Indicator-type>
      <terms:Indicator_Description><xsl:value-of select="Indicator_Description/Text"/></terms:Indicator_Description>
      <terms:Indicator-Environments><xsl:value-of select="Environments"/></terms:Indicator-Environments>
    </rdf:Description>
  </xsl:template>

  <!-- Outcome -->
  <xsl:template match="Outcome">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Outcome-ID><xsl:value-of select="@ID"/></terms:Outcome-ID>
      <terms:Outcome-type><xsl:value-of select="@type"/></terms:Outcome-type>
      <terms:Outcome_Description><xsl:value-of select="Outcome_Description"/></terms:Outcome_Description>
    </rdf:Description>
  </xsl:template>





  <!-- View -->
  <xsl:template match="View">
    <xsl:variable name="capec-id" select="concat('VIEW',@ID)" />
<!--
    <rdf:Description rdf:about="&ontology;CAPEC">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <capec:View>
         <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      </capec:View>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CAPEC" />

      <ontology:SecurityInformation>CAPEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$capec-id"/></ontology:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
    </rdf:Description>

  </xsl:template>

  <!-- View_Structure -->
  <xsl:template match="View_Structure">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:View_Structure><xsl:value-of select="."/></terms:View_Structure>
    </rdf:Description>
  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Relationship_Views><xsl:value-of select="Relationship_Views/Relationship_View_ID"/></terms:Relationship_Views>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form"/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature"/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID"/></terms:Relationship_Target_ID>
    </rdf:Description>
  </xsl:template>





  <!-- Category -->
  <xsl:template match="Category">
    <xsl:variable name="capec-id" select="concat('CAT',@ID)" />
<!--
    <rdf:Description rdf:about="&ontology;CAPEC">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <capec:Category>
         <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      </capec:Category>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CAPEC" />

      <ontology:SecurityInformation>CAPEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$capec-id"/></ontology:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
    </rdf:Description>

  </xsl:template>

  <!-- Description_Summary -->
  <xsl:template match="Description_Summary">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Description_Summary><xsl:value-of select="."/></terms:Description_Summary>
    </rdf:Description>
  </xsl:template>

  <!-- Related_Weakness -->
  <xsl:template match="Related_Weakness">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:CWE_ID><xsl:value-of select="CWE_ID"/></terms:CWE_ID>
      <terms:Weakness_Relationship_Type><xsl:value-of select="Weakness_Relationship_Type"/></terms:Weakness_Relationship_Type>
    </rdf:Description>
  </xsl:template>

  <!-- Attack_Prerequisite -->
  <xsl:template match="Attack_Prerequisite">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Attack_Prerequisite><xsl:value-of select="Text"/></terms:Attack_Prerequisite>
    </rdf:Description>
  </xsl:template>

  <!-- Resources_Required -->
  <xsl:template match="Resources_Required">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Resources_Required><xsl:value-of select="Text"/></terms:Resources_Required>
    </rdf:Description>
  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Relationship_Views><xsl:value-of select="Relationship_Views/Relationship_View_ID"/></terms:Relationship_Views>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form"/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature"/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID"/></terms:Relationship_Target_ID>
    </rdf:Description>
  </xsl:template>





  <!-- Environment -->
  <xsl:template match="Environment">
    <xsl:variable name="capec-id" select="concat('E-',@ID)" />
<!--
    <rdf:Description rdf:about="&ontology;CAPEC">
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&ontology;SecurityInformation" />
      <rdfs:subClassOf rdf:resource="&ontology;Category" />
      <capec:Environment>
         <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      </capec:Environment>
    </rdf:Description>
-->
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CAPEC" />

      <ontology:SecurityInformation>CAPEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$capec-id"/></ontology:ID>
    </rdf:Description>

  </xsl:template>

  <!-- Environment_Title -->
  <xsl:template match="Environment_Title">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Environment_Title><xsl:value-of select="."/></terms:Environment_Title>
    </rdf:Description>
  </xsl:template>

  <!-- Environment_Description -->
  <xsl:template match="Environment_Description">
    <xsl:param name="capec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CAPEC/<xsl:value-of select="$capec-id"/></xsl:attribute>
      <terms:Environment_Description><xsl:value-of select="."/></terms:Environment_Description>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
