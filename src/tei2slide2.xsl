<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:eg="http://www.tei-c.org/ns/Examples"
    xmlns:file="http://expath.org/ns/file"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:x="http://www.w3.org/1999/xhtml"
    xmlns:xf="http://www.w3.org/2002/xforms"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="xs tei eg"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" indent="yes" omit-xml-declaration="true"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI" mode="form"/>
        <xsl:apply-templates select="descendant::tei:div[@type='slide']"/>
    </xsl:template>
    
    <xsl:variable name="title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
    
    <xsl:template match="tei:TEI" mode="form">
        <xsl:result-document href="../build/index.html">
            <!--<xsl:processing-instruction name="xml-stylesheet">href="../assets/xsltforms/xsltforms.xsl" type="text/xsl"</xsl:processing-instruction>-->
            <html xmlns:ev="http://www.w3.org/2001/xml-events" xmlns:h="http://www.w3.org/1999/xhtml" xmlns:xlink="http://www.w3.org/1999/xlink" xf:bogus="fix/Firefox/namespace/issue" xs:bogus="fix/Firefox/namespace/issue" xlink:bogus="fix/Firefox/namespace/issue" tei:bogus="fix/Firefox/namespace/issue" lang="fr">
                <head>
                    <meta name="viewport" content="initial-scale=1, width=device-width, viewport-fit=cover" charset="utf8"/>
                    <title><xsl:apply-templates select="$title"/></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <script src="../assets/xsltforms/xsltforms.js">/**/</script>
                </head>
                <body>
                    <xforms-model>
                        <xforms-instance id="tutorial">
                            <script type="application/xml">
                                <tutorial xmlns="">
                                    <xsl:for-each select="descendant::tei:div[@type='slide']">
                                        <entry>
                                            <title><xsl:value-of select="./tei:head"/></title>
                                            <file>slide<xsl:value-of select="position()"/>.xhtml</file>
                                        </entry>
                                    </xsl:for-each>
                                </tutorial>
                            </script>
                        </xforms-instance>
                        <xforms-instance id="nav">
                            <script type="application/xml">
                                <nav xmlns="">
                                    <base/>
                                    <file/>
                                    <url/>
                                </nav>
                            </script>
                        </xforms-instance>
                        <xforms-bind xf-ref="instance('nav')/url" xf-calculate="concat(../base, ../file)"/>
                        <xforms-submission id="save" xf-ref="instance('nav')" xf-resource="nav.xml" xf-method="put" xf-replace="none"/>
                        <xforms-submission id="restore" xf-replace="instance" xf-instance="nav" xf-resource="nav.xml" xf-method="get" xf-serialization="none"/>
                        <xforms-action ev-event="xforms-ready">
                            <xforms-setvalue xf-ref="instance('nav')/file" xf-value="instance('tutorial')/entry[1]/file"/>
                            <xforms-send xf-submission="restore"/>
                        </xforms-action>
                    </xforms-model>
                    <xforms-group>
                        <!--<switch>
                <case id="hide">
                    <trigger class="block" appearance="minimal">
                        <label>▸ XForms Hands-On Tutorial</label>
                        <toggle case="show" ev:event="DOMActivate"/>
                    </trigger>
                </case>
                <case id="show">
                    <trigger appearance="minimal">
                        <label>▾ XForms Hands-On Tutorial</label>
                        <toggle case="hide" ev:event="DOMActivate"/>
                    </trigger>
                    <select1 class="block" ref="instance('nav')/file" appearance="full">
                        <itemset ref="instance('tutorial')/entry">
                            <label ref="title"/>
                            <value value="file"/>
                        </itemset>
                    </select1>
                </case>
            </switch>-->
                        <xforms-action ev-event="xforms-value-changed"> <!-- Only for the value of 'show' -->
                            <xforms-send xf-submission="save"/> <!-- if it succeeds great; if it fails, too bad -->
                        </xforms-action>
                        <xforms-group id="nav">
                            <xforms-trigger xf-ref="instance('tutorial')/entry[file=instance('nav')/file]/preceding-sibling::entry[1]" id="navLeft">
                                <xforms-label>←<!--🡰--></xforms-label>
                                <xforms-hint>
                                    <xforms-output xf-ref="title"/>
                                </xforms-hint>
                                <xforms-setvalue xf-ref="instance('nav')/file" xf-value="context()/file" ev-event="DOMActivate"/>
                            </xforms-trigger>
                            <xforms-select1 xf-ref="instance('nav')/file" xf-appearance="{{instance('nav')/appearance}}" id="navSelect">
                                <xforms-itemset xf-ref="instance('tutorial')/entry">
                                    <xforms-label xf-ref="title"/>
                                    <xforms-value xf-value="file"/>
                                </xforms-itemset>
                            </xforms-select1>
                            <xforms-trigger xf-ref="instance('tutorial')/entry[file=instance('nav')/file]/following-sibling::entry" id="navRight">
                                <xforms-label>→<!--🡲--></xforms-label>
                                <xforms-hint>
                                    <xforms-output xf-ref="title"/>
                                </xforms-hint>
                                <xforms-setvalue xf-ref="instance('nav')/file" xf-value="context()/file" ev-event="DOMActivate"/>
                            </xforms-trigger>
                        </xforms-group>
                        <h:iframe xmlns="http://www.w3.org/2002/xforms" id="whyisthisneeded" xf-avt="true" xf-template-src="{{instance('nav')/url}}"/>
                    </xforms-group>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:TEI" mode="nav">
        
    </xsl:template>
    
    <xsl:template match="tei:div[@type='slide'][not(@subtype)]">
        <xsl:variable name="n">
            <xsl:number count="tei:div[@type='slide']" from="tei:body" level="any"/>
        </xsl:variable>
        <xsl:result-document href="../build/slide{$n}.xhtml" method="xhtml" doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN'" doctype-system="'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'">
            <html>
                <head>
                    <meta charset="utf-8"/>
                    <title><xsl:apply-templates select="$title"/></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/atom-one-light.min.css" integrity="sha512-o5v54Kh5PH0dgnf9ei0L+vMRsbm5fvIvnR/XkrZZjN4mqdaeH7PW66tumBoQVIaKNVrLCZiBEfHzRY4JJSMK/Q==" crossorigin="anonymous" referrerpolicy="no-referrer" />-->
                    <link rel="stylesheet" href="//unpkg.com/@catppuccin/highlightjs@1.0.1/css/catppuccin-latte.css"/>
                    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/styles/atom-one-dark-reasonable.min.css" integrity="sha512-RwXJS3k4Z0IK6TGoL3pgQlA9g2THFhKL7z9TYWdAI8u6xK0AUuMWieJuWgTRayywC9A94ifUj1RzjDa1NIlUIg==" crossorigin="anonymous" referrerpolicy="no-referrer" />-->
                    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js">/**/</script>
                </head>
                <body>
                    <main class="slide {if(@rend = 'titlePage') then 'titlePage' else ''}">
                        <xsl:apply-templates/>
                    </main>
                    <script>hljs.highlightAll();</script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='slide'][@subtype = 'xforms']">
        <xsl:variable name="n">
            <xsl:number count="tei:div[@type='slide']" from="tei:body" level="any"/>
        </xsl:variable>
        <xsl:result-document href="../build/slide{$n}.xhtml">
            <!--<xsl:processing-instruction name="xml-stylesheet">href="../assets/xsltforms/xsltforms.xsl" type="text/xsl"</xsl:processing-instruction>-->
            <html xmlns:ev="http://www.w3.org/2001/xml-events"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xf:bogus="fix/Firefox/namespace/issue"
                xs:bogus="fix/Firefox/namespace/issue"
                xlink:bogus="fix/Firefox/namespace/issue"
                tei:bogus="fix/Firefox/namespace/issue"
                lang="fr">
                <head>
                    <meta charset="utf-8"/>
                    <title><xsl:apply-templates select="$title"/></title>
                    <link rel="stylesheet" href="../assets/css/main.css" type="text/css"/>
                    <link rel="stylesheet" href="../assets/css/tei.css" type="text/css"/>
                    <script src="../assets/xsltforms/xsltforms.js">/**/</script>
                    <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.0.1/styles/atom-one-dark-reasonable.min.css" integrity="sha512-RwXJS3k4Z0IK6TGoL3pgQlA9g2THFhKL7z9TYWdAI8u6xK0AUuMWieJuWgTRayywC9A94ifUj1RzjDa1NIlUIg==" crossorigin="anonymous" referrerpolicy="no-referrer" />-->
                    <link rel="stylesheet" href="//unpkg.com/@catppuccin/highlightjs@1.0.1/css/catppuccin-latte.css"/>
                    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js">/**/</script>
                    <script src="../assets/js/generateid.js"/>
                </head>
                <body>
                    <xsl:apply-templates select="tei:div[@type='model']"/>
                    <main class="slide {if(@rend = 'titlePage') then 'titlePage' else ''}">
                        <xsl:apply-templates select="tei:div[@type='content']"/>
                    </main>
                    <script>hljs.highlightAll();</script>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='model']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='content']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='details']">
        <details><xsl:apply-templates/></details>
    </xsl:template>
    
    <xsl:template match="tei:div[@type='details']/tei:label">
        <summary><xsl:apply-templates/></summary>
    </xsl:template>
    
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@type">
                <xsl:attribute name="class"><xsl:value-of select="@type"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="xf:*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="x:*">
        <xsl:copy-of select="."/>
    </xsl:template>
    
    <xsl:template match="eg:egXML">
        <pre>
            <code class="language-{./@rend}">
                <!--<xsl:copy-of select="node()"/>-->
                <xsl:value-of disable-output-escaping="no" select="./node()"/>
            </code>
        </pre>
    </xsl:template>
    
    <xsl:template match="tei:code">
        <code><xsl:apply-templates/></code>
    </xsl:template>
    
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="tei:emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend = 'bold'">
                <strong><xsl:apply-templates/></strong>
            </xsl:when>
            <xsl:otherwise><span class="{@rend}"><xsl:apply-templates/></span></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:ref">
        <a href="{@target}" target="_blank"><xsl:apply-templates/></a>
    </xsl:template>
    
    <xsl:template match="tei:figure">
        <figure><xsl:apply-templates/></figure>
    </xsl:template>
    
    <xsl:template match="tei:graphic">
        <img src="{@url}"/>
    </xsl:template>
    
    <xsl:template match="tei:figDesc">
        <figcaption><xsl:apply-templates/></figcaption>
    </xsl:template>
    
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="ancestor::tei:div[@subtype='xforms']">
                <xsl:variable name="level" select="count(ancestor::tei:div[not(descendant::tei:div[@type='content'])])"/>
                <xsl:element name="h{$level}">
                    <xsl:if test="@rend">
                        <xsl:attribute name="class" select="@rend"/>
                    </xsl:if>
                    <xsl:attribute name="class"/>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="level" select="count(ancestor::tei:div[not(descendant::tei:div[@type='slide'])])"/>
                <xsl:element name="h{$level}">
                    <xsl:if test="@rend">
                        <xsl:attribute name="class" select="@rend"/>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:del">
        <del><xsl:apply-templates/></del>
    </xsl:template>
    
</xsl:stylesheet>