<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:cf="http://www.eiffel.com/developers/xml/configuration-1-0-0"
	xmlns="http://www.eiffel.com/developers/xml/configuration-1-0-0"
>

<!-- 
	Convert from old to improved condition statements. Versionnumber was not changed.

-->

<!-- specify encoding of output -->
<xsl:output encoding="ISO-8859-1"/>

<!-- convert if and ifnot nodes into new condition nodes -->
<xsl:template match="//cf:if">
	<xsl:element name="condition">
		<xsl:if test="@platform">
		<xsl:element name="platform">
			<xsl:attribute name="value">
				<xsl:value-of select="@platform"/>
			</xsl:attribute>
		</xsl:element>
		</xsl:if>
		<xsl:if test="@build">
		<xsl:element name="build">
			<xsl:attribute name="value">
				<xsl:value-of select="@build"/>
			</xsl:attribute>
		</xsl:element>
		</xsl:if>
	</xsl:element>
</xsl:template>
<xsl:template match="//cf:ifnot">
	<xsl:element name="condition">
		<xsl:if test="@platform">
		<xsl:element name="platform">
			<xsl:attribute name="excluded_value">
				<xsl:value-of select="@platform"/>
			</xsl:attribute>
		</xsl:element>
		</xsl:if>
		<xsl:if test="@build">
		<xsl:element name="build">
			<xsl:attribute name="excluded_value">
				<xsl:value-of select="@build"/>
			</xsl:attribute>
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