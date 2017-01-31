<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>
    
    <xsl:import href=""/>
    
    <xsl:template match="root">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- De Morgang not/(and|or) (not darf nur ein Kind besitzen) -->
    <xsl:variable name="valDeMorgan">
        <param par="or">0</param>
        <param par="and">1</param>
    </xsl:variable>
    <xsl:template match="node[@label = 'not' and child::node[@label=ext:node-set($valDeMorgan)/*/@par]]">
        <xsl:variable name="type" select="./child::node/@label"/>
        <xsl:variable name="pos" select="ext:node-set($valDeMorgan)/param[@par = $type]/text()"/>
        <xsl:variable name="type2" select="ext:node-set($valDeMorgan)/param[text() = 1-$pos]/@par"/>
            
        <xsl:variable name="result">
            <xsl:comment> Regel: not (a <xsl:value-of select="$type"/> b) => (not a <xsl:value-of select="$type2"/> not b) </xsl:comment>
            <node label="{$type2}" class="binop">
                <xsl:for-each select="./node/child::*">
                    <node label="not" class="unop">
                        <xsl:copy>
                            <xsl:apply-templates select="node()|@*"/>
                        </xsl:copy>
                    </node>
                </xsl:for-each>
            </node>
        </xsl:variable>
        
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
    
    <!-- Doppelnegationsgesetz (not darf nur ein Kind besitzen) -->
    <xsl:template match="node[@label = 'not' and child::node[@label='not']]">
        <xsl:variable name="result">
            <xsl:comment> Regel: not not => not </xsl:comment>
            <xsl:apply-templates select="./node/child::node()|@*"/>
        </xsl:variable>
        <xsl:apply-templates select="ext:node-set($result)"/>
    </xsl:template>
        
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
    
    <!-- Glättten von 'or/or' und 'and/and' -->
    <xsl:variable name="valGlaetten">
        <param par="or"/>
        <param par="and"/>
    </xsl:variable>
    <xsl:template match="node[@label = ext:node-set($valGlaetten)/*/@par and child::node[@label=../@label]]">
        <xsl:variable name="type" select="@label"/>
        <xsl:comment> Regel: <xsl:value-of select="$type"/> + <xsl:value-of select="$type"/> => <xsl:value-of select="$type"/> </xsl:comment>
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

    <!-- wenn keine Regel passt, wird einfach nur kopiert -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
