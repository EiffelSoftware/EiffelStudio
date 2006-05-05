<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:cf="http://www.eiffel.com/developers/xml/configuration-1-0-0"
	xmlns="http://www.eiffel.com/developers/xml/configuration-1-0-0"
>

<!-- specify encoding of output -->
<xsl:output encoding="ISO-8859-1"/>

<!-- various fixes to eweasel configuration files -->

<!-- add base library if precompile of it is used -->
<xsl:template match="//cf:precompile">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="@*|*|text()"/>
	</xsl:element>
	<xsl:if test="not (//cf:library)">
<xsl:text>
		</xsl:text>
	<xsl:element name="library">
		<xsl:attribute name="name">base</xsl:attribute>
		<xsl:attribute name="location">$ISE_LIBRARY\library\base\base.acex</xsl:attribute>
	</xsl:element>
	</xsl:if>
</xsl:template>

<!-- enable warnings, disable syntax warnings -->
<xsl:template match="//cf:option">
	<xsl:element name="{local-name()}">
		<xsl:if test="not(@warning)">
			<xsl:attribute name="warning">true</xsl:attribute>
		</xsl:if>
		<xsl:apply-templates select="@*|*|text()"/>
		<xsl:if test="not(warning)">
			<xsl:element name="warning">
				<xsl:attribute name="name">syntax</xsl:attribute>
				<xsl:attribute name="enabled">false</xsl:attribute>
			</xsl:element>
		</xsl:if>
	</xsl:element>
</xsl:template>

<!-- match every normal node and change the namespace to the new namespace -->
<xsl:template match="*">
	<xsl:element name="{local-name()}">
		<xsl:apply-templates select="@*|*|text()"/>
	</xsl:element>
</xsl:template>

<!-- update schema location -->
<xsl:template match="@xsi:schemaLocation">
	<xsl:attribute name="xsi:schemaLocation">http://www.eiffel.com/developers/xml/configuration-1-0-0 http://www.eiffel.com/developers/xml/configuration-1-0-0.xsd</xsl:attribute>
</xsl:template>		
	
<!-- copy attributes as is -->
<xsl:template match="@*">
	<xsl:copy/>
</xsl:template>		

</xsl:stylesheet>
