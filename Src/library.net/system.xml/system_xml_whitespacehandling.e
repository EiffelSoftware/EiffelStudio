indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.WhitespaceHandling"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_WHITESPACEHANDLING

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen All_: SYSTEM_XML_WHITESPACEHANDLING is
		external
			"IL enum signature :System.Xml.WhitespaceHandling use System.Xml.WhitespaceHandling"
		alias
			"0"
		end

	frozen significant: SYSTEM_XML_WHITESPACEHANDLING is
		external
			"IL enum signature :System.Xml.WhitespaceHandling use System.Xml.WhitespaceHandling"
		alias
			"1"
		end

	frozen none: SYSTEM_XML_WHITESPACEHANDLING is
		external
			"IL enum signature :System.Xml.WhitespaceHandling use System.Xml.WhitespaceHandling"
		alias
			"2"
		end

end -- class SYSTEM_XML_WHITESPACEHANDLING
