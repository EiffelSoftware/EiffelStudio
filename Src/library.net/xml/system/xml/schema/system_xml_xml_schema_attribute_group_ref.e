indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaAttributeGroupRef"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_ATTRIBUTE_GROUP_REF

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_attribute_group_ref

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_attribute_group_ref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		end

feature -- Access

	frozen get_ref_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		alias
			"get_RefName"
		end

feature -- Element Change

	frozen set_ref_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaAttributeGroupRef"
		alias
			"set_RefName"
		end

end -- class SYSTEM_XML_XML_SCHEMA_ATTRIBUTE_GROUP_REF
