indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaSimpleType"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE

inherit
	SYSTEM_XML_XML_SCHEMA_TYPE

create
	make_system_xml_xml_schema_simple_type

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_simple_type is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleType"
		end

feature -- Access

	frozen get_content: SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_CONTENT is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleTypeContent use System.Xml.Schema.XmlSchemaSimpleType"
		alias
			"get_Content"
		end

feature -- Element Change

	frozen set_content (value: SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_CONTENT) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleTypeContent): System.Void use System.Xml.Schema.XmlSchemaSimpleType"
		alias
			"set_Content"
		end

end -- class SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE
