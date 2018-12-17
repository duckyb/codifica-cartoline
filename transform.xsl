<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0">
    <xsl:output method="html" version="5" doctype-public="html" indent="yes"/>
    <xsl:template match="/">
        <xsl:comment>Entering root template</xsl:comment>
        <html>
            <head>
                <title>Cartoline</title>
            </head>
            <body>
                <h1>My corpus</h1>
                <xsl:apply-templates />
            </body>
        </html>
    </xsl:template>

    <xsl:template match="//s">
        <xsl:value-of select="."/>
    </xsl:template>
</xsl:stylesheet>