indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapAttributeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_ATTRIBUTE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_soap_attribute_attribute_1,
	make_system_xml_soap_attribute_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_soap_attribute_attribute_1 (attr_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapAttributeAttribute"
		end

	frozen make_system_xml_soap_attribute_attribute is
		external
			"IL creator use System.Xml.Serialization.SoapAttributeAttribute"
		end

feature -- Access

	frozen get_attribute_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_AttributeName"
		end

	frozen get_data_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_attribute_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_AttributeName"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_data_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapAttributeAttribute"
		alias
			"set_DataType"
		end

end -- class SYSTEM_XML_SOAP_ATTRIBUTE_ATTRIBUTE
