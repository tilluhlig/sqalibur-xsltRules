<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>

    <!-- Doppelnegationsgesetz (not darf nur ein Kind besitzen) -->
    <xsl:template match="node[@label = 'not' and child::node[@label='not']]">
        <xsl:variable name="result">
            <xsl:comment> Regel: not not => not </xsl:comment>
            <xsl:apply-templates select="./node/child::node()|@*"/>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
</xsl:stylesheet>