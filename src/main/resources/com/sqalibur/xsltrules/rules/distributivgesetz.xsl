<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (C) 2017 Till Uhlig <till.uhlig@student.uni-halle.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext" version="1.0">
    <xsl:output method="xml"/>   

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
</xsl:stylesheet>