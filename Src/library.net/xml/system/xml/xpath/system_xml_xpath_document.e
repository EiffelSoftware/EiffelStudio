indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XPath.XPathDocument"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XPATH_DOCUMENT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_XML_IXPATH_NAVIGABLE

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (uri: SYSTEM_STRING; space: SYSTEM_XML_XML_SPACE) is
		external
			"IL creator signature (System.String, System.Xml.XmlSpace) use System.Xml.XPath.XPathDocument"
		end

	frozen make_4 (uri: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XPath.XPathDocument"
		end

	frozen make_3 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Xml.XPath.XPathDocument"
		end

	frozen make_2 (reader: TEXT_READER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Xml.XPath.XPathDocument"
		end

	frozen make (reader: SYSTEM_XML_XML_READER; space: SYSTEM_XML_XML_SPACE) is
		external
			"IL creator signature (System.Xml.XmlReader, System.Xml.XmlSpace) use System.Xml.XPath.XPathDocument"
		end

	frozen make_1 (reader: SYSTEM_XML_XML_READER) is
		external
			"IL creator signature (System.Xml.XmlReader) use System.Xml.XPath.XPathDocument"
		end

feature -- Basic Operations

	frozen create_navigator: SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL signature (): System.Xml.XPath.XPathNavigator use System.Xml.XPath.XPathDocument"
		alias
			"CreateNavigator"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XPath.XPathDocument"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathDocument"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XPath.XPathDocument"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XPath.XPathDocument"
		alias
			"Finalize"
		end

end -- class SYSTEM_XML_XPATH_DOCUMENT
