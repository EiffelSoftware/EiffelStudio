indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlAttributeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ATTRIBUTE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_attribute_attribute_2,
	make_system_xml_xml_attribute_attribute,
	make_system_xml_xml_attribute_attribute_1,
	make_system_xml_xml_attribute_attribute_3

feature {NONE} -- Initialization

	frozen make_system_xml_xml_attribute_attribute_2 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_system_xml_xml_attribute_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_system_xml_xml_attribute_attribute_1 (attribute_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_system_xml_xml_attribute_attribute_3 (attribute_name: SYSTEM_STRING; type: TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Xml.Serialization.XmlAttributeAttribute"
		end

feature -- Access

	frozen get_attribute_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_AttributeName"
		end

	frozen get_form: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Form"
		end

	frozen get_data_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Namespace"
		end

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Type"
		end

	frozen set_attribute_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_AttributeName"
		end

	frozen set_data_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_DataType"
		end

	frozen set_form (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_XML_ATTRIBUTE_ATTRIBUTE
