indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.XPathExpression"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XPATH_EXPRESSION

inherit
	SYSTEM_OBJECT

feature -- Access

	get_return_type: SYSTEM_XML_XPATH_RESULT_TYPE is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType use System.Xml.XPath.XPathExpression"
		alias
			"get_ReturnType"
		end

	get_expression: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathExpression"
		alias
			"get_Expression"
		end

feature -- Basic Operations

	add_sort_object_xml_sort_order (expr: SYSTEM_OBJECT; order: SYSTEM_XML_XML_SORT_ORDER; case_order: SYSTEM_XML_XML_CASE_ORDER; lang: SYSTEM_STRING; data_type: SYSTEM_XML_XML_DATA_TYPE) is
		external
			"IL deferred signature (System.Object, System.Xml.XPath.XmlSortOrder, System.Xml.XPath.XmlCaseOrder, System.String, System.Xml.XPath.XmlDataType): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"AddSort"
		end

	add_sort (expr: SYSTEM_OBJECT; comparer: ICOMPARER) is
		external
			"IL deferred signature (System.Object, System.Collections.IComparer): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"AddSort"
		end

	set_context (ns_manager: SYSTEM_XML_XML_NAMESPACE_MANAGER) is
		external
			"IL deferred signature (System.Xml.XmlNamespaceManager): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"SetContext"
		end

	clone_: SYSTEM_XML_XPATH_EXPRESSION is
		external
			"IL deferred signature (): System.Xml.XPath.XPathExpression use System.Xml.XPath.XPathExpression"
		alias
			"Clone"
		end

end -- class SYSTEM_XML_XPATH_EXPRESSION
