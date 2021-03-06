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
    <xsl:strip-space elements="*"/><!-- alternative: node -->

    <xsl:include href="rules/wurzel.xsl"/>
    <xsl:include href="rules/deMorgan.xsl"/>
    <xsl:include href="rules/doppelnegation.xsl"/>
    <xsl:include href="rules/glaetten.xsl"/>
    <xsl:include href="rules/saeubern.xsl"/>
    <xsl:include href="rules/distributivgesetz.xsl"/>
    <xsl:include href="rules/kopieren.xsl"/>
</xsl:stylesheet>
