indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapAttributes"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_ATTRIBUTES

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapAttributes"
		end

	frozen make_1 (provider: ICUSTOM_ATTRIBUTE_PROVIDER) is
		external
			"IL creator signature (System.Reflection.ICustomAttributeProvider) use System.Xml.Serialization.SoapAttributes"
		end

feature -- Access

	frozen get_soap_type: SYSTEM_XML_SOAP_TYPE_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.SoapTypeAttribute use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapType"
		end

	frozen get_soap_enum: SYSTEM_XML_SOAP_ENUM_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.SoapEnumAttribute use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapEnum"
		end

	frozen get_soap_default_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapDefaultValue"
		end

	frozen get_soap_attribute: SYSTEM_XML_SOAP_ATTRIBUTE_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.SoapAttributeAttribute use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapAttribute"
		end

	frozen get_soap_element: SYSTEM_XML_SOAP_ELEMENT_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.SoapElementAttribute use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapElement"
		end

	frozen get_soap_ignore: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.SoapAttributes"
		alias
			"get_SoapIgnore"
		end

feature -- Element Change

	frozen set_soap_element (value: SYSTEM_XML_SOAP_ELEMENT_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.SoapElementAttribute): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapElement"
		end

	frozen set_soap_ignore (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapIgnore"
		end

	frozen set_soap_default_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapDefaultValue"
		end

	frozen set_soap_type (value: SYSTEM_XML_SOAP_TYPE_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.SoapTypeAttribute): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapType"
		end

	frozen set_soap_enum (value: SYSTEM_XML_SOAP_ENUM_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.SoapEnumAttribute): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapEnum"
		end

	frozen set_soap_attribute (value: SYSTEM_XML_SOAP_ATTRIBUTE_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.SoapAttributeAttribute): System.Void use System.Xml.Serialization.SoapAttributes"
		alias
			"set_SoapAttribute"
		end

end -- class SYSTEM_XML_SOAP_ATTRIBUTES
