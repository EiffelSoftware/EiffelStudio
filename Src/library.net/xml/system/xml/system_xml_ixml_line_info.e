indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.IXmlLineInfo"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_IXML_LINE_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_line_number: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.IXmlLineInfo"
		alias
			"get_LineNumber"
		end

	get_line_position: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.IXmlLineInfo"
		alias
			"get_LinePosition"
		end

feature -- Basic Operations

	has_line_info: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.IXmlLineInfo"
		alias
			"HasLineInfo"
		end

end -- class SYSTEM_XML_IXML_LINE_INFO
