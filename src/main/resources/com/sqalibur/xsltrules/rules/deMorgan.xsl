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
</xsl:stylesheet>