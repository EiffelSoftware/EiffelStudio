indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.XsltContext"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XSLT_CONTEXT

inherit
	SYSTEM_XML_XML_NAMESPACE_MANAGER
	IENUMERABLE

feature -- Access

	get_whitespace: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.Xsl.XsltContext"
		alias
			"get_Whitespace"
		end

feature -- Basic Operations

	resolve_function (prefix_: SYSTEM_STRING; name: SYSTEM_STRING; arg_types: NATIVE_ARRAY [SYSTEM_XML_XPATH_RESULT_TYPE]): SYSTEM_XML_IXSLT_CONTEXT_FUNCTION is
		external
			"IL deferred signature (System.String, System.String, System.Xml.XPath.XPathResultType[]): System.Xml.Xsl.IXsltContextFunction use System.Xml.Xsl.XsltContext"
		alias
			"ResolveFunction"
		end

	preserve_whitespace (node: SYSTEM_XML_XPATH_NAVIGATOR): BOOLEAN is
		external
			"IL deferred signature (System.Xml.XPath.XPathNavigator): System.Boolean use System.Xml.Xsl.XsltContext"
		alias
			"PreserveWhitespace"
		end

	compare_document (base_uri: SYSTEM_STRING; nextbase_uri: SYSTEM_STRING): INTEGER is
		external
			"IL deferred signature (System.String, System.String): System.Int32 use System.Xml.Xsl.XsltContext"
		alias
			"CompareDocument"
		end

	resolve_variable (prefix_: SYSTEM_STRING; name: SYSTEM_STRING): SYSTEM_XML_IXSLT_CONTEXT_VARIABLE is
		external
			"IL deferred signature (System.String, System.String): System.Xml.Xsl.IXsltContextVariable use System.Xml.Xsl.XsltContext"
		alias
			"ResolveVariable"
		end

end -- class SYSTEM_XML_XSLT_CONTEXT
