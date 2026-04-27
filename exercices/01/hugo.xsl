<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xpath-default-namespace="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="xs"
   version="2.0">
   
   <xsl:template match="/">
      <xsl:apply-templates/>
   </xsl:template>
   
   <xsl:template match="TEI">
      <html>
         <xsl:apply-templates/>
      </html>
   </xsl:template>
   
   <xsl:template match="teiHeader">
      <xsl:element name="head">
         <meta charset="UTF-8"/>
         <title><xsl:value-of select="concat(fileDesc/titleStmt/author, ' - ', fileDesc/titleStmt/title)"/></title>
      </xsl:element>
   </xsl:template>
   
   <xsl:template match="text">
      <body>
         <article>
            <ul>
               <xsl:apply-templates select="//div[@type='chapter']/head" mode="toc"/>
            </ul>
         </article>
         <xsl:apply-templates/>
      </body>
   </xsl:template>
   
   <xsl:template match="div[@type='book']">
      <main>
         <xsl:attribute name="class" select="@type"/>
         <xsl:apply-templates/>
      </main>
   </xsl:template>
   
   <xsl:template match="div[@type='chapter']">
      <section id="{ ./@xml:id }" class="chapter">
         <xsl:apply-templates/>
      </section>
   </xsl:template>
   
   <xsl:template match="head">
      <xsl:choose>
         <xsl:when test="parent::div[@type = 'chapter']">
            <h2><xsl:apply-templates/></h2>
         </xsl:when>
         <xsl:otherwise>
            <h1><xsl:apply-templates/></h1>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template match="head" mode="toc">
      <xsl:variable name="id" select="concat('#', parent::div/@xml:id)"/>
      <li><a href="{ $id }"><xsl:apply-templates/></a></li>
   </xsl:template>
   
   <xsl:template match="p | lg">
      <p><xsl:apply-templates/></p>
   </xsl:template>
   
   <xsl:template match="l">
      <xsl:variable name="num">
         <xsl:number count="l" from="lg" level="single"/>
      </xsl:variable>
      <span class="verse">
         <xsl:if test="$num mod 5 = 0"><xsl:value-of select="concat('[', $num, '] ')"/></xsl:if>
         <xsl:apply-templates/>
      </span>
      <br/>
   </xsl:template>
   
</xsl:stylesheet>