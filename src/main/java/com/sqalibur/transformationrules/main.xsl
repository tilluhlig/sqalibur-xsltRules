<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>
        
    <xsl:template match="root">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:include href="deMorgan.xsl"/>
    <xsl:include href="doppelnegation.xsl"/>
    <xsl:include href="glaetten.xsl"/>
        
    <!-- Distributivgesetz or/and -->
    <!--<xsl:template match="node[@label='or' and child::node[@label='and']]">
        <node label="and" class="binop">
            <xsl:comment> Regel: a or (b and c) => (a or b) and (a or c) </xsl:comment>
            <xsl:for-each select="./node/child::*">
                <node label="not" class="unop">
                    <xsl:copy>
                        <xsl:apply-templates select="node()|@*"/>
                    </xsl:copy>
                </node>
            </xsl:for-each>
            <xsl:copy>
                <xsl:apply-templates select="node()|@*"/>
            </xsl:copy>
        </node>
    </xsl:template>-->

    <!-- wenn keine Regel passt, wird einfach nur kopiert -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
