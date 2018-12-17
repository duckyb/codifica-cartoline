<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
    <!-- xpath-default-namespace="http://www.tei-c.org/ns/1.0" -->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output omit-xml-declaration="yes" method="html" version="5" encoding="UTF-8" indent="yes"/>
    <xsl:template match="tei:teiCorpus">
        <xsl:comment>Entering teiCorpus</xsl:comment>
        <html>
            <head>
                <link href="foo" type="text/css"/>
                <script src="bar" type="text/javascript"/>
                <title>Cartoline</title>
            </head>
            <body>
                <h1>My corpus pippo</h1>
                <xsl:for-each select="tei:TEI">
                    <section>
                        <xsl:apply-templates />
                    </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
    <xsl:comment>*****TeiHeader*****</xsl:comment>
      <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:body">
        <xsl:comment>*****Body*****</xsl:comment>
        <p>
          <xsl:apply-templates />
        </p>
    </xsl:template>

    <xsl:template match="text()">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:template> 
</xsl:stylesheet>