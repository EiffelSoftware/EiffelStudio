indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Metadata.SoapMethodAttribute"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPMETHODATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE
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

	frozen get_response_xml_element_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ResponseXmlElementName"
		end

	get_xml_namespace: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_XmlNamespace"
		end

	frozen get_soap_action: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_SoapAction"
		end

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_UseAttribute"
		end

	frozen get_response_xml_namespace: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ResponseXmlNamespace"
		end

	frozen get_return_xml_element_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"get_ReturnXmlElementName"
		end

feature -- Element Change

	set_use_attribute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_UseAttribute"
		end

	frozen set_soap_action (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_SoapAction"
		end

	frozen set_response_xml_Element_Name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ResponseXmlElementName"
		end

	frozen set_response_xml_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ResponseXmlNamespace"
		end

	frozen set_return_xml_Element_Name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_ReturnXmlElementName"
		end

	set_xml_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapMethodAttribute"
		alias
			"set_XmlNamespace"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_SOAPMETHODATTRIBUTE
