indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.IXsltContextFunction"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IXSLT_CONTEXT_FUNCTION

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_arg_types: NATIVE_ARRAY [SYSTEM_XML_XPATH_RESULT_TYPE] is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType[] use System.Xml.Xsl.IXsltContextFunction"
		alias
			"get_ArgTypes"
		end

	get_return_type: SYSTEM_XML_XPATH_RESULT_TYPE is
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

	invoke (xslt_context: SYSTEM_XML_XSLT_CONTEXT; args: NATIVE_ARRAY [SYSTEM_OBJECT]; doc_context: SYSTEM_XML_XPATH_NAVIGATOR): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Xml.Xsl.XsltContext, System.Object[], System.Xml.XPath.XPathNavigator): System.Object use System.Xml.Xsl.IXsltContextFunction"
		alias
			"Invoke"
		end

end -- class SYSTEM_XML_IXSLT_CONTEXT_FUNCTION
