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
    <!--<xsl:comment> Regel: a or (b and c) => (a or b) and (a or c) </xsl:comment>-->
            
    <xsl:template match="node[@label='or' and count(child::node) = 2 and child::node[@label='and']]">
        <xsl:variable name="result">
            <!--<xsl:copy-of select="node|@*">-->
            <!--<node label="or">-->
            <xsl:variable name="partA" select="child::node[1]" />
            <!-- ich muss den Teil mit dem AND in alle Teile auspalten (also mit foreach)) -->

            <!--<xsl:apply-templates select="node()|@*"/>-->
            <xsl:copy><xsl:apply-templates select="@*"/> <!-- ??? -->
                <node label="and" class="binop">
                    <xsl:for-each select="./child::node[2]/child::*">
                        <node label="or" class="binop">
                            <xsl:copy-of select="$partA">
                                <xsl:apply-templates select="ext:node-set($partA)|@*"/>
                            </xsl:copy-of>
                            <xsl:copy>
                                <xsl:apply-templates select="node()|@*"/>
                            </xsl:copy>
                        </node>
                    </xsl:for-each>
                </node>
            </xsl:copy>
            <!--</xsl:copy-of>-->
            <!--</node>-->
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
    
    
    <!-- and/or mit nur einem Element -->
    <xsl:variable name="valEntfernen">
        <param par="or"/>
        <param par="and"/>
    </xsl:variable>
    <xsl:template match="node[@label = ext:node-set($valEntfernen)/*/@par and count(child::node) = 1]">
        <xsl:variable name="type" select="@label"/>
        <xsl:variable name="result">
            <xsl:comment> Regel: <xsl:value-of select="$type"/> wird entfernt </xsl:comment>
            <xsl:apply-templates select="child::node()|@*"/>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>

    <!-- wenn keine Regel passt, wird einfach nur kopiert -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
