indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XPath.XPathDocument"

external class
	SYSTEM_XML_XPATH_XPATHDOCUMENT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (uri: STRING; space: SYSTEM_XML_XMLSPACE) is
		external
			"IL creator signature (System.String, System.Xml.XmlSpace) use System.Xml.XPath.XPathDocument"
		end

	frozen make_4 (uri: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XPath.XPathDocument"
		end

	frozen make_3 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Xml.XPath.XPathDocument"
		end

	frozen make_2 (reader: SYSTEM_IO_TEXTREADER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Xml.XPath.XPathDocument"
		end

	frozen make (reader: SYSTEM_XML_XMLREADER; space: SYSTEM_XML_XMLSPACE) is
		external
			"IL creator signature (System.Xml.XmlReader, System.Xml.XmlSpace) use System.Xml.XPath.XPathDocument"
		end

	frozen make_1 (reader: SYSTEM_XML_XMLREADER) is
		external
			"IL creator signature (System.Xml.XmlReader) use System.Xml.XPath.XPathDocument"
		end

feature -- Basic Operations

	frozen create_navigator: SYSTEM_XML_XPATH_XPATHNAVIGATOR is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XPath.XPathDocument"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_XML_XPATH_XPATHDOCUMENT
