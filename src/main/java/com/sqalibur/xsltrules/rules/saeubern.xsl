<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>   

    <!-- ein Element das mindestens 2 Kinder haben muss aber nur eines besitzt
         wird entfernt -->
    <xsl:variable name="valEntfernen">
        <param par="or"/>
        <param par="and"/>
    </xsl:variable>
    <xsl:template match="node[@label = ext:node-set($valEntfernen)/*/@par and count(child::node) = 1]">
        <xsl:variable name="type" select="@label"/>
        <!--<xsl:comment> Regel: <xsl:value-of select="$type"/> wird entfernt </xsl:comment>-->
        <xsl:variable name="result">
            <xsl:apply-templates select="child::node()"/>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
</xsl:stylesheet>