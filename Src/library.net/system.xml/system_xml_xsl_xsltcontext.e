indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.XsltContext"

deferred external class
	SYSTEM_XML_XSL_XSLTCONTEXT

inherit
	SYSTEM_XML_XMLNAMESPACEMANAGER
	SYSTEM_COLLECTIONS_IENUMERABLE

feature -- Access

	get_whitespace: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.Xsl.XsltContext"
		alias
			"get_Whitespace"
		end

feature -- Basic Operations

	resolve_function (prefix_: STRING; name: STRING; arg_types: ARRAY [SYSTEM_XML_XPATH_XPATHRESULTTYPE]): SYSTEM_XML_XSL_IXSLTCONTEXTFUNCTION is
		external
			"IL deferred signature (System.String, System.String, System.Xml.XPath.XPathResultType[]): System.Xml.Xsl.IXsltContextFunction use System.Xml.Xsl.XsltContext"
		alias
			"ResolveFunction"
		end

	preserve_whitespace (node: SYSTEM_XML_XPATH_XPATHNAVIGATOR): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNavigator): System.Boolean use System.Xml.Xsl.XsltContext"
		alias
			"PreserveWhitespace"
		end

	compare_document (base_uri: STRING; nextbase_uri: STRING): INTEGER is
		external
			"IL deferred signature (System.String, System.String): System.Int32 use System.Xml.Xsl.XsltContext"
		alias
			"CompareDocument"
		end

	resolve_variable (prefix_: STRING; name: STRING): SYSTEM_XML_XSL_IXSLTCONTEXTVARIABLE is
		external
			"IL deferred signature (System.String, System.String): System.Xml.Xsl.IXsltContextVariable use System.Xml.Xsl.XsltContext"
		alias
			"ResolveVariable"
		end

end -- class SYSTEM_XML_XSL_XSLTCONTEXT
