<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
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
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>

    <!-- pagina iniziale -->
    <xsl:template match="tei:teiHeader[@id='corpusHeader']/tei:fileDesc/tei:editionStmt/tei:respStmt">
        <h1>Codifica Cartoline</h1>
        <p class="subtitle">un progetto a cura di</p>
        <ul class="debug">
            <xsl:for-each select="tei:persName">
                <li class="debug">
                    <xsl:apply-templates />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    
    <!-- raggiungo un nodo | foglia testo -->
    <xsl:template match="text()">
      <xsl:value-of select="normalize-space(.)"/>
    </xsl:template> 

<!-- end -->
</xsl:stylesheet>