indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.IXsltContextFunction"

deferred external class
	SYSTEM_XML_XSL_IXSLTCONTEXTFUNCTION

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_arg_types: ARRAY [SYSTEM_XML_XPATH_XPATHRESULTTYPE] is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType[] use System.Xml.Xsl.IXsltContextFunction"
		alias
			"get_ArgTypes"
		end

	get_return_type: SYSTEM_XML_XPATH_XPATHRESULTTYPE is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType use System.Xml.Xsl.IXsltContextFunction"
		alias
			"get_ReturnType"
		end

	get_maxargs: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.Xsl.IXsltContextFunction"
		alias
			"get_Maxargs"
		end

	get_minargs: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.Xsl.IXsltContextFunction"
		alias
			"get_Minargs"
		end

feature -- Basic Operations

	invoke (xslt_context: SYSTEM_XML_XSL_XSLTCONTEXT; args: ARRAY [ANY]; doc_context: SYSTEM_XML_XPATH_XPATHNAVIGATOR): ANY is
		external
			"IL deferred signature (System.Xml.Xsl.XsltContext, System.Object[], System.Xml.XPath.XPathNavigator): System.Object use System.Xml.Xsl.IXsltContextFunction"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_XSL_IXSLTCONTEXTFUNCTION
