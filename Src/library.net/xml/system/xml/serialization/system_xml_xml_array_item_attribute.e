indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlArrayItemAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ARRAY_ITEM_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_array_item_attribute,
	make_system_xml_xml_array_item_attribute_2,
	make_system_xml_xml_array_item_attribute_3,
	make_system_xml_xml_array_item_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_array_item_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_system_xml_xml_array_item_attribute_2 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_system_xml_xml_array_item_attribute_3 (element_name: SYSTEM_STRING; type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_system_xml_xml_array_item_attribute_1 (element_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Form"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Namespace"
		end

	frozen get_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_DataType"
		end

	frozen get_nesting_level: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_NestingLevel"
		end

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Type"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_form (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Form"
		end

	frozen set_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Type"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Namespace"
		end

	frozen set_data_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_DataType"
		end

	frozen set_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_ElementName"
		end

	frozen set_nesting_level (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_NestingLevel"
		end

end -- class SYSTEM_XML_XML_ARRAY_ITEM_ATTRIBUTE
