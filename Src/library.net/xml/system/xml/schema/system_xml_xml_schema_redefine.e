indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaRedefine"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_REDEFINE

inherit
	SYSTEM_XML_XML_SCHEMA_EXTERNAL

create
	make_system_xml_xml_schema_redefine

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_redefine is
		external
			"IL creator use System.Xml.Schema.XmlSchemaRedefine"
		end

feature -- Access

	frozen get_attribute_groups: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_AttributeGroups"
		end

	frozen get_items: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_Items"
		end

	frozen get_schema_types: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_SchemaTypes"
		end

	frozen get_groups: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaRedefine"
		alias
			"get_Groups"
		end

end -- class SYSTEM_XML_XML_SCHEMA_REDEFINE
