indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlArrayAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ARRAY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_array_attribute_1,
	make_system_xml_xml_array_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_xml_array_attribute_1 (element_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlArrayAttribute"
		end

	frozen make_system_xml_xml_array_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlArrayAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_Form"
		end

	frozen get_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_ElementName"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_Namespace"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_Namespace"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_ElementName"
		end

	frozen set_form (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_XML_ARRAY_ATTRIBUTE
