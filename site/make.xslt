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
                <!-- head -->
                <link rel="icon" href="./sparkles.ico" />
                <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900|Playfair+Display:400,700,900|  :300,400" rel="stylesheet"/>
                <link rel="stylesheet" href="style.css" type="text/css"/>
                <script src="main.js" type="text/javascript"/>
                <title>Cartoline</title>
            </head>
            <body>
                <div class="fullHeight">
                    <!-- body -->
                    <xsl:apply-templates select="tei:teiHeader[@xml:id='corpusHeader']/tei:fileDesc/tei:titleStmt/tei:respStmt" />
                    <section class="flex selectionWrapper">
                        <xsl:apply-templates select="tei:TEI" />
                        <!-- section 3 immagini fronte e id -->
                    </section>
                </div>
                <!-- contenuti cartoline -->
                <xsl:for-each select="tei:TEI">
                    <xsl:comment>inizio cartolina</xsl:comment>
                    <xsl:apply-templates select="tei:teiHeader"/>
                    <!-- immagine retro e scan -->
                    <section>
                        <h4>
                            <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        </h4>
                        <div class="scan">
                            <!-- immagine scan -->
                            <xsl:apply-templates select="tei:facsimile"/>
                        </div>
                        <div class="digital">
                            <!-- immagine retro generata -->
                            <xsl:apply-templates select="tei:text"/>
                        </div>
                    </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
    <!-- ****** TEI HEADER ****** -->
    <!-- pagina iniziale -->
    <xsl:template match="tei:teiHeader[@xml:id='corpusHeader']/tei:fileDesc/tei:titleStmt/tei:respStmt">
        <header>
            <h1>Ediz. Digitale Cartoline Prima Guerra Mondiale</h1>
            <hr/>
            <h3 class="subtitle">un progetto a cura di</h3>
            <ul>
                <xsl:for-each select="tei:persName">
                    <li>
                        <xsl:value-of select="."/>
                    </li>
                </xsl:for-each>
            </ul>
        </header>
    </xsl:template>
    <!-- selettori cartoline -->
    <xsl:template match="tei:TEI">
        <xsl:variable name="id" select="./@xml:id"/>
        <div class="contentFronte">
            <a href="#">
                <div class="selection" style="background-image: url('../{$id}/fronte.jpg')"></div>
                <h4 class="col3">
                    <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
                </h4>
            </a>
        </div>
    </xsl:template>
    <!-- ******  HEADER ****** -->
    <!-- ****** DIV FACSIMILIE ****** -->
    <xsl:template match="tei:facsimile">
        <xsl:variable name="id" select="../@xml:id"/>
        <img class="retro" src="../{$id}/retro.jpg" title="{$id}" />
    </xsl:template>
    <!-- ****** FINE DIV FACSIMILIE ****** -->
    <!-- ****** DIV VERSO ****** -->
    <xsl:template match="tei:text//tei:div[@type='verso']">
        <p class="manoscritto">
            <xsl:choose>
                <xsl:when test=".//tei:dateline//tei:date/tei:change">
                    <xsl:value-of select="../tei:date"/>
                    <xsl:value-of select="./tei:abbr"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="tei:dateline"/>
                </xsl:otherwise>
            </xsl:choose>
        </p>
        <xsl:apply-templates />
    </xsl:template>
    <!-- ****** FINE DIV VERSO ****** -->
    <!-- ****** DIV MESSAGE ****** -->
    <!-- match su tag s del div message -->
    <xsl:template match="tei:div[@type='message']//tei:s">
        <xsl:apply-templates select=".//tei:lb"/>
    </xsl:template>
    <!-- match su tag p del div message -->
    <xsl:template match="tei:div[@type='message']//p">
        <xsl:apply-templates select=".//lb"/>
    </xsl:template>
    <!-- match su tag closer del div message -->
    <xsl:template match="tei:div[@type='message']//tei:closer">
        <p class="manoscritto">
            <xsl:apply-templates />
        </p>
    </xsl:template>
    <!-- stampa tutte le frasi regolarmente formattate come nella cartolina -->
    <xsl:template match="tei:lb ">
        <p class="manoscritto">
            <xsl:value-of select="./following-sibling::text()" />
            <xsl:value-of select="./following-sibling::tei:persName"/>
            <xsl:value-of select="./following-sibling::tei:persName/following-sibling::text()"/>
            <xsl:value-of select="./following-sibling::tei:country"/>
            <xsl:value-of select="./following-sibling::tei:country/following-sibling::text()"/>
            <xsl:if test="@type='sameline'">
                <xsl:value-of select="../following-sibling::*[1]/text()"/>
            </xsl:if>
        </p>
    </xsl:template>
    <!-- ****** FINE DIV MESSAGE ******  -->
    <!-- raggiungo un nodo | foglia testo -->
    <xsl:template match="text()|@*"></xsl:template>
    <!-- end -->
</xsl:stylesheet>