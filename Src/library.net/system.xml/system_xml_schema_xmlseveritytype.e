indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSeverityType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_SCHEMA_XMLSEVERITYTYPE

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

	frozen error: SYSTEM_XML_SCHEMA_XMLSEVERITYTYPE is
		external
			"IL enum signature :System.Xml.Schema.XmlSeverityType use System.Xml.Schema.XmlSeverityType"
		alias
			"0"
		end

	frozen warning: SYSTEM_XML_SCHEMA_XMLSEVERITYTYPE is
		external
			"IL enum signature :System.Xml.Schema.XmlSeverityType use System.Xml.Schema.XmlSeverityType"
		alias
			"1"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSEVERITYTYPE
