indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaComplexContent"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_COMPLEX_CONTENT

inherit
	SYSTEM_XML_XML_SCHEMA_CONTENT_MODEL

create
	make_system_xml_xml_schema_complex_content

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_complex_content is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexContent"
		end

feature -- Access

	frozen get_is_mixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"get_IsMixed"
		end

	get_content: SYSTEM_XML_XML_SCHEMA_CONTENT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContent use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"get_Content"
		end

feature -- Element Change

	set_content (value: SYSTEM_XML_XML_SCHEMA_CONTENT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContent): System.Void use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"set_Content"
		end

	frozen set_is_mixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaComplexContent"
		alias
			"set_IsMixed"
		end

end -- class SYSTEM_XML_XML_SCHEMA_COMPLEX_CONTENT
