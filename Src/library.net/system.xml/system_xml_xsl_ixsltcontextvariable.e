indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Xsl.IXsltContextVariable"

deferred external class
	SYSTEM_XML_XSL_IXSLTCONTEXTVARIABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_is_param: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.Xsl.IXsltContextVariable"
		alias
			"get_IsParam"
		end

	get_variable_type: SYSTEM_XML_XPATH_XPATHRESULTTYPE is
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

	evaluate (xslt_context: SYSTEM_XML_XSL_XSLTCONTEXT): ANY is
		external
			"IL deferred signature (System.Xml.Xsl.XsltContext): System.Object use System.Xml.Xsl.IXsltContextVariable"
		alias
			"Evaluate"
		end

end -- class SYSTEM_XML_XSL_IXSLTCONTEXTVARIABLE
