indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlSpace"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_XMLSPACE

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

	frozen preserve: SYSTEM_XML_XMLSPACE is
		external
			"IL enum signature :System.Xml.XmlSpace use System.Xml.XmlSpace"
		alias
			"2"
		end

	frozen default: SYSTEM_XML_XMLSPACE is
		external
			"IL enum signature :System.Xml.XmlSpace use System.Xml.XmlSpace"
		alias
			"1"
		end

	frozen none: SYSTEM_XML_XMLSPACE is
		external
			"IL enum signature :System.Xml.XmlSpace use System.Xml.XmlSpace"
		alias
			"0"
		end

end -- class SYSTEM_XML_XMLSPACE
