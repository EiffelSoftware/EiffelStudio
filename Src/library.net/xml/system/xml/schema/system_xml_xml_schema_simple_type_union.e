indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaSimpleTypeUnion"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_UNION

inherit
	SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_CONTENT

create
	make_system_xml_xml_schema_simple_type_union

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_simple_type_union is
		external
			"IL creator use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		end

feature -- Access

	frozen get_base_types: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"get_BaseTypes"
		end

	frozen get_member_types: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME] is
		external
			"IL signature (): System.Xml.XmlQualifiedName[] use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"get_MemberTypes"
		end

feature -- Element Change

	frozen set_member_types (value: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME]) is
		external
			"IL signature (System.Xml.XmlQualifiedName[]): System.Void use System.Xml.Schema.XmlSchemaSimpleTypeUnion"
		alias
			"set_MemberTypes"
		end

end -- class SYSTEM_XML_XML_SCHEMA_SIMPLE_TYPE_UNION
