<!-- Distributivgesetz or/and -->
<!-- TODO: or kann auch mehr Kinder haben -->
<!-- >> dann immer ein kind von 'or' mit dem and umwandeln -->
<xsl:template match="node[@label='or' and count(./child::*) = 2 and child::node[@label='and']]">
    <!--<xsl:comment> Regel: a or (b and c) => (a or b) and (a or c) </xsl:comment>-->
    <xsl:variable name="partA" select="child::node[1]"/>
    <xsl:variable name="result">
        <xsl:copy>
            <xsl:apply-templates select="@*"/> <!-- ??? -->
            <node label="and" class="binop">
                <xsl:for-each select="./child::node[2]/child::*">
                    <node label="or" class="binop">
                        <xsl:copy-of select="$partA">
                            <xsl:apply-templates select="ext:node-set($partA)"/>
                        </xsl:copy-of>
                        <xsl:copy>
                            <xsl:apply-templates select="node()|@*"/>
                        </xsl:copy>
                    </node>
                </xsl:for-each>
            </node>
        </xsl:copy>
    </xsl:variable>
    <xsl:apply-templates select="ext:node-set($result)"/>
</xsl:template>