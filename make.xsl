<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
    <!-- xpath-default-namespace="http://www.tei-c.org/ns/1.0" -->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output omit-xml-declaration="yes" method="html" version="5" encoding="UTF-8" indent="yes"/>
    <xsl:template match="tei:teiCorpus">
        <html>
            <head>
                <link rel="stylesheet" href="style.css" type="text/css"/>
                <script src="bar" type="text/javascript"/>
                <title>Cartoline</title>
            </head>
            <body>
                <xsl:apply-templates select="tei:respStmt"/>
                <h1>Codifica cartoline</h1>
                <xsl:for-each select="tei:TEI">
                    <section>
                        <span class="debug">Questa è una cartolina</span>
                        <xsl:apply-templates />
                    </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
      <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:fileDesc">
      <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:body">
        <div>
          <xsl:apply-templates />
        </div>
    </xsl:template>

    <xsl:template match="text()">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:template> 

    <xsl:template match="tei:editionStmt">
      <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:respStmt">
      <ul class="debug">
      <xsl:for-each select="tei:persName">
        <li class="debug">
        <xsl:apply-templates />
        </li>
      </xsl:for-each>
      </ul>
    </xsl:template>

</xsl:stylesheet>