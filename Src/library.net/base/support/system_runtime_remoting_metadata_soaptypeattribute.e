indexing
	Generator: "Eiffel Emitter 2.5b2"
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
	make_soap_type_attribute

feature {NONE} -- Initialization

	frozen make_soap_type_attribute is
		external
			"IL creator use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		end

feature -- Access

	frozen get_soap_options: INTEGER is
		external
			"IL signature (): enum System.Runtime.Remoting.Metadata.SoapOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_SoapOptions"
		ensure
			valid_soap_option: Result = 0 or Result = 1 or Result = 2 or Result = 4 or Result = 8 or Result = 16
		end

	frozen get_xml_element_Name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlElementName"
		end

	get_xml_namespace: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlNamespace"
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

	get_use_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_UseAttribute"
		end

	frozen get_xml_field_order: INTEGER is
		external
			"IL signature (): enum System.Runtime.Remoting.Metadata.XmlFieldOrderOption use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"get_XmlFieldOrder"
		ensure
			valid_xml_field_order_option: Result = 0 or Result = 1 or Result = 2
		end

feature -- Element Change

	set_use_attribute (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_UseAttribute"
		end

	frozen set_xml_eype_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeName"
		end

	frozen set_xml_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlElementName"
		end

	frozen set_soap_options (value: INTEGER) is
			-- Valid values for `value' are a combination of the following values:
			-- None = 0
			-- AlwaysIncludeTypes = 1
			-- XsdString = 2
			-- EmbedAll = 4
			-- Option1 = 8
			-- Option2 = 16
		require
			valid_soap_option: (0 + 1 + 2 + 4 + 8 + 16) & value = 0 + 1 + 2 + 4 + 8 + 16
		external
			"IL signature (enum System.Runtime.Remoting.Metadata.SoapOption): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_SoapOptions"
		end

	frozen set_xml_type_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlTypeNamespace"
		end

	frozen set_xml_field_order (value: INTEGER) is
			-- Valid values for `value' are:
			-- All = 0
			-- Sequence = 1
			-- Choice = 2
		require
			valid_xml_field_order_option: value = 0 or value = 1 or value = 2
		external
			"IL signature (enum System.Runtime.Remoting.Metadata.XmlFieldOrderOption): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlFieldOrder"
		end

	set_xml_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.SoapTypeAttribute"
		alias
			"set_XmlNamespace"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_SOAPTYPEATTRIBUTE
