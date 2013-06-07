<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY ontology 'http://discovery.nict.go.jp/ontology#'>
  <!ENTITY terms 'http://discovery.nict.go.jp/terms#'>
]>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
    xmlns:ai="http://scap.nist.gov/schema/asset-identification/1.1"
    xmlns:arf="http://scap.nist.gov/schema/asset-reporting-format/1.1"
    xmlns:core="http://scap.nist.gov/schema/reporting-core/1.1"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:xccdef="http://checklists.nist.gov/xccdf/1.1"
    xmlns:cpe="http://cpe.mitre.org/dictionary/2.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xhtml="http://www.w3.org/1999/xhtml"
>
<xsl:output method="html" encoding="UTF-8"/>
<xsl:variable name="url">http://localhost:8080/InformationSource/msg?msg=REFERENCE_IS&amp;URI=ARF/</xsl:variable>

  <!--root-->
  <xsl:template match="/">
    <html>
    <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    </head>
    <body>
      <xsl:apply-templates select="/arf:asset-report-collection/arf:reports/arf:report"/>
      <xsl:apply-templates select="/arf:asset-report-collection/arf:assets/arf:asset"/>
      <xsl:apply-templates select="/arf:asset-report-collection/arf:report-requests/arf:report-request"/>
    </body>
    </html>
  </xsl:template>

  <!-- arf:report -->
  <xsl:template match="arf:report">
    <xsl:variable name="arf-id" select="@id" />
    <xsl:apply-templates select="//core:relationship[@subject=$arf-id]/core:ref"/>

    <table>
    <tbody>
    <tr>
      <th>ontology:ITEM_TYPE</th><td>report</td>
    </tr>
    <tr>
      <th>ontology:ID</th><td><xsl:value-of select="$arf-id"/></td>
    </tr>

    <xsl:apply-templates select="arf:content/xccdef:TestResult"/>

    </tbody>
    </table>
  </xsl:template>

  <xsl:template match="core:ref">
    <a><xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="."/>.xml</xsl:attribute>link</a><br/>
  </xsl:template>

  <!-- arf:TestResult -->
  <xsl:template match="xccdef:TestResult">

    <tr>
      <th>terms:version</th><td><xsl:value-of select="@version"/></td>
    </tr>
    <tr>
      <th>terms:test</th><td><xsl:value-of select="@test-system"/></td>
    </tr>
    <tr>
      <th>terms:start-time</th><td><xsl:value-of select="@start-time"/></td>
    </tr>
    <tr>
      <th>terms:end-time</th><td><xsl:value-of select="@end-time"/></td>
    </tr>
    <tr>

      <th>terms:benchmark</th><td><xsl:value-of select="./xccdef:benchmark/@href"/></td>
    </tr>
    <tr>
      <th>terms:title</th><td><xsl:value-of select="./xccdef:title/."/></td>
    </tr>
    <tr>
      <th>terms:organization</th><td><xsl:value-of select="./xccdef:organization/."/></td>
    </tr>
    <tr>
      <th>terms:identity</th><td><xsl:value-of select="./xccdef:identity/."/></td>
    </tr>
    <tr>
      <th>terms:identity-authenticated</th><td><xsl:value-of select="./xccdef:identity/@authenticated"/></td>
    </tr>
    <tr>
      <th>terms:identity-privileged</th><td><xsl:value-of select="./xccdef:identity/@privileged"/></td>
    </tr>
    <tr>
      <th>terms:profile</th><td><xsl:value-of select="./xccdef:profile/."/></td>
    </tr>
    <tr>
      <th>terms:profile-idref</th><td><xsl:value-of select="./xccdef:profile/@idref"/></td>
    </tr>

      <xsl:apply-templates select="xccdef:target-address"/>
      <xsl:apply-templates select="xccdef:target-facts/xccdef:fact"/>
      <xsl:apply-templates select="xccdef:score"/>

  </xsl:template>

  <xsl:template match="xccdef:target-address">
    <tr>
      <th>terms:target-address</th><td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>

  <xsl:template match="xccdef:fact">
    <tr>
      <th>terms:fact</th><td><xsl:value-of select="."/></td>
    </tr>
    <tr>
      <th>terms:fact-name</th><td><xsl:value-of select="@name"/></td>
    </tr>
    <tr>
      <th>terms:fact-type</th><td><xsl:value-of select="@type"/></td>
    </tr>
  </xsl:template>

  <xsl:template match="xccdef:score">
    <tr>
      <th>terms:score</th><td><xsl:value-of select="."/></td>
    </tr>
    <tr>
      <th>terms:score-maximum</th><td><xsl:value-of select="@maximum"/></td>
    </tr>
    <tr>
      <th>terms:score-system</th><td><xsl:value-of select="@system"/></td>
    </tr>
  </xsl:template>


  <!-- arf:asset -->
  <xsl:template match="arf:asset">
    <xsl:variable name="arf-id" select="@id" />
    <a><xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="//core:ref[.=$arf-id]/../@subject"/>.xml</xsl:attribute>report</a><br/>

    <table>
    <tbody>
    <tr>
      <th>ontology:ITEM_TYPE</th><td>asset</td>
    </tr>
    <tr>
      <th>ontology:ID</th><td><xsl:value-of select="$arf-id"/></td>
    </tr>

      <xsl:apply-templates select="ai:computing-device"/>

    </tbody>
    </table>

  </xsl:template>

  <xsl:template match="ai:computing-device">
    <tr>
      <th>terms:fqdn</th><td><xsl:value-of select="ai:fqdn/."/></td>
    </tr>

      <xsl:apply-templates select="ai:connections/ai:connection"/>

  </xsl:template>

  <xsl:template match="ai:connection">
    <tr>
      <th>terms:ip-v4</th><td><xsl:value-of select="ai:ip-address/ai:ip-v4/."/></td>
    </tr>
  </xsl:template>


  <!-- report-request -->
  <xsl:template match="arf:report-request">
    <xsl:variable name="arf-id" select="@id" />
    <a><xsl:attribute name="href"><xsl:value-of select="$url"/><xsl:value-of select="//core:relationship/@subject"/>.xml</xsl:attribute>report</a><br/>
    
    <table>
    <tbody>
    <tr>
      <th>ontology:ITEM_TYPE</th><td>report-request</td>
    </tr>
    <tr>
      <th>ontology:ID</th><td><xsl:value-of select="$arf-id"/></td>
    </tr>

      <xsl:apply-templates select="arf:content/xccdef:Benchmark"/>

    </tbody>
    </table>

  </xsl:template>

  <!-- Benchmark -->
  <xsl:template match="xccdef:Benchmark">
    <tr>
      <th>terms:Benchmark-id</th><td><xsl:value-of select="@id"/></td>
    </tr>
    <tr>
      <th>terms:title</th><td><xsl:value-of select="xccdef:title"/></td>
    </tr>
    <tr>
      <th>terms:status-date</th><td><xsl:value-of select="xccdef:status/@date"/></td>
    </tr>
    <tr>
      <th>terms:status</th><td><xsl:value-of select="xccdef:status/."/></td>
    </tr>
    <tr>
      <th>terms:description</th><td><xsl:value-of select="xccdef:description/xhtml:strong/."/></td>
    </tr>
    <tr>
      <th>terms:notice-id</th><td><xsl:value-of select="xccdef:notice/@id"/></td>
    </tr>
    <tr>
      <th>terms:notice</th><td><xsl:value-of select="xccdef:notice/."/></td>
    </tr>
    <tr>
      <th>terms:reference-href</th><td><xsl:value-of select="xccdef:reference/@href"/></td>
    </tr>
    <tr>
      <th>terms:reference-publisher</th><td><xsl:value-of select="xccdef:reference/dc:publisher"/></td>
    </tr>
    <tr>
      <th>terms:reference-identifier</th><td><xsl:value-of select="xccdef:reference/dc:identifier"/></td>
    </tr>
    <tr>
      <th>terms:platform-idref</th><td><xsl:value-of select="xccdef:platform/@idref"/></td>
    </tr>
    <tr>
      <th>terms:version</th><td><xsl:value-of select="xccdef:version/."/></td>
    </tr>
    <tr>
      <th>terms:metadata-creator</th><td><xsl:value-of select="xccdef:metadata/dc:creator"/></td>
    </tr>
    <tr>
      <th>terms:metadata-publisher</th><td><xsl:value-of select="xccdef:metadata/dc:publisher"/></td>
    </tr>
    <tr>
      <th>terms:metadata-contributor</th><td><xsl:value-of select="xccdef:metadata/dc:contributor"/></td>
    </tr>
    <tr>
      <th>terms:metadata-source</th><td><xsl:value-of select="xccdef:metadata/dc:source"/></td>
    </tr>
    <tr>
      <th>terms:Profile-id</th><td><xsl:value-of select="xccdef:Profile/@id"/></td>
    </tr>
    <tr>
      <th>terms:Profile-title</th><td><xsl:value-of select="xccdef:Profile/xccdef:title/."/></td>
    </tr>
    <tr>
      <th>terms:Profile-description</th><td><xsl:value-of select="xccdef:Profile/xccdef:description/."/></td>
    </tr>
    <tr>
      <th>terms:Profile-select-idref</th><td><xsl:value-of select="xccdef:Profile/xccdef:select/@idref"/></td>
    </tr>
    <tr>
      <th>terms:Profile-select-selected</th><td><xsl:value-of select="xccdef:Profile/xccdef:select/@selected"/></td>
    </tr>
    <tr>
      <th>terms:Rule-id</th><td><xsl:value-of select="@id"/></td>
    </tr>
    <tr>
      <th>terms:Rule-selected</th><td><xsl:value-of select="xccdef:Rule/@selected"/></td>
    </tr>
    <tr>
      <th>terms:Rule-weight</th><td><xsl:value-of select="xccdef:Rule/@weight"/></td>
    </tr>
    <tr>
      <th>terms:Rule-title</th><td><xsl:value-of select="xccdef:Rule/xccdef:title/."/></td>
    </tr>
    <tr>
      <th>terms:Rule-description</th><td><xsl:value-of select="xccdef:Rule/xccdef:description/."/></td>
    </tr>
    <tr>
      <th>terms:Rule-ident-system</th><td><xsl:value-of select="xccdef:Rule/xccdef:ident/@system"/></td>
    </tr>
    <tr>
      <th>terms:Rule-ident</th><td><xsl:value-of select="xccdef:Rule/xccdef:ident/."/></td>
    </tr>
    <tr>
      <th>terms:Rule-check-system</th><td><xsl:value-of select="xccdef:Rule/xccdef:check/@system"/></td>
    </tr>
<!--
    <tr>
      <th>terms:Rule-check</th><td><xsl:value-of select="xccdef:Rule/xccdef:check/."/></td>
    </tr>
-->
    <tr>
      <th>terms:Rule-check-check-content-ref-href</th><td><xsl:value-of select="xccdef:Rule/xccdef:check/xccdef:check-content-ref/@href"/></td>
    </tr>
    <tr>
      <th>terms:Rule-check-check-content-ref-name</th><td><xsl:value-of select="xccdef:Rule/xccdef:check/xccdef:check-content-ref/@name"/></td>
    </tr>
  </xsl:template>


</xsl:stylesheet>
