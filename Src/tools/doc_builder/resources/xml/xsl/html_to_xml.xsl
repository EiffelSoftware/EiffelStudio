<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:MSHelp="http://msdn.microsoft.com/mshelp">

	<!--************************TEMPLATES**********************-->
	
	<!-- Simple one-to-one mappings -->
	<xsl:template match="/html">
		<document>			
			<xsl:apply-templates/>
		</document>
	</xsl:template>
	<xsl:template match="/html/body">
		<paragraph>		
			<xsl:apply-templates/>					
		</paragraph>
	</xsl:template>
	<xsl:template match="/head">
		<help>
			<xsl:apply-templates/>
		</help>
	</xsl:template>
	<xsl:template match="p">
		<paragraph>
			<xsl:apply-templates/>
		</paragraph>
	</xsl:template>
	<xsl:template match="table">
		<table>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	<xsl:template match="tr">
		<row>
			<xsl:apply-templates/>
		</row>
	</xsl:template>
	<xsl:template match="td">
		<cell>
			<xsl:apply-templates/>
		</cell>
	</xsl:template>
	<xsl:template match="li">
		<item>
			<xsl:apply-templates/>
		</item>
	</xsl:template>
	<xsl:template match="div">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="span">
		<span>
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="pre">
		<code_block>
			<xsl:apply-templates/>
		</code_block>
	</xsl:template>
	<xsl:template match="b">
		<bold>
			<xsl:apply-templates/>
		</bold>
	</xsl:template>
	<xsl:template match="i">
		<italic>
			<xsl:apply-templates/>
		</italic>
	</xsl:template>
	<xsl:template match="br">
		<line_break/>
	</xsl:template>
	

	<!-- Output element tags -->
	<xsl:template match="output">
		<xsl:apply-templates select="." mode="output"/>
	</xsl:template>
	<!-- Template for schema block tags -->
	<xsl:template match="warning | tip | seealso | sample | note | info">
		<xsl:call-template name="par_element_to_attribute">
			<xsl:with-param name="element">
				<xsl:value-of select="."/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- META elements -->
	<xsl:template match="meta">
		<xsl:element name="meta" use-attribute-sets="MetaAttributes"/>
	</xsl:template>
	<!-- Labels -->
	<xsl:template name="label">
		<xsl:apply-templates/>
	</xsl:template>
	<!-- Complex elements -->
	<xsl:template match="link | image | image_map | area | help_link | string | class_name | image_link">
		<xsl:choose>
			<xsl:when test="name()='image_link'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name">a</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name()='link'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name">a</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:value-of select="./label"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name()='image'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name">img</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name()='image_map'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name">map</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name()='area'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name">area</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="name()='help_link'">
				<xsl:call-template name="process_element">
					<xsl:with-param name="name"><![CDATA[MSHelp:link]]></xsl:with-param>
					<xsl:with-param name="content">
						<xsl:value-of select="./text()"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Elements which should be attributes in HTML representation -->
	<xsl:template match=" string | number | character | keyword | reserved_word | comment | local_variable |
	local_variable_quoted | symbol | generics | contract_tag | indexing_tag | keyword | syntax">
		<xsl:call-template name="code_element_to_attribute">
			<xsl:with-param name="value">
				<xsl:value-of select="name()"/>
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:value-of select="./text()"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- Complex elements which should be attributes in HTML representation -->
	<xsl:template match="class_name | cluster_name | feature_name">
		<xsl:choose>
			<xsl:when test="name(label)">
				<xsl:call-template name="code_element_to_attribute">
					<xsl:with-param name="value">
						<xsl:value-of select="name()"/>
					</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:value-of select="./label"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="not(name(label))">
				<xsl:call-template name="code_element_to_attribute">
					<xsl:with-param name="value">
						<xsl:value-of select="name()"/>
					</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:value-of select="./text()"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Lists -->
	<xsl:template match="list">
		<xsl:variable name="type" select="@ordered"/>
		<xsl:choose>
			<xsl:when test="$type='true'">
				<ol>
					<xsl:apply-templates/>
				</ol>
			</xsl:when>
			<xsl:when test="$type='false'">
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="heading/size">
	</xsl:template>
	<!-- Headings -->
	<xsl:template match="heading">
		<xsl:variable name="h_size" select="size"/>
		<xsl:choose>
			<xsl:when test="number($h_size)=1">
				<h1>
					<xsl:apply-templates/>
				</h1>
			</xsl:when>
			<xsl:when test="number($h_size)=2">
				<h2>
					<xsl:apply-templates/>
				</h2>
			</xsl:when>
			<xsl:when test="number($h_size)=3">
				<h3>
					<xsl:apply-templates/>
				</h3>
			</xsl:when>
			<xsl:when test="number($h_size)=4">
				<h4>
					<xsl:apply-templates/>
				</h4>
			</xsl:when>
			<xsl:when test="number($h_size)=5">
				<h5>
					<xsl:apply-templates/>
				</h5>
			</xsl:when>
			<xsl:when test="number($h_size)=6">
				<h6>
					<xsl:apply-templates/>
				</h6>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!--************************ATTRIBUTE SETS**********************-->
	<xsl:attribute-set name="MetaAttributes">
		<xsl:attribute name="name"><xsl:value-of select="name"/></xsl:attribute>
		<xsl:attribute name="content"><xsl:value-of select="content"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="LinkAttributes">
		<xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute>
		<xsl:attribute name="target"><xsl:value-of select="target"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="ImageAttributes">
		<xsl:attribute name="src"><xsl:value-of select="url"/></xsl:attribute>
		<xsl:attribute name="border"><xsl:value-of select="border"/></xsl:attribute>
		<xsl:attribute name="alt"><xsl:value-of select="alt_text"/></xsl:attribute>
		<xsl:attribute name="usemap"><xsl:value-of select="usemap"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="height"/></xsl:attribute>
		<xsl:attribute name="width"><xsl:value-of select="width"/></xsl:attribute>
	</xsl:attribute-set>
	<!--************************TEMPLATE FUNCTIONS**********************-->
	<!-- Template distinguishing output modes -->
	<xsl:template match="*" mode="output">
		<xsl:variable name="output_type" select="@output"/>
		<xsl:choose>
			<xsl:when test="$doc_output">
				<xsl:choose>
					<xsl:when test="$output_type">
						<xsl:if test="$output_type=$doc_output">
							<xsl:apply-templates/>
						</xsl:if>
					</xsl:when>
					<xsl:when test="not(name($output_type))">
						<xsl:apply-templates/>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="not($doc_output) and $generation_output">
				<xsl:if test="$generation_output">
					<xsl:choose>
						<xsl:when test="$output_type">
							<xsl:if test="$output_type=$generation_output">
								<xsl:apply-templates/>
							</xsl:if>
						</xsl:when>
						<xsl:when test="not(name($output_type))">
							<xsl:apply-templates/>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
			</xsl:when>
			<xsl:when test="not($doc_output) and not($generation_output)">
				<xsl:apply-templates/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- Template for converted element tag to HTML <p class="element_name"> -->
	<xsl:template name="par_element_to_attribute">
		<xsl:element name="p">
			<xsl:attribute name="class"><xsl:value-of select="name(.)"/></xsl:attribute>
			<xsl:apply-templates select="." mode="output"/>
		</xsl:element>
	</xsl:template>
	<xsl:template name="code_element_to_attribute">
		<xsl:param name="value"/>
		<xsl:param name="content"/>
		<xsl:element name="span">
			<xsl:attribute name="class"><xsl:value-of select="$value"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="name(url)">
					<xsl:element name="a">
						<xsl:attribute name="href"><xsl:value-of select="url"/></xsl:attribute>
						<xsl:value-of select="label"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="not(name(url))">
					<xsl:value-of select="$content"/>
				</xsl:when>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<!-- Template takes element tag and maps to HTML element equivalent.  Then loops through element tag and map child element 
	tags into corresponding attributes of parent.  For example '<link><url>A-url.html<url><label>a link</label></label>></link>'
	will be processed to become: <a href="a_url.html">a link</a> -->
	<xsl:template name="process_element">
		<xsl:param name="name"/>
		<xsl:param name="content"/>
		<xsl:element name="{$name}">
			<xsl:for-each select="./*">
				<xsl:if test="name()">
					<xsl:call-template name="mappings">
						<xsl:with-param name="parent">
							<xsl:value-of select="name(..)"/>
						</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="."/>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:for-each>
			<xsl:value-of select="$content"/>
		</xsl:element>
	</xsl:template>
	
	<!-- Mappings to map tag found in schema to required HTML output tag-->
	<xsl:template name="mappings">
		<xsl:param name="parent"/>
		<xsl:param name="value"/>
		<xsl:if test="string-length($value)&gt;0">
			<xsl:choose>
				<!--*****GENERAL*****-->
				<xsl:when test="name()='id'">
					<xsl:attribute name="id"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='image'">
					<xsl:call-template name="process_element">
						<xsl:with-param name="name">img</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="name()='url'">
					<xsl:choose>
						<xsl:when test="$parent='link'">
							<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
						</xsl:when>
						<xsl:when test="$parent='area'">
							<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
						</xsl:when>
						<xsl:when test="$parent='image'">
							<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
						</xsl:when>
						<xsl:when test="$parent='image_link'">
							<xsl:attribute name="href"><xsl:value-of select="."/></xsl:attribute>
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<!--*****LINK*****-->
				<xsl:when test="name()='target'">
					<xsl:attribute name="target"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<!--*****IMAGE*****-->
				<xsl:when test="name()='border'">
					<xsl:attribute name="border"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='width'">
					<xsl:attribute name="width"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='height'">
					<xsl:attribute name="height"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='alt_text'">
					<xsl:attribute name="alt"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='usemap'">
					<xsl:attribute name="usemap"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<!--*****AREA*****-->
				<xsl:when test="name()='shape'">
					<xsl:attribute name="shape"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='co-ordinates'">
					<xsl:attribute name="co-ordinates"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<!--*****CODE*****-->
				<xsl:when test="name()='class_name'">
					<xsl:attribute name="class"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='string'">
					<xsl:attribute name="string"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<!--*****HELP*****-->
				<xsl:when test="name()='keywords'">
					<xsl:attribute name="keywords"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='tab_index'">
					<xsl:attribute name="tab_index"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='hover_color'">
					<xsl:attribute name="hover_color"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='disambiguator'">
					<xsl:attribute name="disambiguator"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='error_url'">
					<xsl:attribute name="error_url"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='filter_name'">
					<xsl:attribute name="filter_name"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='filter_string'">
					<xsl:attribute name="filter_string"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='index_moniker'">
					<xsl:attribute name="index_moniker"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='namespace'">
					<xsl:attribute name="namespace"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
				<xsl:when test="name()='options'">
					<xsl:attribute name="options"><xsl:value-of select="$value"/></xsl:attribute>
				</xsl:when>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
