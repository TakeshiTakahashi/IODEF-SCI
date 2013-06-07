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
    xmlns:cwe="http://cwe.mitre.org/data/xsd/cwe_schema_v5.1.xsd"
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
      <xsl:apply-templates select="//Weakness"/>
      <xsl:apply-templates select="//View"/>
      <xsl:apply-templates select="//Category"/>
      <xsl:apply-templates select="//Compound_Element"/>
    </rdf:RDF>
  </xsl:template>

  <!--Weakness-->
  <xsl:template match="Weakness">
    <xsl:variable name="cwe-id" select="@ID" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CWE/<xsl:value-of select="$cwe-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CWE" />
      <ontology:SecurityInformation>CWE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cwe-id"/></ontology:ID>

      <terms:ID><xsl:value-of select="@ID"/></terms:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Weakness_Abstraction><xsl:value-of select="@Weakness_Abstraction"/></terms:Weakness_Abstraction>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>

      <xsl:apply-templates select="*"/>
    </rdf:Description>

  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
      <terms:Relationship_View_ID-Ordinal><xsl:value-of select="Relationship_View_ID/@Ordinal"/></terms:Relationship_View_ID-Ordinal>
      <terms:Relationship_View_ID><xsl:value-of select="Relationship_View_ID/."/></terms:Relationship_View_ID>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form/."/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature/."/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID/."/></terms:Relationship_Target_ID>
  </xsl:template>

  <!-- Relationship_Note -->
  <xsl:template match="Relationship_Note">
      <terms:Relationship_Note><xsl:value-of select="Text/."/></terms:Relationship_Note>
  </xsl:template>

  <!-- Weakness_Ordinality -->
  <xsl:template match="Weakness_Ordinality">
      <terms:Weakness_Ordinality><xsl:value-of select="Ordinality/."/></terms:Weakness_Ordinality>
  </xsl:template>

  <!-- Applicable_Platform -->
  <xsl:template match="Applicable_Platform">
      <terms:Applicable_Platform-Language_Name><xsl:value-of select="Languages/Language/@Language_Name"/></terms:Applicable_Platform-Language_Name>
  </xsl:template>

  <!-- Maintenance_Note -->
  <xsl:template match="Maintenance_Note">
      <terms:Maintenance_Note><xsl:value-of select="Text"/></terms:Maintenance_Note>
  </xsl:template>

  <!-- Background_Detail -->
  <xsl:template match="Background_Detail">
      <terms:Background_Detail><xsl:value-of select="Text"/></terms:Background_Detail>
  </xsl:template>

  <!-- Time_of_Introduction -->
  <xsl:template match="Time_of_Introduction">
      <terms:Time_of_Introduction><xsl:value-of select="Introductory_Phase"/></terms:Time_of_Introduction>
  </xsl:template>

  <!-- Common_Consequence -->
  <xsl:template match="Common_Consequence">
      <terms:Consequence_Scope><xsl:value-of select="Consequence_Scope"/></terms:Consequence_Scope>
      <terms:Consequence_Technical_Impact><xsl:value-of select="Consequence_Technical_Impact"/></terms:Consequence_Technical_Impact>
      <terms:Consequence_Note><xsl:value-of select="Consequence_Note/Text"/></terms:Consequence_Note>
  </xsl:template>

  <!-- Mitigation_Description -->
  <xsl:template match="Mitigation_Description">
      <terms:Mitigation_Description><xsl:value-of select="Text"/></terms:Mitigation_Description>
  </xsl:template>

  <!-- Causal_Nature -->
  <xsl:template match="Causal_Nature">
      <terms:Causal_Nature><xsl:value-of select="."/></terms:Causal_Nature>
  </xsl:template>

  <!-- Demonstrative_Example -->
  <xsl:template match="Demonstrative_Example">
      <terms:Intro_Text><xsl:value-of select="Intro_Text"/></terms:Intro_Text>
  </xsl:template>

  <!-- Block -->
  <xsl:template match="Block">
      <terms:Block-Block_Nature><xsl:value-of select="Block/@Block_Nature"/></terms:Block-Block_Nature>
      <terms:Block-Code_Example_Language><xsl:value-of select="Block/Code_Example_Language"/></terms:Block-Code_Example_Language>
      <terms:Block-Code><xsl:value-of select="Block/@Block_Nature"/></terms:Block-Code>
      <terms:Block-Text><xsl:value-of select="Text"/></terms:Block-Text>
  </xsl:template>

  <!-- Taxonomy_Mappings -->
  <xsl:template match="Taxonomy_Mappings">
      <terms:Taxonomy_Mapping-Mapped_Taxonomy_Name><xsl:value-of select="Taxonomy_Mapping/@Mapped_Taxonomy_Name"/></terms:Taxonomy_Mapping-Mapped_Taxonomy_Name>
      <terms:Mapped_Node_Name><xsl:value-of select="Mapped_Node_Name"/></terms:Mapped_Node_Name>
  </xsl:template>

  <!-- Submission -->
  <xsl:template match="Submission">
      <terms:Submission-Submission_Source><xsl:value-of select="@Submission_Source"/></terms:Submission-Submission_Source>
      <terms:Submission><xsl:value-of select="."/></terms:Submission>
  </xsl:template>

  <!-- Modification -->
  <xsl:template match="Modification">
      <terms:Modification_Source><xsl:value-of select="@Modification_Source"/></terms:Modification_Source>
      <terms:Modifier><xsl:value-of select="Modifier"/></terms:Modifier>
      <terms:Modifier_Organization><xsl:value-of select="Modifier_Organization"/></terms:Modifier_Organization>
      <terms:Modification_Date><xsl:value-of select="Modification_Date"/></terms:Modification_Date>
      <terms:Modification_Comment><xsl:value-of select="Modifier"/></terms:Modification_Comment>
  </xsl:template>





  <!--View-->
  <xsl:template match="View">
    <xsl:variable name="cwe-id" select="@ID" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CWE/<xsl:value-of select="$cwe-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CWE" />

      <ontology:SecurityInformation>CWE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cwe-id"/></ontology:ID>
      <terms:ID><xsl:value-of select="@ID"/></terms:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
      <xsl:apply-templates select="*"/>
    </rdf:Description>

  </xsl:template>

  <!-- View_Structure -->
  <xsl:template match="View_Structure">
      <terms:View_Structure><xsl:value-of select="."/></terms:View_Structure>
  </xsl:template>

  <!-- View_Objective -->
  <xsl:template match="View_Objective">
      <terms:View_Objective><xsl:value-of select="Text"/></terms:View_Objective>
  </xsl:template>

  <!-- View_Audience -->
  <xsl:template match="Audience">
      <terms:Audience-Stakeholder><xsl:value-of select="Stakeholder"/></terms:Audience-Stakeholder>
      <terms:Audience-Stakeholder_Description><xsl:value-of select="Stakeholder_Description/Text"/></terms:Audience-Stakeholder_Description>
  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
      <terms:Relationship_View_ID-Ordinal><xsl:value-of select="@Ordinal"/></terms:Relationship_View_ID-Ordinal>
      <terms:Relationship_View_ID><xsl:value-of select="Relationship_View_ID"/></terms:Relationship_View_ID>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form"/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature"/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID"/></terms:Relationship_Target_ID>
  </xsl:template>

  <!-- Modification -->
  <xsl:template match="Modification">
      <terms:Modification_Source><xsl:value-of select="@Modification_Source"/></terms:Modification_Source>
      <terms:Modifier><xsl:value-of select="Modifier"/></terms:Modifier>
      <terms:Modifier_Organization><xsl:value-of select="Modifier_Organization"/></terms:Modifier_Organization>
      <terms:Modification_Date><xsl:value-of select="Modification_Date"/></terms:Modification_Date>
      <terms:Modification_Comment><xsl:value-of select="Modification_Comment"/></terms:Modification_Comment>
  </xsl:template>





  <!--Category-->
  <xsl:template match="Category">
    <xsl:variable name="cwe-id" select="@ID" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CWE/<xsl:value-of select="$cwe-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CWE" />

      <ontology:SecurityInformation>CWE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cwe-id"/></ontology:ID>
      <terms:ID><xsl:value-of select="@ID"/></terms:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
      <xsl:apply-templates select="*"/>
    </rdf:Description>

  </xsl:template>

  <!-- Description_Summary -->
  <xsl:template match="Description">
      <ontology:InformationSummary><xsl:value-of select="Description_Summary/."/></ontology:InformationSummary>
      <terms:Description_Summary><xsl:value-of select="Description_Summary/."/></terms:Description_Summary>
      <terms:Extended_Description><xsl:value-of select="Extended_Description/Text/."/></terms:Extended_Description>
  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
      <terms:Relationship_View_ID-Ordinal><xsl:value-of select="@Ordinal"/></terms:Relationship_View_ID-Ordinal>
      <terms:Relationship_View_ID><xsl:value-of select="Relationship_View_ID"/></terms:Relationship_View_ID>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form"/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature"/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID"/></terms:Relationship_Target_ID>
  </xsl:template>

  <!-- Time_of_Introduction -->
  <xsl:template match="Time_of_Introduction">
      <terms:Time_of_Introduction><xsl:value-of select="Introductory_Phase"/></terms:Time_of_Introduction>
  </xsl:template>

  <!-- Taxonomy_Mappings -->
  <xsl:template match="Taxonomy_Mappings">
      <terms:Taxonomy_Mapping-Mapped_Taxonomy_Name><xsl:value-of select="Block/@Block_Nature"/></terms:Taxonomy_Mapping-Mapped_Taxonomy_Name>
      <terms:Mapped_Node_Name><xsl:value-of select="."/></terms:Mapped_Node_Name>
  </xsl:template>

  <!-- Related_Attack_Patterns -->
  <xsl:template match="Related_Attack_Patterns">
      <terms:Related_Attack_Pattern-CAPEC_Version><xsl:value-of select="Related_Attack_Pattern/@CAPEC_Version"/></terms:Related_Attack_Pattern-CAPEC_Version>
      <terms:Related_Attack_Pattern-CAPEC_ID><xsl:value-of select="Related_Attack_Pattern/CAPEC_ID"/></terms:Related_Attack_Pattern-CAPEC_ID>
  </xsl:template>

  <!-- Submission -->
  <xsl:template match="Submission">
      <terms:Submission_Source><xsl:value-of select="@Submission_Source"/></terms:Submission_Source>
      <terms:Submission><xsl:value-of select="Submitter"/></terms:Submission>
  </xsl:template>

  <!-- Modification -->
  <xsl:template match="Modification">
      <terms:Modification_Source><xsl:value-of select="@Modification_Source"/></terms:Modification_Source>
      <terms:Modifier><xsl:value-of select="Modifier"/></terms:Modifier>
      <terms:Modifier_Organization><xsl:value-of select="Modifier_Organization"/></terms:Modifier_Organization>
      <terms:Modification_Date><xsl:value-of select="Modification_Date"/></terms:Modification_Date>
      <terms:Modification_Comment><xsl:value-of select="Modification_Comment"/></terms:Modification_Comment>
  </xsl:template>





  <!--Compound_Element-->
  <xsl:template match="Compound_Element">
    <xsl:variable name="cwe-id" select="@ID" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/CWE/<xsl:value-of select="$cwe-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;CWE" />

      <ontology:SecurityInformation>CWE</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$cwe-id"/></ontology:ID>
      <terms:ID><xsl:value-of select="@ID"/></terms:ID>
      <terms:Name><xsl:value-of select="@Name"/></terms:Name>
      <terms:Compound_Element_Abstraction><xsl:value-of select="@Compound_Element_Abstraction"/></terms:Compound_Element_Abstraction>
      <terms:Compound_Element_Structure><xsl:value-of select="@Compound_Element_Structure"/></terms:Compound_Element_Structure>
      <terms:Status><xsl:value-of select="@Status"/></terms:Status>
      <xsl:apply-templates select="*"/>
    </rdf:Description>

  </xsl:template>

  <!-- Relationship -->
  <xsl:template match="Relationship">
      <terms:Relationship_View_ID-Ordinal><xsl:value-of select="Relationship_Views/Relationship_View_ID/@Ordinal"/></terms:Relationship_View_ID-Ordinal>
      <terms:Relationship_View_ID><xsl:value-of select="Relationship_Views/Relationship_View_ID/."/></terms:Relationship_View_ID>
      <terms:Relationship_Target_Form><xsl:value-of select="Relationship_Target_Form/."/></terms:Relationship_Target_Form>
      <terms:Relationship_Nature><xsl:value-of select="Relationship_Nature/."/></terms:Relationship_Nature>
      <terms:Relationship_Target_ID><xsl:value-of select="Relationship_Target_ID/."/></terms:Relationship_Target_ID>
  </xsl:template>

  <!-- Weakness_Ordinality -->
  <xsl:template match="Weakness_Ordinality">
      <terms:Weakness_Ordinality><xsl:value-of select="Ordinality/."/></terms:Weakness_Ordinality>
  </xsl:template>

  <!-- Applicable_Platforms -->
  <xsl:template match="Applicable_Platforms">
      <terms:Applicable_Platforms-Language_Name><xsl:value-of select="Languages/Language/@Language_Name"/></terms:Applicable_Platforms-Language_Name>
  </xsl:template>

  <!-- Time_of_Introduction -->
  <xsl:template match="Time_of_Introduction">
      <terms:Time_of_Introduction><xsl:value-of select="Introductory_Phase/."/></terms:Time_of_Introduction>
  </xsl:template>

  <!-- Likelihood_of_Exploit -->
  <xsl:template match="Likelihood_of_Exploit">
      <terms:Likelihood_of_Exploit><xsl:value-of select="."/></terms:Likelihood_of_Exploit>
  </xsl:template>

  <!-- Common_Consequence -->
  <xsl:template match="Common_Consequence">
      <terms:Consequence_Scope><xsl:value-of select="Consequence_Scope/."/></terms:Consequence_Scope>
      <terms:Consequence_Technical_Impact><xsl:value-of select="Consequence_Technical_Impact/."/></terms:Consequence_Technical_Impact>
      <terms:Consequence_Note><xsl:value-of select="Consequence_Note/Text/."/></terms:Consequence_Note>
  </xsl:template>

  <!-- Mitigation -->
  <xsl:template match="Mitigation">
      <terms:Mitigation_Phase><xsl:value-of select="Mitigation_Phase/."/></terms:Mitigation_Phase>
      <terms:Mitigation_Description><xsl:value-of select="Mitigation_Description/Text/."/></terms:Mitigation_Description>
  </xsl:template>

  <!-- Causal_Nature -->
  <xsl:template match="Causal_Nature">
      <terms:Causal_Nature><xsl:value-of select="."/></terms:Causal_Nature>
  </xsl:template>

  <!-- Demonstrative_Example -->
  <xsl:template match="Demonstrative_Example">
      <terms:Intro_Text><xsl:value-of select="Intro_Text/."/></terms:Intro_Text>
  </xsl:template>

  <!-- Block -->
  <xsl:template match="Block">
      <terms:Block-Block_Nature><xsl:value-of select="Block/@Block_Nature"/></terms:Block-Block_Nature>
      <terms:Block-Code_Example_Language><xsl:value-of select="Block/Code_Example_Language/."/></terms:Block-Code_Example_Language>
      <terms:Block-Code><xsl:value-of select="Block/@Code"/></terms:Block-Code>
      <terms:Block-Text><xsl:value-of select="Text/."/></terms:Block-Text>
  </xsl:template>

  <!-- Taxonomy_Mappings -->
  <xsl:template match="Taxonomy_Mappings">
      <terms:Taxonomy_Mapping-Mapped_Taxonomy_Name><xsl:value-of select="Taxonomy_Mapping/@Mapped_Taxonomy_Name"/></terms:Taxonomy_Mapping-Mapped_Taxonomy_Name>
      <terms:Mapped_Node_Name><xsl:value-of select="Mapped_Node_Name/."/></terms:Mapped_Node_Name>
  </xsl:template>

  <!-- Related_Attack_Patterns -->
  <xsl:template match="Related_Attack_Patterns">
      <terms:Related_Attack_Pattern-CAPEC_Version><xsl:value-of select="Related_Attack_Pattern/@CAPEC_Version"/></terms:Related_Attack_Pattern-CAPEC_Version>
      <terms:Related_Attack_Pattern-CAPEC_ID><xsl:value-of select="Related_Attack_Pattern/CAPEC_ID/."/></terms:Related_Attack_Pattern-CAPEC_ID>
  </xsl:template>

  <!-- Submission -->
  <xsl:template match="Submission">
      <terms:Submission-Submission_Source><xsl:value-of select="@Submission_Source/."/></terms:Submission-Submission_Source>
      <terms:Submission><xsl:value-of select="."/></terms:Submission>
  </xsl:template>

  <!-- Modification -->
  <xsl:template match="Modification">
      <terms:Modification_Source><xsl:value-of select="@Modification_Source/."/></terms:Modification_Source>
      <terms:Modifier><xsl:value-of select="Modifier/."/></terms:Modifier>
      <terms:Modifier_Organization><xsl:value-of select="Modifier_Organization/."/></terms:Modifier_Organization>
      <terms:Modification_Date><xsl:value-of select="Modification_Date/."/></terms:Modification_Date>
      <terms:Modification_Comment><xsl:value-of select="Modification_Comment/."/></terms:Modification_Comment>
  </xsl:template>

</xsl:stylesheet>
