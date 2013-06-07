<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:iodef="urn:ietf:params:xml:ns:iodef-1.0"
    xmlns:iodef-ext-tools="urn:ietf:params:xml:ns:iodef-ext-tools"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
>
  <xsl:output method="xml" encoding="UTF-8"/>
  <xsl:variable name="url">http://localhost:8080/InformationSource/msg?msg=REFERENCE_IS&amp;download=1&amp;URI=</xsl:variable>

  <!--root-->
  <xsl:template match="/">
    <html>
    <head>
      <meta charset="UTF-8"/>
      <title>IODEF-SCI</title>
      <link href="css/iodef-sci.css" type="text/css" rel="stylesheet" media="screen"/>
    </head>
    <body>
      <xsl:apply-templates select="/iodef:IODEF-Document/iodef:Incident"/>
    </body>
    </html>
  </xsl:template>
  
  <!--RawData-->
  <xsl:template match="iodef-ext-tools:contents">
    <div class="element">
      <div class="element-header">
        <div class="element-title"><xsl:value-of select="./@category"/></div>
        <div class="attr-list">
          <xsl:element name="a">
            <xsl:variable name="id" select="./@id"/>
            <xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="./@category"/>/<xsl:value-of select="translate($id,':/','__')"/>.xml</xsl:attribute>
            <xsl:attribute name="class">download-btn</xsl:attribute>
            <xsl:text>download</xsl:text>
          </xsl:element>
        </div>
        <br style="clear:both" />
      </div>
      <br style="clear:both" />
    </div>
   </xsl:template>

  <!--Element-->
  <xsl:template match="*">
    <div class="element">
      <div class="element-header">
        <div class="element-title"><xsl:value-of select="name()"/></div>
        <xsl:if test="count(./@*)&gt;0">
        <div class="attr-list">
          <xsl:apply-templates select="./@*"/>
        </div>
        <br style="clear:both" />
        </xsl:if>
        <br style="clear:both" />
      </div>
      <xsl:if test="count(./*)&gt;0 or text()!=''">
      <div class="element-content">
          <xsl:value-of select="text()"/>
          <xsl:apply-templates select="./*"/>
      </div>
      </xsl:if>
    </div>
  </xsl:template>

  <!--Attribute-->
  <xsl:template match="@*">
    <div class="attr"><xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</div>
  </xsl:template>
  
</xsl:stylesheet>
