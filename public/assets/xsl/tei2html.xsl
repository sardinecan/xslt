<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns="http://www.tei-c.org/ns/1.0"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="xs tei"
   version="1.0">
   
   <xsl:output method="html" indent="yes" encoding="UTF-8"/>
   
   <xsl:template match="/">
      <div type="letter">
         <xsl:apply-templates/>
      </div>
   </xsl:template>
   
   <xsl:template match="tei:teiHeader"/>
   
   <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
   
   <xsl:template match="tei:persName">
      <xsl:choose>
         <xsl:when test="@ref != ''">
            <a href="https://www.wikidata.org/entity/{substring-after(@ref, '#')}" target="_blank"><xsl:apply-templates/></a>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="tei:opener">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="tei:opener/tei:dateline">
      <p class="alignRight"><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="tei:opener/tei:salute">
      <p class="alignRight"><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="tei:closer/tei:salute">
      <p class="{@rend}"><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="tei:signed">
      <p class="alignRight"><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="tei:p">
      <p><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="tei:hi">
      <span class="{@rend}"><xsl:apply-templates/></span>
   </xsl:template>
   
   <xsl:template match="tei:del">
      <xsl:text>&lt;</xsl:text><xsl:apply-templates/><xsl:text>&gt;</xsl:text>
   </xsl:template>
   
   <xsl:template match="tei:add">
      <xsl:text>|</xsl:text><xsl:apply-templates/><xsl:text>|</xsl:text>
   </xsl:template>
   
   <xsl:template match="tei:unclear">
      <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text> ?]</xsl:text>
   </xsl:template>
   
   <xsl:template match="tei:supplied">
      <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
   </xsl:template>
   
   <xsl:template match="tei:note[@type='edition']">
      <xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
   </xsl:template>
   
   
</xsl:stylesheet>