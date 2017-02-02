<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>
    <xsl:strip-space elements="*"/><!-- alternative: node -->
        
    <xsl:template match="root">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <xsl:include href="rules/deMorgan.xsl"/>
    <xsl:include href="rules/doppelnegation.xsl"/>
    <xsl:include href="rules/glaetten.xsl"/>
    <xsl:include href="rules/saeubern.xsl"/>
    <xsl:include href="rules/distributivgesetz.xsl"/>

    <!-- wenn keine Regel passt, dann wird einfach nur kopiert -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
