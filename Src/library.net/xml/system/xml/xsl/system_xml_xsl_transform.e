indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.XslTransform"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XSL_TRANSFORM

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Xsl.XslTransform"
		end

feature -- Element Change

	frozen set_xml_resolver (value: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"set_XmlResolver"
		end

feature -- Basic Operations

	frozen load (stylesheet: SYSTEM_XML_IXPATH_NAVIGABLE) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_string (url: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_string_xml_resolver (url: SYSTEM_STRING; resolver: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.String, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen load_xpath_navigator (stylesheet: SYSTEM_XML_XPATH_NAVIGATOR) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_xpath_navigator_xslt_argument_list_text_writer (input: SYSTEM_XML_XPATH_NAVIGATOR; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: TEXT_WRITER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.IO.TextWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xpath_navigator_xml_resolver (stylesheet: SYSTEM_XML_XPATH_NAVIGATOR; resolver: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_stream (input: SYSTEM_XML_IXPATH_NAVIGABLE; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: SYSTEM_STREAM) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.IO.Stream): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_xpath_navigator_xslt_argument_list_stream (input: SYSTEM_XML_XPATH_NAVIGATOR; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: SYSTEM_STREAM) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.IO.Stream): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_text_writer (input: SYSTEM_XML_IXPATH_NAVIGABLE; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: TEXT_WRITER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.IO.TextWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_ixpath_navigable_xml_resolver (stylesheet: SYSTEM_XML_IXPATH_NAVIGABLE; resolver: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform (input: SYSTEM_XML_XPATH_NAVIGATOR; args: SYSTEM_XML_XSLT_ARGUMENT_LIST): SYSTEM_XML_XML_READER is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList): System.Xml.XmlReader use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xml_reader_xml_resolver (stylesheet: SYSTEM_XML_XML_READER; resolver: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XmlReader, System.Xml.XmlResolver): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_string (inputfile: SYSTEM_STRING; outputfile: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen load_xml_reader (stylesheet: SYSTEM_XML_XML_READER) is
		external
			"IL signature (System.Xml.XmlReader): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Load"
		end

	frozen transform_ixpath_navigable_xslt_argument_list_xml_writer (input: SYSTEM_XML_IXPATH_NAVIGABLE; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList, System.Xml.XmlWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_xpath_navigator_xslt_argument_list_xml_writer (input: SYSTEM_XML_XPATH_NAVIGATOR; args: SYSTEM_XML_XSLT_ARGUMENT_LIST; output: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XPath.XPathNavigator, System.Xml.Xsl.XsltArgumentList, System.Xml.XmlWriter): System.Void use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

	frozen transform_ixpath_navigable_xslt_argument_list (input: SYSTEM_XML_IXPATH_NAVIGABLE; args: SYSTEM_XML_XSLT_ARGUMENT_LIST): SYSTEM_XML_XML_READER is
		external
			"IL signature (System.Xml.XPath.IXPathNavigable, System.Xml.Xsl.XsltArgumentList): System.Xml.XmlReader use System.Xml.Xsl.XslTransform"
		alias
			"Transform"
		end

end -- class SYSTEM_XML_XSL_TRANSFORM
