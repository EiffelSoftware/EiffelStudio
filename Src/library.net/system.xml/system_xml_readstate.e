indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.ReadState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_READSTATE

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

	frozen initial: SYSTEM_XML_READSTATE is
		external
			"IL enum signature :System.Xml.ReadState use System.Xml.ReadState"
		alias
			"0"
		end

	frozen error: SYSTEM_XML_READSTATE is
		external
			"IL enum signature :System.Xml.ReadState use System.Xml.ReadState"
		alias
			"2"
		end

	frozen closed: SYSTEM_XML_READSTATE is
		external
			"IL enum signature :System.Xml.ReadState use System.Xml.ReadState"
		alias
			"4"
		end

	frozen end_of_file: SYSTEM_XML_READSTATE is
		external
			"IL enum signature :System.Xml.ReadState use System.Xml.ReadState"
		alias
			"3"
		end

	frozen interactive: SYSTEM_XML_READSTATE is
		external
			"IL enum signature :System.Xml.ReadState use System.Xml.ReadState"
		alias
			"1"
		end

end -- class SYSTEM_XML_READSTATE
