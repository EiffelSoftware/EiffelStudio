indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Formatting"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_FORMATTING

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

	frozen none: SYSTEM_XML_FORMATTING is
		external
			"IL enum signature :System.Xml.Formatting use System.Xml.Formatting"
		alias
			"0"
		end

	frozen indented: SYSTEM_XML_FORMATTING is
		external
			"IL enum signature :System.Xml.Formatting use System.Xml.Formatting"
		alias
			"1"
		end

end -- class SYSTEM_XML_FORMATTING
