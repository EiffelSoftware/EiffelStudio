indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.XPathExpression"

deferred external class
	SYSTEM_XML_XPATH_XPATHEXPRESSION

feature -- Access

	get_return_type: SYSTEM_XML_XPATH_XPATHRESULTTYPE is
		external
			"IL deferred signature (): System.Xml.XPath.XPathResultType use System.Xml.XPath.XPathExpression"
		alias
			"get_ReturnType"
		end

	get_expression: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XPath.XPathExpression"
		alias
			"get_Expression"
		end

feature -- Basic Operations

	add_sort_object_xml_sort_order (expr: ANY; order: SYSTEM_XML_XPATH_XMLSORTORDER; case_order: SYSTEM_XML_XPATH_XMLCASEORDER; lang: STRING; data_type: SYSTEM_XML_XPATH_XMLDATATYPE) is
		external
			"IL deferred signature (System.Object, System.Xml.XPath.XmlSortOrder, System.Xml.XPath.XmlCaseOrder, System.String, System.Xml.XPath.XmlDataType): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"AddSort"
		end

	clone: SYSTEM_XML_XPATH_XPATHEXPRESSION is
		external
			"IL deferred signature (): System.Xml.XPath.XPathExpression use System.Xml.XPath.XPathExpression"
		alias
			"Clone"
		end

	set_context (ns_manager: SYSTEM_XML_XMLNAMESPACEMANAGER) is
		external
			"IL deferred signature (System.Xml.XmlNamespaceManager): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"SetContext"
		end

	add_sort (expr: ANY; comparer: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL deferred signature (System.Object, System.Collections.IComparer): System.Void use System.Xml.XPath.XPathExpression"
		alias
			"AddSort"
		end

end -- class SYSTEM_XML_XPATH_XPATHEXPRESSION
