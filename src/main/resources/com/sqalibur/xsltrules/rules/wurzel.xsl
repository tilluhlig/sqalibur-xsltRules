<!-- kopiert den Wurzelknoten -->
<xsl:template match="root">
    <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
</xsl:template>