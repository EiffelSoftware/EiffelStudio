indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.IXPathNavigable"

deferred external class
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_navigator: SYSTEM_XML_XPATH_XPATHNAVIGATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNavigator use System.Xml.XPath.IXPathNavigable"
		alias
			"CreateNavigator"
		end

end -- class SYSTEM_XML_XPATH_IXPATHNAVIGABLE
