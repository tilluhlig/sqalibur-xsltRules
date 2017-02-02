<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>

    <!-- Glättten von 'or/or' und 'and/and' -->
    <xsl:variable name="valGlaetten">
        <param par="or"/>
        <param par="and"/>
    </xsl:variable>
    <xsl:template match="node[@label = ext:node-set($valGlaetten)/*/@par and child::node[@label=../@label]]">
        <xsl:variable name="type" select="@label"/>
        <!--<xsl:comment> Regel: <xsl:value-of select="$type"/> + <xsl:value-of select="$type"/> => <xsl:value-of select="$type"/> </xsl:comment>-->
        <xsl:variable name="result">
            <xsl:copy>
                <xsl:for-each select="./child::node()|@*"><!-- hier können 'or' bzw. 'and' dabei sein -->
                    <xsl:choose>  
                        <xsl:when test="@label=$type"> 
                            <xsl:apply-templates select="./child::node()|@*"/>
                        </xsl:when> 
                        <xsl:otherwise>
                            <xsl:copy>
                                <xsl:apply-templates select="./node()|@*"/>
                            </xsl:copy>
                        </xsl:otherwise>
                    </xsl:choose>  
                </xsl:for-each>
            </xsl:copy>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
</xsl:stylesheet>