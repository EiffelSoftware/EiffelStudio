indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaUse"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAUSE

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

	frozen required: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaUse use System.Xml.Schema.XmlSchemaUse"
		alias
			"3"
		end

	frozen prohibited: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaUse use System.Xml.Schema.XmlSchemaUse"
		alias
			"2"
		end

	frozen optional: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaUse use System.Xml.Schema.XmlSchemaUse"
		alias
			"1"
		end

	frozen none: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE is
		external
			"IL enum signature :System.Xml.Schema.XmlSchemaUse use System.Xml.Schema.XmlSchemaUse"
		alias
			"0"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAUSE
