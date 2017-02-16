<!-- De Morgang not/(and|or) (not darf nur ein Kind besitzen) -->
<xsl:variable name="valDeMorgan">
    <param par="or">0</param>
    <param par="and">1</param>
</xsl:variable>
<xsl:template match="node[@label = 'not' and child::node[@label=ext:node-set($valDeMorgan)/*/@par]]">
    <xsl:variable name="type" select="./child::node/@label"/>
    <xsl:variable name="pos" select="ext:node-set($valDeMorgan)/param[@par = $type]/text()"/>
    <xsl:variable name="type2" select="ext:node-set($valDeMorgan)/param[text() = 1-$pos]/@par"/>
    <!--<xsl:comment> Regel: not (a <xsl:value-of select="$type"/> b) => (not a <xsl:value-of select="$type2"/> not b) </xsl:comment>-->
            
    <xsl:variable name="result">
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