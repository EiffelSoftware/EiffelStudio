indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaSimpleTypeList"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_LIST

inherit
	SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_CONTENT

create
	make_system_xml_xml_schema_simple_type_list

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_simple_type_list is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleTypeList"
		end

feature -- Access

	frozen get_item_type_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"get_ItemTypeName"
		end

	frozen get_item_type: SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleType use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"get_ItemType"
		end

feature -- Element Change

	frozen set_item_type_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"set_ItemTypeName"
		end

	frozen set_item_type (value: SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleType): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeList"
		alias
			"set_ItemType"
		end

end -- class SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_LIST
