indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaChoice"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_CHOICE

inherit
	SYSTEM_XML_XML_SCHEMA_GROUP_BASE

create
	make_system_xml_xml_schema_choice

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_choice is
		external
			"IL creator use System.Xml.Schema.XmlSchemaChoice"
		end

feature -- Access

	get_items: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaChoice"
		alias
			"get_Items"
		end

end -- class SYSTEM_XML_XML_SCHEMA_CHOICE
