indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.XslTransform"

external class
	SYSTEM_XML_XSL_XSLTRANSFORM

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Xsl.XslTransform"
		end

feature -- Element Change

	frozen set_xml_resolver (value: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"set_XmlResolver"
		end

feature -- Basic Operations

	frozen load (stylesheet: SYSTEM_XML_XPATH_IXPATHNAVIGABLE) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_string (url: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_string_xml_resolver (url: STRING; resolver: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.String, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_xpath_navigator (stylesheet: SYSTEM_XML_XPATH_XPATHNAVIGATOR) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_xpath_navigator_xslt_argument_list_text_writer (input: SYSTEM_XML_XPATH_XPATHNAVIGATOR; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.IO.TextWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xpath_navigator_xml_resolver (stylesheet: SYSTEM_XML_XPATH_XPATHNAVIGATOR; resolver: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_stream (input: SYSTEM_XML_XPATH_IXPATHNAVIGABLE; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.IO.Stream): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_xpath_navigator_xslt_argument_list_stream (input: SYSTEM_XML_XPATH_XPATHNAVIGATOR; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.IO.Stream): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_text_writer (input: SYSTEM_XML_XPATH_IXPATHNAVIGABLE; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.IO.TextWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_ixpath_navigable_xml_resolver (stylesheet: SYSTEM_XML_XPATH_IXPATHNAVIGABLE; resolver: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform (input: SYSTEM_XML_XPATH_XPATHNAVIGATOR; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST): SYSTEM_XML_XMLREADER is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList): System.Xml.XmlReader use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xml_reader_xml_resolver (stylesheet: SYSTEM_XML_XMLREADER; resolver: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XmlReader, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_string (inputfile: STRING; outputfile: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xml_reader (stylesheet: SYSTEM_XML_XMLREADER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_xml_writer (input: SYSTEM_XML_XPATH_IXPATHNAVIGABLE; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.Xml.XmlWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_xpath_navigator_xslt_argument_list_xml_writer (input: SYSTEM_XML_XPATH_XPATHNAVIGATOR; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST; output: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.Xml.XmlWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_ixpath_navigable_xslt_argument_list (input: SYSTEM_XML_XPATH_IXPATHNAVIGABLE; args: SYSTEM_XML_XSL_XSLTARGUMENTLIST): SYSTEM_XML_XMLREADER is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList): System.Xml.XmlReader use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

end -- class SYSTEM_XML_XSL_XSLTRANSFORM
