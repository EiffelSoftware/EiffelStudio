indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Metadata.SoapAttribute"

external class
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_soap_attribute

feature {NONE} -- Initialization

	frozen make_soap_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapAttribute"
		end

feature -- Access

	get_xml_namespace: STRING is
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

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"get_UseAttribute"
		end

feature -- Element Change

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

	set_xml_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapAttribute"
		alias
			"set_XmlNamespace"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE
