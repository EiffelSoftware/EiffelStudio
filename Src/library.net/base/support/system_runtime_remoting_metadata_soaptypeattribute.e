indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.SoapTypeAttribute"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPTYPEATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE
		redefine
			set_use_attribute,
			get_use_attribute,
			set_xml_namespace,
			get_xml_namespace
		end

create
	make_soaptypeattribute

feature {NONE} -- Initialization

	frozen make_soaptypeattribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		end

feature -- Access

	get_xml_namespace: STRING is
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

	frozen get_xml_type_namespace: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlTypeNamespace"
		end

	frozen get_xml_type_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlTypeName"
		end

	frozen get_xml_field_order: SYSTEM_RUNTIME_REMOTING_METADATA_XMLFIELDORDEROPTION is
		external
			"IL signature (): System.Runtime.Remoting.Metadata.XmlFieldOrderOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlFieldOrder"
		end

	frozen get_xml_element_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlElementName"
		end

	frozen get_soap_options: SYSTEM_RUNTIME_REMOTING_METADATA_SOAPOPTION is
		external
			"IL signature (): System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_SoapOptions"
		end

feature -- Element Change

	set_xml_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlNamespace"
		end

	frozen set_soap_options (value: SYSTEM_RUNTIME_REMOTING_METADATA_SOAPOPTION) is
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

	frozen set_xml_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeName"
		end

	frozen set_xml_field_order (value: SYSTEM_RUNTIME_REMOTING_METADATA_XMLFIELDORDEROPTION) is
		external
			"IL signature (System.Runtime.Remoting.Metadata.XmlFieldOrderOption): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlFieldOrder"
		end

	frozen set_xml_type_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeNamespace"
		end

	frozen set_xml_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlElementName"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_SOAPTYPEATTRIBUTE
