<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet  
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" version="5" doctype-public="html" indent="yes">
    <xsl:template match="/">
        <html>
            <head>
                <title>Cartoline</title>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!-- TEMPLATES -->
    <xsl:template match="surface">
        <div class="computed postcard">
            <div style="position: relative;
                left: 50%;
                top: 10px;
                border-left:1px solid #111;
                height:300px">
                <p>
                    <xsl:apply-templates />                
                </p>
            </div>
            <xsl:value-of select="" />                
        </div>
    </xsl:template>

    <xsl:template match="facsimile">
        <h1>Hello World</h1>
    </xsl:template>

</xsl:stylesheet>