indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapTypeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_TYPE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_soap_type_attribute_1,
	make_system_xml_soap_type_attribute_2,
	make_system_xml_soap_type_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_soap_type_attribute_1 (type_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapTypeAttribute"
		end

	frozen make_system_xml_soap_type_attribute_2 (type_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.Serialization.SoapTypeAttribute"
		end

	frozen make_system_xml_soap_type_attribute is
		external
			"IL creator use System.Xml.Serialization.SoapTypeAttribute"
		end

feature -- Access

	frozen get_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"get_TypeName"
		end

	frozen get_include_in_schema: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"get_IncludeInSchema"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"set_TypeName"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_include_in_schema (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.SoapTypeAttribute"
		alias
			"set_IncludeInSchema"
		end

end -- class SYSTEM_XML_SOAP_TYPE_ATTRIBUTE
