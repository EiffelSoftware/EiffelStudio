indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.IXPathNavigable"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IXPATH_NAVIGABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_navigator: SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL deferred signature (): System.Xml.XPath.XPathNavigator use System.Xml.XPath.IXPathNavigable"
		alias
			"CreateNavigator"
		end

end -- class SYSTEM_XML_IXPATH_NAVIGABLE
