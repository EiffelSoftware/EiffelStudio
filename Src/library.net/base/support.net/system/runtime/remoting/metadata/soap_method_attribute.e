indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.SoapMethodAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_METHOD_ATTRIBUTE

inherit
	SOAP_ATTRIBUTE
		redefine
			set_use_attribute,
			get_use_attribute,
			set_xml_namespace,
			get_xml_namespace
		end

create
	make_soap_method_attribute

feature {NONE} -- Initialization

	frozen make_soap_method_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		end

feature -- Access

	frozen get_soap_action: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_SoapAction"
		end

	frozen get_return_xml_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ReturnXmlElementName"
		end

	get_xml_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_XmlNamespace"
		end

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_UseAttribute"
		end

	frozen get_response_xml_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ResponseXmlElementName"
		end

	frozen get_response_xml_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ResponseXmlNamespace"
		end

feature -- Element Change

	set_xml_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_XmlNamespace"
		end

	frozen set_response_xml_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ResponseXmlNamespace"
		end

	set_use_attribute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_UseAttribute"
		end

	frozen set_return_xml_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ReturnXmlElementName"
		end

	frozen set_soap_action (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_SoapAction"
		end

	frozen set_response_xml_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ResponseXmlElementName"
		end

end -- class SOAP_METHOD_ATTRIBUTE
