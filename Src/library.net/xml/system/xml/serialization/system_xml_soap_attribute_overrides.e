indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapAttributeOverrides"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_ATTRIBUTE_OVERRIDES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapAttributeOverrides"
		end

feature -- Access

	frozen get_item (type: TYPE): SYSTEM_XML_SOAP_ATTRIBUTES is
		external
			"IL signature (System.Type): System.Xml.Serialization.SoapAttributes use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"get_Item"
		end

	frozen get_item_type_string (type: TYPE; member: SYSTEM_STRING): SYSTEM_XML_SOAP_ATTRIBUTES is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.SoapAttributes use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen add (type: TYPE; attributes: SYSTEM_XML_SOAP_ATTRIBUTES) is
		external
			"IL signature (System.Type, System.Xml.Serialization.SoapAttributes): System.Void use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"Add"
		end

	frozen add_type_string (type: TYPE; member: SYSTEM_STRING; attributes: SYSTEM_XML_SOAP_ATTRIBUTES) is
		external
			"IL signature (System.Type, System.String, System.Xml.Serialization.SoapAttributes): System.Void use System.Xml.Serialization.SoapAttributeOverrides"
		alias
			"Add"
		end

end -- class SYSTEM_XML_SOAP_ATTRIBUTE_OVERRIDES
