indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapIncludeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_INCLUDE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_soap_include_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_soap_include_attribute (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.SoapIncludeAttribute"
		end

feature -- Access

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.SoapIncludeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.SoapIncludeAttribute"
		alias
			"set_Type"
		end

end -- class SYSTEM_XML_SOAP_INCLUDE_ATTRIBUTE
