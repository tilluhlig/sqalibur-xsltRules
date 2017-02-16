<!-- Doppelnegationsgesetz (not darf nur ein Kind besitzen) -->
<xsl:template match="node[@label = 'not' and child::node[@label='not']]">
    <!--<xsl:comment> Regel: not not => not </xsl:comment>-->
        
    <xsl:variable name="result">
        <xsl:apply-templates select="./node/child::node()"/>
    </xsl:variable>
    <xsl:apply-templates select="ext:node-set($result)"/>
</xsl:template>