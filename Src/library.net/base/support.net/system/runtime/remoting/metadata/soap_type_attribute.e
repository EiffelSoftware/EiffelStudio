indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.SoapTypeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_TYPE_ATTRIBUTE

inherit
	SOAP_ATTRIBUTE
		redefine
			set_use_attribute,
			get_use_attribute,
			set_xml_namespace,
			get_xml_namespace
		end

create
	make_soap_type_attribute

feature {NONE} -- Initialization

	frozen make_soap_type_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		end

feature -- Access

	get_xml_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlNamespace"
		end

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_UseAttribute"
		end

	frozen get_xml_type_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlTypeNamespace"
		end

	frozen get_xml_type_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlTypeName"
		end

	frozen get_xml_field_order: XML_FIELD_ORDER_OPTION is
		external
			"IL signature (): System.Runtime.Remoting.Metadata.XmlFieldOrderOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlFieldOrder"
		end

	frozen get_xml_element_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlElementName"
		end

	frozen get_soap_options: SOAP_OPTION is
		external
			"IL signature (): System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_SoapOptions"
		end

feature -- Element Change

	set_xml_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlNamespace"
		end

	frozen set_soap_options (value: SOAP_OPTION) is
		external
			"IL signature (System.Runtime.Remoting.Metadata.SoapOption): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_SoapOptions"
		end

	set_use_attribute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_UseAttribute"
		end

	frozen set_xml_type_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeName"
		end

	frozen set_xml_field_order (value: XML_FIELD_ORDER_OPTION) is
		external
			"IL signature (System.Runtime.Remoting.Metadata.XmlFieldOrderOption): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlFieldOrder"
		end

	frozen set_xml_type_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeNamespace"
		end

	frozen set_xml_element_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlElementName"
		end

end -- class SOAP_TYPE_ATTRIBUTE
