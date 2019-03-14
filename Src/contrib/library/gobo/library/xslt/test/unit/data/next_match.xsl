<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

<!-- Test for mode="#all" with next-match (XSLT 2.0) -->

<xsl:template match="doc">
  <out>
    <m1><xsl:apply-templates select="*" mode="m1"/></m1>
    <m2><xsl:apply-templates select="*" mode="m2"/></m2>    
  </out>
</xsl:template>

<xsl:template match="b" mode="#all" priority="3">
  <b mode="#all"/>
  <xsl:next-match/>
</xsl:template>

<xsl:template match="a" mode="m1">
  <a mode="m1"/>
</xsl:template>

<xsl:template match="a" mode="m2">
  <a mode="m2"/>
</xsl:template>

<xsl:template match="b" mode="m1" priority="2">
  <b mode="m1"/>
</xsl:template>

<xsl:template match="b" mode="m2" priority="2">
  <b mode="m2"/>
</xsl:template>


</xsl:stylesheet>
