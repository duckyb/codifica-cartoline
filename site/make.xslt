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
                <link rel="icon" href="./static/sparkles.ico" />
                <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
                <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,900|Playfair+Display:400,700,900|  :300,400" rel="stylesheet"/>
                <link rel="stylesheet" href="style.css" type="text/css"/>
                <script src="jquery-3.3.1.min.js" type="text/javascript"/>
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
                    <xsl:variable name="teiid" select="@xml:id"/>
                    <xsl:comment>inizio cartolina</xsl:comment>
                    <!-- immagine retro e scan -->
                    <section id="{$teiid}" class="content_postcard">
                        <h4 class="sectionTitle">
                            <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                        </h4>
                        <div class="postcardWrapper">
                            <!-- immagine scan -->
                            <div class="filterbar">
                                <div class="sez1">
                                    <a href="static/{$teiid}/retro.jpg" target="_blank">
                                        <i class="material-icons {$teiid}">&#xe56b;</i>
                                    </a>
                                    <span>Filtri</span>
                                    <button class="btn-hand">HandWriting</button>
                                    <button class="btn-typo">Typographic</button> 
                                    <button class="btn-stmp">Stamps</button>
                                    <button class="btn-clr">Clear</button>
                                </div>
                                <div class="sez2">
                                    <a href="static/{$teiid}/fronte.jpg" target="_blank">
                                        <i class="material-icons {$teiid}">&#xe56b;</i>
                                    </a>        
                                </div>
                                <div class="sez3">
                                    <h3>Info Francobolli, Timbri e Illutrazione</h3>
                                </div>
                            </div>
                            
                            <xsl:apply-templates select="tei:facsimile"/>
                            <!-- <div class="toolbar" /> -->
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
                                    <xsl:value-of select="normalize-space(tei:text//tei:div[@type='add'])"/>
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
                                        <span class="label">Testo tipografico sul retro:</span>
                                    </p>
                                </xsl:if>
                                <xsl:for-each select=".//tei:front//tei:s">
                                    <p class="tipografia">
                                        >
                                        <xsl:for-each select="text()|*">
                                            <xsl:choose>
                                                <xsl:when test="self::tei:choice">
                                                    <xsl:value-of select="tei:abbr"/>
                                                </xsl:when>
                                                <xsl:when test="self::text()|self::*">
                                                    <xsl:value-of select="."/>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:for-each>
                                    </p>
                                </xsl:for-each>
                                <xsl:if test=".//tei:div[@type='recto']/tei:figure//tei:figDesc/tei:mentioned">
                                    <p class="tipografia">
                                        <span class="label">Testo tipografico sul fronte:</span>
                                        <xsl:value-of select=".//tei:div[@type='recto']/tei:figure//tei:figDesc/tei:mentioned"/>
                                    </p>
                                </xsl:if>
                            </div>
                        </div>
                    </section>
                </xsl:for-each>
                <footer class="footerStyle">
                    <xsl:if test="tei:teiHeader[@xml:id='corpusHeader']">
                        <div id="publication_info" class="info_list">
                            <h3>Informazioni di pubblicazione e distribuzione:</h3>
                            <xsl:apply-templates select="tei:teiHeader[@xml:id='corpusHeader']//tei:publicationStmt"/>
                        </div>
                        <div class="vl"></div>
                        <div id="edition_info" class="info_list">
                            <h3>Responsabili di edizione:</h3>
                            <xsl:if test="tei:teiHeader[@xml:id='corpusHeader']//tei:editionStmt//tei:respStmt[position() > 1]">
                                <xsl:apply-templates select="tei:teiHeader[@xml:id='corpusHeader']//tei:editionStmt//tei:respStmt" />
                            </xsl:if>
                        </div>
                        <div class="vl"></div>
                        
                        <div id="title_info" class="info_list">
                            <h3>Responsabili     di codifica:</h3>
                            <xsl:apply-templates select="tei:teiHeader[@xml:id='corpusHeader']//tei:persName[@type='person']"/>
                        </div>
                    </xsl:if>
                </footer>
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
            <a href="#{$id}">
                <div class="selection" style="background-image: url('./static/{$id}/fronte.jpg')"></div>
                <h4 class="col3">
                    <xsl:value-of select="./tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
                </h4>
            </a>
        </div>
    </xsl:template>

    <!-- ******  POSTMARK ****** -->
    <xsl:template match="tei:teiHeader//tei:support/tei:stamp[@type='postmark']">
        <xsl:variable name="postid" select="count(preceding::tei:stamp)+1"/>
        <xsl:variable name="postclass" select="@n"/>
        <div class="tt_postmark">
            <p class="desc {$postclass}" id="postmark{$postid}">
                <xsl:value-of select="."/>
            </p>
        </div>
    </xsl:template>

    <!-- ******  POSTAGE ****** -->
    <xsl:template match="tei:teiHeader//tei:support/tei:stamp[@type='postage']">
        <xsl:variable name="postageid" select="count(preceding::tei:stamp)+1"/>
        <xsl:variable name="postageclass" select="@n"/>
        <div class="tt_postage">
         <p class="desc {$postageclass}" id="postage{$postageid}">
                <xsl:value-of select="."/>
            </p>
        </div>
    </xsl:template>

    <!-- FIGDESC -->
    <xsl:template match="tei:text//tei:div[@type='recto']/tei:figure//tei:figDesc">
        <xsl:variable name="figdescid" select="count(preceding::tei:figDesc)+1"/>
        <div class="tt_figdesc">
            <p class="desc fronte{$figdescid}">
             <span class="label">Descrizione dell'immagine:</span>            
             <xsl:value-of select="."/>
            </p>
        </div>
    </xsl:template>

    <!-- ******  HEADER ****** -->
    <!-- ****** DIV FACSIMILIE ****** -->
    <xsl:template match="tei:facsimile">
        <xsl:variable name="id" select="../@xml:id"/>
        <xsl:variable name="width" select="substring-before(tei:surface/tei:graphic/@width, 'px')"/>
        <xsl:variable name="height" select="substring-before(tei:surface/tei:graphic/@height, 'px')"/>

        <div class="overlayWrapper">
            <img class="scan retro" src="./static/{$id}/retro.jpg" title="{$id}" />
            <svg width="550.33" height="360.33" viewBox="0 0 {$width} {$height}" class="overlayPath">
                <xsl:for-each select="tei:surface[1]/tei:zone">
                <xsl:variable name="zonetype" select="@type"/>
                <xsl:variable name="zoneID" select="@xml:id"/>
                    <xsl:choose>
                        <xsl:when test="@points">
                            <xsl:variable name="points" select="@points"/>
                            <polygon points="{$points}" class="{$zonetype}" id="{$zoneID}" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:variable name="pointx" select="@ulx"/>
                            <xsl:variable name="pointy" select="@uly"/>
                            <xsl:variable name="widthr" select="@lrx - @ulx"/>
                            <xsl:variable name="heightr" select="@lry - @uly"/>
                            <rect x="{$pointx}" y="{$pointy}" height="{$heightr}" width="{$widthr}" class="{$zonetype}" id="{$zoneID}"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </svg>
        </div>
        <div class="fronteWrapper">
            <xsl:variable name="figdescid" select="count(preceding::tei:figDesc)+1"/>
            <img class="fronte" src="./static/{$id}/fronte.jpg" title="{$id}" id="fronte{$figdescid}"/>
            <div class="content_tooltip">
                <xsl:apply-templates select="../tei:teiHeader//tei:support/tei:stamp[@type='postmark']" />
                <xsl:apply-templates select="../tei:teiHeader//tei:support/tei:stamp[@type='postage']" />
                <xsl:apply-templates select="../tei:text//tei:div[@type='recto']/tei:figure//tei:figDesc" />
            </div>
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
            <xsl:value-of select="./following-sibling::tei:unclear"/>
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

    <!-- FOOTER
    <xsl:template match="tei:editionStmt">
        <xsl:value-of select="tei:respStmt[tei:resp[not(contains(., 'Codificato da'))]]"/>        
    </xsl:template> -->
    <xsl:template match="tei:teiHeader[@xml:id='corpusHeader']//tei:publicationStmt">
        <div class="section_footer">
            <i class="material-icons">account_balance</i>
            <p id="location_unipi" class="location">
                <span id="abbr" class="span_info">
                    <xsl:value-of select="tei:publisher//tei:abbr"/> -
                </span>
                <span id="expan" class="span_info">
                    <xsl:value-of select="tei:publisher//tei:expan"/>
                </span>
            </p>
        </div>
        <div class="section_footer">
            <i class="material-icons">edit_location</i>
            <p id="location_labcd" class="location">
                <span id="abbr" class="span_info">
                    <xsl:value-of select="tei:distributor//tei:abbr"/> - 
                </span>
                <span id="expan" class="span_info">
                    <xsl:value-of select="tei:distributor//tei:expan"/>
                </span>
            </p>
        </div>
    </xsl:template>
    <xsl:template match="tei:teiHeader[@xml:id='corpusHeader']//tei:editionStmt//tei:respStmt[not(contains(tei:resp, 'Codificato da:'))]">     
        <div class="section_footer">
            <p>
                <i class="material-icons">assignment</i>
                <span class="pers_role span_info">
                    <xsl:value-of select="tei:resp"/>:
                </span>
                <xsl:for-each select="tei:persName">
                    <span class="pers_name span_info">
                        <xsl:value-of select="."/>
                    </span>
                </xsl:for-each>
            </p> 
        </div>
    </xsl:template>

    <xsl:template match="tei:teiHeader[@xml:id='corpusHeader']//tei:persName[@type='person']">
        <div class="section_footer">
            <i class="material-icons">person</i>
            <p>
                <xsl:for-each select=".">
                    <span class="pers_name span_info">
                        <xsl:value-of select="."/>
                    </span>
                </xsl:for-each>
            </p>
        </div>
        
    </xsl:template>

    <xsl:template match="text()|@*"></xsl:template>
</xsl:stylesheet>