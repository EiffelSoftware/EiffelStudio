indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.SoapFieldAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_FIELD_ATTRIBUTE

inherit
	SOAP_ATTRIBUTE

create
	make_soap_field_attribute

feature {NONE} -- Initialization

	frozen make_soap_field_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		end

feature -- Access

	frozen get_order: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"get_Order"
		end

	frozen get_xml_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"get_XmlElementName"
		end

feature -- Element Change

	frozen set_xml_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"set_XmlElementName"
		end

	frozen set_order (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"set_Order"
		end

feature -- Basic Operations

	frozen is_interop_xml_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"IsInteropXmlElement"
		end

end -- class SOAP_FIELD_ATTRIBUTE
