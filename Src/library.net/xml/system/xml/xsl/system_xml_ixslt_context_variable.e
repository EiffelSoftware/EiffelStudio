indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Xsl.IXsltContextVariable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IXSLT_CONTEXT_VARIABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_is_param: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.Xsl.IXsltContextVariable"
		alias
			"get_IsParam"
		end

	get_variable_type: SYSTEM_XML_XPATH_RESULT_TYPE is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType use System.Xml.Xsl.IXsltContextVariable"
		alias
			"get_VariableType"
		end

	get_is_local: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.Xsl.IXsltContextVariable"
		alias
			"get_IsLocal"
		end

feature -- Basic Operations

	evaluate (xslt_context: SYSTEM_XML_XSLT_CONTEXT): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Xml.Xsl.XsltContext): System.Object use System.Xml.Xsl.IXsltContextVariable"
		alias
			"Evaluate"
		end

end -- class SYSTEM_XML_IXSLT_CONTEXT_VARIABLE
