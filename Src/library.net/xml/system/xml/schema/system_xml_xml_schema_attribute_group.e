indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaAttributeGroup"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_ATTRIBUTE_GROUP

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_attribute_group

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_attribute_group is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAttributeGroup"
		end

feature -- Access

	frozen get_any_attribute: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_AnyAttribute"
		end

	frozen get_redefined_attribute_group: SYSTEM_XML_XML_SCHEMA_ATTRIBUTE_GROUP is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAttributeGroup use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_RedefinedAttributeGroup"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_Name"
		end

	frozen get_attributes: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"set_Name"
		end

	frozen set_any_attribute (value: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnyAttribute): System.Void use System.Xml.Schema.XmlSchemaAttributeGroup"
		alias
			"set_AnyAttribute"
		end

end -- class SYSTEM_XML_XML_SCHEMA_ATTRIBUTE_GROUP
