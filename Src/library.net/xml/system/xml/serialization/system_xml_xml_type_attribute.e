indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlTypeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_TYPE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_type_attribute,
	make_system_xml_xml_type_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_type_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlTypeAttribute"
		end

	frozen make_system_xml_xml_type_attribute_1 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlTypeAttribute"
		end

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_TypeName"
		end

	frozen get_include_in_schema: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_IncludeInSchema"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_TypeName"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_include_in_schema (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_IncludeInSchema"
		end

end -- class SYSTEM_XML_XML_TYPE_ATTRIBUTE
