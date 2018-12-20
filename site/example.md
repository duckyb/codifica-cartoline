# XSL Template

```xml
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="span">
    <xsl:for-each select="lb">
		<p>
            <xsl:choose>
                <xsl:when test="(following-sibling::text())">
                    <xsl:value-of select="(following-sibling::text()|following-sibling::name)[1]"></xsl:value-of>
                </xsl:when>
                <xsl:when test="following-sibling::name[2]">
                    <xsl:value-of select="following-sibling::name[1]"></xsl:value-of>
                    <xsl:value-of select="following-sibling::name[2]"></xsl:value-of>
                </xsl:when>
            </xsl:choose>
		</p>
	</xsl:for-each>
</xsl:template>

</xsl:stylesheet>
```

# SOURCE XML

```xml
<span>
  <lb/>
  Your Friend
  <lb/>
  <name> Mickey Mouse </name>
  <name> Donald Duck </name>
</span>
```

# OUTPUT

```html
<?xml version="1.0" encoding="UTF-8"?>
<p>Your Friend</p>
<p>Mickey Mouse Donald Duck</p>
```
