<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

<!--************************ARGUMENT PARAMETERS**********************-->
<xsl:param name="stylesheet"/>
	<xsl:template name="document_stylesheet">
			<xsl:param name="stylesheet" />
			<xsl:if test="string-length($stylesheet)&gt;0">
				<link>
					<xsl:attribute name="rel">stylesheet</xsl:attribute>
					<xsl:attribute name="href"><xsl:value-of select="$stylesheet"/></xsl:attribute>
					<xsl:attribute name="charset">ISO-8859-1</xsl:attribute>
					<xsl:attribute name="type">text/css</xsl:attribute>
				</link>
			</xsl:if>
			<xsl:if test="string-length($stylesheet)=0">
				 <link rel="stylesheet" type="text/css" href="c_code.css"/>			
			</xsl:if>
	</xsl:template>
	<xsl:template match="/doc">
			<xsl:variable name="stylesheet" select="@css"/>
			<xsl:variable name="name" select="@name"/>
		<html>
			<head>
				<xsl:call-template name="document_stylesheet">
					<xsl:with-param name="stylesheet"><xsl:value-of select="$stylesheet"/></xsl:with-param>
				</xsl:call-template>
				<title>Runtime - C code</title>
			</head>
			<body>
				<xsl:if test="$name">
					<h1>
						<xsl:value-of select="$name"/>
					</h1>
				</xsl:if>
				<xsl:apply-templates/>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="file">
		<xsl:variable name="type" select="@name"/>		
			<br/>
			<h2>
				<xsl:value-of select="@name"/>, 
				<xsl:value-of select="@header"/>
			</h2>
			<xsl:variable name="fix" select="fixme"/>
				<table border="1">
					<tr>
						<th>Name</th>
						<th>Return Type</th>
						<th>Summary</th>
						<th>Export</th>
						<th>Thread Safety</th>
						<th>Synchronization</th>
						<th>Eiffel Classes</th>
						<th>Fix Needed</th>
					</tr>
					<xsl:apply-templates/>
				</table>
	</xsl:template>
	<xsl:template match="attribute">
			<xsl:variable name="fix" select="fixme"/>
			<xsl:choose>
				<xsl:when test="name($fix)">
					<tr bgcolor="#FFECDD">
						<td>
							<xsl:value-of select="@name"/>
						</td>
						<td>
							<xsl:value-of select="@return_type"/>
						</td>
						<td>
							<xsl:value-of select="summary"/>
						</td>
						<td>
							<xsl:value-of select="@export"/>
						</td>
						<td>
							<xsl:value-of select="thread_safety"/>
						</td>
						<td>
							<xsl:value-of select="synchronization"/>
						</td>
						<td>
							<xsl:value-of select="eiffel_classes"/>
						</td>
						<td>
							<xsl:value-of select="fixme"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td>
							<xsl:value-of select="@name"/>
						</td>
						<td>
							<xsl:value-of select="@return_type"/>
						</td>
						<td>
							<xsl:value-of select="summary"/>
						</td>
						<td>
							<xsl:value-of select="@export"/>
						</td>
						<td>
							<xsl:value-of select="thread_safety"/>
						</td>
						<td>
							<xsl:value-of select="synchronization"/>
						</td>
						<td>
							<xsl:value-of select="eiffel_classes"/>
						</td>
						<td>
							<xsl:value-of select="fixme"/>
						</td>
					</tr>

				</xsl:otherwise>
			</xsl:choose>
			
	</xsl:template>

	<xsl:template match="routine">
			<xsl:variable name="fix" select="fixme"/>
			<xsl:choose>
				<xsl:when test="name($fix)">
					<tr bgcolor="#FFECDD">
						<td>
							<xsl:value-of select="@name"/>
						</td>
						<td>
							<xsl:value-of select="@return_type"/>
						</td>
						<td>
							<xsl:value-of select="summary"/>
						</td>
						<td>
							<xsl:value-of select="@export"/>
						</td>
						<td>
							<xsl:value-of select="thread_safety"/>
						</td>
						<td>
							<xsl:value-of select="synchronization"/>
						</td>
						<td>
							<xsl:value-of select="eiffel_classes"/>
						</td>
						<td>
							<xsl:value-of select="fixme"/>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td>
							<xsl:value-of select="@name"/>
						</td>
						<td>
							<xsl:value-of select="@return_type"/>
						</td>
						<td>
							<xsl:value-of select="summary"/>
						</td>
						<td>
							<xsl:value-of select="@export"/>
						</td>
						<td>
							<xsl:value-of select="thread_safety"/>
						</td>
						<td>
							<xsl:value-of select="synchronization"/>
						</td>
						<td>
							<xsl:value-of select="eiffel_classes"/>
						</td>
						<td>
							<xsl:value-of select="fixme"/>
						</td>
					</tr>

				</xsl:otherwise>
			</xsl:choose>
			
	</xsl:template>

	<xsl:template match="@name">
		hello
	</xsl:template>
	<xsl:template match="*">
		<xsl:apply-templates/>
	</xsl:template>
</xsl:stylesheet>
