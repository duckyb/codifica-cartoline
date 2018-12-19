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
                  </div>
                  </section>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

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
    
    <xsl:template match="tei:facsimile">
      <xsl:variable name="id" select="../@xml:id"/>
      <img class="retro" src="../{$id}/retro.jpg" title="{$id}" />
    </xsl:template>

  <!-- raggiungo un nodo | foglia testo -->
  <xsl:template match="text()|@*"></xsl:template>
<!-- end -->
</xsl:stylesheet>