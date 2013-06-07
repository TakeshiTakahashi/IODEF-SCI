<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY rdf 'http://www.w3.org/1999/02/22-rdf-syntax-ns#'>
  <!ENTITY rdfs 'http://www.w3.org/2000/01/rdf-schema#'>
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:cybox="http://cybox.mitre.org/XMLSchema/cybox_v0.7"
    xmlns:maec="http://maec.mitre.org/XMLSchema/maec-core-2"
    xmlns:mmdef="http://xml/metadataSharing.xsd"
    xmlns:commonTypes="http://cybox.mitre.org/XMLSchema/objects#Common"
    xmlns:ProcessObj="http://cybox.mitre.org/XMLSchema/objects#ProcessObject"
    xmlns:WinProcessObj="http://cybox.mitre.org/XMLSchema/objects#WinProcessObject"
    xmlns:FileObj="http://cybox.mitre.org/XMLSchema/objects#FileObject"
    xmlns:WinExecFileObj="http://cybox.mitre.org/XMLSchema/objects#WinExecFileObject"
    xmlns:MutexObj="http://cybox.mitre.org/XMLSchema/objects#MutexObject"
    xmlns:WinMutexObj="http://cybox.mitre.org/XMLSchema/objects#WinMutexObject"
    xmlns:URIObj="http://cybox.mitre.org/XMLSchema/objects#URIObject"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
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

      <xsl:apply-templates select="/maec:MAEC_Bundle/maec:Analyses/maec:Analysis"/>
      <xsl:apply-templates select="/maec:MAEC_Bundle/maec:Actions/maec:Action"/>
      <xsl:apply-templates select="/maec:MAEC_Bundle/maec:Behaviors/maec:Behavior"/>
      <xsl:apply-templates select="/maec:MAEC_Bundle/maec:Objects/maec:Object"/>

    </rdf:RDF>
  </xsl:template>


  <!-- maec:Analysis -->
  <xsl:template match="maec:Analysis">
    <xsl:variable name="maec-id" select="@id" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;MAEC" />

      <ontology:SecurityInformation>MAEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$maec-id"/></ontology:ID>

      <terms:method><xsl:value-of select="@method"/></terms:method>
      <terms:Subject-Object-id><xsl:value-of select="maec:Subject/maec:Object/@id"/></terms:Subject-Object-id>
      <terms:Subject-Object-idref><xsl:value-of select="maec:Subject/maec:Object/@idref"/></terms:Subject-Object-idref>
      <terms:Summary><xsl:value-of select="maec:Summary/."/></terms:Summary>
<!--
      <xsl:apply-templates select="//*"/>
-->
    </rdf:Description>

  </xsl:template>

  <!-- maec:Source -->
  <xsl:template match="maec:Source">
      <terms:Source-Name><xsl:value-of select="maec:Name"/></terms:Source-Name>
      <terms:Source-URL-Value-Datatype><xsl:value-of select="maec:URL/URIObj:Value/@Datatype"/></terms:Source-URL-Value-Datatype>
      <terms:Source-URL-Value><xsl:value-of select="maec:URL/URIObj:Value"/></terms:Source-URL-Value>
      <terms:Source-Name><xsl:value-of select="."/></terms:Source-Name>
  </xsl:template>

  <!-- maec:Tool -->
  <xsl:template match="maec:Tool">
      <terms:Tool-ID><xsl:value-of select="@ID"/></terms:Tool-ID>
      <terms:Tool-Name><xsl:value-of select="cybox:Name"/></terms:Tool-Name>
      <terms:Tool-Version><xsl:value-of select="cybox:Version"/></terms:Tool-Version>
  </xsl:template>




  <!-- maec:Action -->
  <xsl:template match="maec:Action">
    <xsl:variable name="maec-id" select="@id" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;MAEC" />
      <ontology:SecurityInformation>MAEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$maec-id"/></ontology:ID>

      <terms:id><xsl:value-of select="@id"/></terms:id>
      <terms:Type><xsl:value-of select="@Type"/></terms:Type>
      <terms:Context><xsl:value-of select="@Context"/></terms:Context>
      <terms:Action_Status><xsl:value-of select="@Action_Status"/></terms:Action_Status>
      <terms:Defined_Name><xsl:value-of select="cybox:Action_Name/cybox:Defined_Name/."/></terms:Defined_Name>
      <terms:Discovery_Method-SourceType><xsl:value-of select="cybox:Discovery_Method/@SourceType"/></terms:Discovery_Method-SourceType>

      <xsl:apply-templates select="cybox:Tools/cybox:Tool"/>
      <xsl:apply-templates select="maec:Associated_Objects/Associated_Object"/>
    </rdf:Description>

  </xsl:template>

  <!-- cybox:Tool -->
  <xsl:template match="cybox:Tool">
    <terms:Tool-IDREF><xsl:value-of select="@IDREF"/></terms:Tool-IDREF>
  </xsl:template>

  <!-- maec:Associated_Object -->
  <xsl:template match="maec:Associated_Object">
      <terms:Associated_Object-idref><xsl:value-of select="@idref"/></terms:Associated_Object-idref>
      <terms:Associated_Object-AssociationType><xsl:value-of select="@AssociationType"/></terms:Associated_Object-AssociationType>
      <terms:Associated_Object-id><xsl:value-of select="@id"/></terms:Associated_Object-id>
      <terms:Associated_Object-Type><xsl:value-of select="@Type"/></terms:Associated_Object-Type>
  </xsl:template>

  <!-- cybox:Defined_Object -->
  <xsl:template match="cybox:Defined_Object">
      <terms:Defined_Object-type><xsl:value-of select="@xsi:type"/></terms:Defined_Object-type>
      <terms:File_Name-Datatype><xsl:value-of select="FileObj:File_Name/@Datatype"/></terms:File_Name-Datatype>
      <terms:File_Name><xsl:value-of select="FileObj:File_Name/."/></terms:File_Name>
      <terms:Full_Path-Datatype><xsl:value-of select="FileObj:Full_Path/@Datatype"/></terms:Full_Path-Datatype>
      <terms:Full_Path-PatternType><xsl:value-of select="FileObj:Full_Path/@PatternType"/></terms:Full_Path-PatternType>
      <terms:Full_Path><xsl:value-of select="FileObj:Full_Path/."/></terms:Full_Path>
  </xsl:template>



  <!-- maec:Behavior -->
  <xsl:template match="maec:Behavior">
    <xsl:variable name="maec-id" select="@id" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;MAEC" />

      <ontology:SecurityInformation>MAEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$maec-id"/></ontology:ID>
      <terms:ordinal_position><xsl:value-of select="@ordinal_position"/></terms:ordinal_position>
      <terms:status><xsl:value-of select="@status"/></terms:status>
      <terms:Description><xsl:value-of select="maec:Description/."/></terms:Description>

      <xsl:apply-templates select="*"/>
    </rdf:Description>

  </xsl:template>

  <!-- maec:Action -->
  <xsl:template match="maec:Action">
      <terms:Action-idref><xsl:value-of select="@idref"/></terms:Action-idref>
      <terms:Action-Type><xsl:value-of select="@Type"/></terms:Action-Type>
  </xsl:template>

  <!-- maec:Relationship -->
  <xsl:template match="maec:Relationship">
      <terms:Relationship-type><xsl:value-of select="@type"/></terms:Relationship-type>
      <terms:Behavior-idref><xsl:value-of select="maec:Behavior/@idref"/></terms:Behavior-idref>
  </xsl:template>



  <!-- maec:Object -->
  <xsl:template match="maec:Object">
    <xsl:variable name="maec-id" select="@id" />

    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <rdf:type rdf:resource="&rdfs;Class" />
      <rdfs:Class rdf:resource="&terms;item" />
      <rdfs:subClassOf rdf:resource="&ontology;MAEC" />

      <ontology:SecurityInformation>MAEC</ontology:SecurityInformation>
      <ontology:URI><xsl:value-of select="$URI"/></ontology:URI>
      <ontology:CATEGORY><xsl:value-of select="$CATEGORY"/></ontology:CATEGORY>
      <ontology:INFOSOURCE_NAME><xsl:value-of select="$INFOSOURCE_NAME"/></ontology:INFOSOURCE_NAME>
      <ontology:CREATE_DATE><xsl:value-of select="$CREATE_DATE"/></ontology:CREATE_DATE>
      <ontology:UPDATE_DATE><xsl:value-of select="$UPDATE_DATE"/></ontology:UPDATE_DATE>
      <ontology:AUTH_LEVEL><xsl:value-of select="$AUTH_LEVEL"/></ontology:AUTH_LEVEL>
      <ontology:HIT_COUNTER><xsl:value-of select="$HIT_COUNTER"/></ontology:HIT_COUNTER>
      <ontology:ID><xsl:value-of select="$maec-id"/></ontology:ID>
      <terms:Type><xsl:value-of select="@Type"/></terms:Type>
      <terms:Defined_Object-type><xsl:value-of select="@xsi:type"/></terms:Defined_Object-type>

      <xsl:apply-templates select="*"><xsl:with-param name="maec-id" select="$maec-id"/></xsl:apply-templates>
    </rdf:Description>

  </xsl:template>

  <!-- cybox:Defined_Object -->
  <xsl:template match="cybox:Defined_Object">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
    </rdf:Description>
  </xsl:template>

  <!-- FileObj:File_Name -->
  <xsl:template match="FileObj:File_Name">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:File_Name-Datatype><xsl:value-of select="@Datatype"/></terms:File_Name-Datatype>
      <terms:File_Name><xsl:value-of select="."/></terms:File_Name>
    </rdf:Description>
  </xsl:template>

  <!-- commonTypes:Hash -->
  <xsl:template match="commonTypes:Hash">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:Hash_Value-Datatype><xsl:value-of select="Hash_Value/@Datatype"/></terms:Hash_Value-Datatype>
      <terms:Hash_Value><xsl:value-of select="Hash_Value"/></terms:Hash_Value>
      <terms:Type-Datatype><xsl:value-of select="commonTypes:Hash_Value/@Datatype"/></terms:Type-Datatype>
      <terms:Type><xsl:value-of select="commonTypes:Type"/></terms:Type>
    </rdf:Description>
  </xsl:template>

  <!-- FileObj:Name -->
  <xsl:template match="FileObj:Name">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:Name-Datatype><xsl:value-of select="@Datatype"/></terms:Name-Datatype>
      <terms:Name><xsl:value-of select="."/></terms:Name>
    </rdf:Description>
  </xsl:template>

  <!-- FileObj:Size_In_Bytes -->
  <xsl:template match="FileObj:Size_In_Bytes">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:Size_In_Bytes-Datatype><xsl:value-of select="@Datatype"/></terms:Size_In_Bytes-Datatype>
      <terms:Size_In_Bytes><xsl:value-of select="."/></terms:Size_In_Bytes>
    </rdf:Description>
  </xsl:template>

  <!-- FileObj:Base_Address -->
  <xsl:template match="FileObj:Base_Address">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:Base_Address-Datatype><xsl:value-of select="@Datatype"/></terms:Base_Address-Datatype>
      <terms:Base_Address><xsl:value-of select="."/></terms:Base_Address>
    </rdf:Description>
  </xsl:template>

  <!-- FileObj:Major_Linker_Version -->
  <xsl:template match="FileObj:Major_Linker_Version">
    <xsl:param name="maec-id"/>
    <rdf:Description>
      <xsl:attribute name="rdf:about"><xsl:value-of select="$URI"/>/MAEC/<xsl:value-of select="$maec-id"/></xsl:attribute>
      <terms:Major_Linker_Version-Datatype><xsl:value-of select="@Datatype"/></terms:Major_Linker_Version-Datatype>
      <terms:Major_Linker_Version><xsl:value-of select="."/></terms:Major_Linker_Version>
    </rdf:Description>
  </xsl:template>

</xsl:stylesheet>
