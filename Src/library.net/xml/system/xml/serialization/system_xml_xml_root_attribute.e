indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlRootAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ROOT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_root_attribute,
	make_system_xml_xml_root_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_root_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlRootAttribute"
		end

	frozen make_system_xml_xml_root_attribute_1 (element_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlRootAttribute"
		end

feature -- Access

	frozen get_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_Namespace"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_data_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_DataType"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_Namespace"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_ElementName"
		end

end -- class SYSTEM_XML_XML_ROOT_ATTRIBUTE
