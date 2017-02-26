<!-- ein Element das mindestens 2 Kinder haben muss aber nur eines besitzt
wird entfernt -->
<xsl:variable name="valEntfernen">
    <param par="OrExpression"/>
    <param par="AndExpression"/>
    <param par="Addition"/>
    <param par="Concat"/>
    <param par="Multiplication"/>
    <param par="Division"/>
    <param par="Subtraction"/>
    <param par="BitwiseAnd"/>
    <param par="BitwiseOr"/>
    <param par="BitwiseXor"/>
    <param par="LikeExpression"/>
    <param par="EqualsTo"/>
    <param par="GreaterThan"/>
    <param par="GreaterThanEquals"/>
    <param par="MinorThan"/>
    <param par="MinorThanEquals"/>
    <param par="NotEqualsTo"/>
</xsl:variable>
<xsl:template match="node[@class = ext:node-set($valEntfernen)/*/@par and count(child::node) = 1]">
    <xsl:variable name="type" select="@label"/>
    <!--<xsl:comment> Regel: <xsl:value-of select="$type"/> wird entfernt </xsl:comment>-->
    <xsl:variable name="result">
        <xsl:apply-templates select="child::node()"/>
    </xsl:variable>
    <xsl:apply-templates select="ext:node-set($result)"/>
</xsl:template>