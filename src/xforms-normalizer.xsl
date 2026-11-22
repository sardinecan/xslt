<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xforms="http://www.w3.org/2002/xforms"
   xmlns:ev="http://www.w3.org/2001/xml-events"
   exclude-result-prefixes="xs xforms ev"
   version="2.0">
   
   <xsl:output method="xml" encoding="UTF-8"/>
   
   <xsl:template match="@*|node()">
      <xsl:copy>
         <xsl:apply-templates select="@*|node()"/>
      </xsl:copy>
   </xsl:template>
   
   <xsl:template match="xforms:*">
       <xsl:element name="xforms-{local-name()}" namespace="http://www.w3.org/1999/xhtml">
         <xsl:apply-templates select="@* | node()"/>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="@ev:*">
      <xsl:attribute name="ev-{local-name()}">
         <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
    
    <xsl:template match="xforms:*/@*[local-name(.) != 'id' and local-name(.) != 'class' and local-name(.) != 'nodeset']">
      <xsl:attribute name="xf-{local-name(.)}">
         <xsl:value-of select="."/>
      </xsl:attribute>
   </xsl:template>
   
    <xsl:template match="@nodeset">
        <xsl:attribute name="xf-ref">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>
