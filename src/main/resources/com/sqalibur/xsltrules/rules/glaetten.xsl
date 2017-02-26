<!-- Glättten von 'or/or' und 'and/and' -->
<xsl:variable name="valGlaetten">
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
<xsl:template match="node[@class = ext:node-set($valGlaetten)/*/@par and child::node[@class=../@class]]">
    <xsl:variable name="type" select="@class"/>
    <!--<xsl:comment> Regel: <xsl:value-of select="$type"/> + <xsl:value-of select="$type"/> => <xsl:value-of select="$type"/> </xsl:comment>-->
    <xsl:variable name="result">
        <xsl:copy>
            <xsl:for-each select="./child::node()|@*"><!-- hier können 'or' bzw. 'and' dabei sein -->
                <xsl:choose>  
                    <xsl:when test="@class=$type"> 
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