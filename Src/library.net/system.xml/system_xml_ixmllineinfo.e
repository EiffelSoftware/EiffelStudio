indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.IXmlLineInfo"

deferred external class
	SYSTEM_XML_IXMLLINEINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

end -- class SYSTEM_XML_IXMLLINEINFO
