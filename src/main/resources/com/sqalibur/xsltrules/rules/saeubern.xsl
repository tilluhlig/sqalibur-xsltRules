<!-- ein Element das mindestens 2 Kinder haben muss aber nur eines besitzt
wird entfernt -->
<xsl:variable name="valEntfernen">
    <param par="OR"/>
    <param par="AND"/>
</xsl:variable>
<xsl:template match="node[@label = ext:node-set($valEntfernen)/*/@par and count(child::node) = 1]">
    <xsl:variable name="type" select="@label"/>
    <!--<xsl:comment> Regel: <xsl:value-of select="$type"/> wird entfernt </xsl:comment>-->
    <xsl:variable name="result">
        <xsl:apply-templates select="child::node()"/>
    </xsl:variable>
    <xsl:apply-templates select="ext:node-set($result)"/>
</xsl:template>