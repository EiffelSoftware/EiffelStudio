indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.SoapAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SOAP_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_soap_attribute

feature {NONE} -- Initialization

	frozen make_soap_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapAttribute"
		end

feature -- Access

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"get_UseAttribute"
		end

	get_xml_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"get_XmlNamespace"
		end

	get_embedded: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"get_Embedded"
		end

feature -- Element Change

	set_xml_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"set_XmlNamespace"
		end

	set_use_attribute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"set_UseAttribute"
		end

	set_embedded (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"set_Embedded"
		end

end -- class SOAP_ATTRIBUTE
