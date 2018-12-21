<?xml version="1.0" encoding="UTF-8" standalone="no" ?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml">
    <xsl:output omit-xml-declaration="yes" method="html" version="5" encoding="UTF-8" indent="no"/>
    <!-- <xsl:strip-space elements="tei:choice" /> -->
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
                        <h4 class="sectionTitle">
                            <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        </h4>
                        <div class="postcardWrapper">
                            <!-- immagine scan -->
                            <xsl:apply-templates select="tei:facsimile"/>
                        </div>
                        <div class="postcardWrapper">
                            <div class="digital">
                                <!-- immagine retro generata -->
                                <xsl:choose>
                                    <xsl:when test="tei:text//tei:div[@type='destination']">
                                        <div class="page">
                                            <xsl:apply-templates select="tei:text//tei:div[@type='message']"/>
                                        </div>
                                        <div class="page">
                                            <xsl:apply-templates select="tei:text//tei:div[@type='destination']"/>
                                        </div>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div style="width:100%">
                                            <xsl:apply-templates select="tei:text//tei:div[@type='message']"/>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </div>
                            <div class="meta">
                                <p class="tipografia">
                                    <span class="label">N° di catalogazione: </span>
                                    <xsl:value-of select="tei:text//tei:div[@type='add']"/>
                                </p>
                                <xsl:if test=".//tei:front//tei:orgName">
                                    <p class="tipografia">
                                        <span class="label">Editore cartolina: </span>
                                        <xsl:value-of select=".//tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/>
                                    </p>
                                </xsl:if>
                                <xsl:if test=".//tei:body//tei:head">
                                    <p class="tipografia">
                                        <span class="label">Titolo immagine: </span>
                                        <xsl:value-of select=".//tei:body//tei:head"/>
                                    </p>
                                </xsl:if>
                                <xsl:if test=".//tei:front//tei:s">
                                    <p class="tipografia">
                                        <span class="label">Testo Tipografico:</span>
                                    </p>
                                </xsl:if>
                                <xsl:for-each select=".//tei:front//tei:s|.//tei:front//tei:num">
                                    <p class="tipografia">
                                        > 
                                        <xsl:for-each select="text()|*">
                                            <xsl:choose>
                                                <xsl:when test="self::tei:figure">
                                                    <xsl:value-of select=".//tei:abbr"/>
                                                </xsl:when>
                                                <xsl:when test="self::text()|self::*">
                                                    <xsl:value-of select="."/>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:for-each>

                                    </p>
                                </xsl:for-each>
                            </div>
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
        <img class="scan retro" src="../{$id}/retro.jpg" title="{$id}" />
        <div class="fronteWrapper">
            <img class="fronte" src="../{$id}/fronte.jpg" title="{$id}" />
        </div>
    </xsl:template>
    <!-- ****** FINE DIV FACSIMILIE ****** -->
    <!-- ****** DIV VERSO ****** -->
    <!-- OPENER -->
    <xsl:template match="tei:div[@type='message']/tei:opener">
        <xsl:apply-templates select="tei:dateline"/>
        <xsl:apply-templates select="tei:salute/tei:s/tei:lb"/>
    </xsl:template>
    <!-- P -->
    <xsl:template match="tei:div[@type='message']/tei:p">
        <xsl:apply-templates select="./tei:s/tei:lb"/>
    </xsl:template>
    <!-- CLOSER -->
    <xsl:template match="tei:div[@type='message']/tei:closer//tei:s">
        <xsl:for-each select="tei:lb">
            <p class="manoscritto">
                <xsl:choose>
                    <xsl:when test="@type='sameline'">
                        <xsl:value-of select="following-sibling::text()"/>
                        <xsl:value-of select="../../../tei:signed/tei:s/text()[1]"/>
                    </xsl:when>
                    <xsl:when test="normalize-space(following-sibling::text())">
                        <xsl:value-of select="(following-sibling::text()|following-sibling::tei:persName)[1]" />
                    </xsl:when>
                    <xsl:when test="following-sibling::tei:persName[1]">
                        <xsl:for-each select="following-sibling::tei:persName">
                            <xsl:value-of select="."/>
                        </xsl:for-each>
                    </xsl:when>
                </xsl:choose>
            </p>
        </xsl:for-each>
        <!-- <xsl:apply-templates select="../../tei:dateline"/> -->
    </xsl:template>
    <!-- TEMPLATE DATELINE -->
    <xsl:template match="tei:div[@type='message']//tei:dateline">
        <p class="dateline manoscritto">
            <xsl:value-of select="."/>
        </p>
    </xsl:template>
    <!-- TEMPLATE PER <S> CON <LB> DENTRO -->
    <xsl:template match="tei:div[@type='message']//tei:lb">
        <xsl:variable name="pn" select="./following-sibling::tei:persName"/>
        <p class="manoscritto">
            <xsl:value-of select="normalize-space(./following-sibling::text())" />
            <xsl:value-of select="$pn"/>
            <xsl:value-of select="$pn/following-sibling::text()"/>
            <xsl:value-of select="$pn/following-sibling::tei:persName"/>
            <xsl:value-of select="$pn/following-sibling::tei:persName/following-sibling::tei:persName"/>
            <xsl:value-of select="$pn/following-sibling::tei:persName/following-sibling::text()"/>
            <xsl:value-of select="./following-sibling::tei:country"/>
            <xsl:value-of select="./following-sibling::tei:country/following-sibling::text()"/>
            <xsl:if test="@type='sameline'">
                <xsl:value-of select="../following-sibling::*[1]/text()"/>
            </xsl:if>
        </p>
    </xsl:template>

    <!-- DESTINATION -->
    <xsl:template match="tei:div[@type='destination']">
        <xsl:for-each select="tei:div[@n='2']/tei:p/tei:address/tei:addrLine">
            <p class="manoscritto">
                <xsl:choose>
                    <xsl:when test="tei:choice|tei:num">
                        <xsl:for-each select="text()|*">
                            <xsl:if test="self::tei:choice">
                                <xsl:value-of select="tei:abbr"/>
                            </xsl:if>
                            <xsl:if test="self::text()|self::tei:num">
                                <xsl:value-of select="."/>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space(.)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="text()|@*"></xsl:template>
</xsl:stylesheet>