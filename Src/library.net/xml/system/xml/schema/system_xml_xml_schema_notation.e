indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaNotation"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_NOTATION

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_notation

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_notation is
		external
			"IL creator use System.Xml.Schema.XmlSchemaNotation"
		end

feature -- Access

	frozen get_public: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_Public"
		end

	frozen get_system: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_System"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaNotation"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_Name"
		end

	frozen set_system (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_System"
		end

	frozen set_public (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaNotation"
		alias
			"set_Public"
		end

end -- class SYSTEM_XML_XML_SCHEMA_NOTATION
