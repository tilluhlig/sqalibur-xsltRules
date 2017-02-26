<!-- De Morgang not/(and|or) (not darf nur ein Kind besitzen) -->
<xsl:variable name="valDeMorgan">
    <param par="OrExpression">0</param>
    <param par="AndExpression">1</param>
</xsl:variable>
<xsl:template match="node[@class = 'notExpression' and child::node[@class=ext:node-set($valDeMorgan)/*/@par]]">
    <xsl:variable name="type" select="./child::node/@class"/>
    <xsl:variable name="pos" select="ext:node-set($valDeMorgan)/param[@par = $type]/text()"/>
    <xsl:variable name="type2" select="ext:node-set($valDeMorgan)/param[text() = 1-$pos]/@par"/>
    <!--<xsl:comment> Regel: not (a <xsl:value-of select="$type"/> b) => (not a <xsl:value-of select="$type2"/> not b) </xsl:comment>-->
            
    <xsl:variable name="result">
        <node class="{$type2}">
            <xsl:for-each select="./node/child::*">
                <node class="notExpression">
                    <xsl:copy>
                        <xsl:apply-templates select="node()|@*"/>
                    </xsl:copy>
                </node>
            </xsl:for-each>
        </node>
    </xsl:variable>
        
    <xsl:apply-templates select="ext:node-set($result)"/>
</xsl:template>