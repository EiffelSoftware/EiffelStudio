indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.SoapFieldAttribute"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPFIELDATTRIBUTE

inherit
	SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE

create
	make_soapfieldattribute

feature {NONE} -- Initialization

	frozen make_soapfieldattribute is
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

	frozen get_xml_element_name: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.SoapFieldAttribute"
		alias
			"get_XmlElementName"
		end

feature -- Element Change

	frozen set_xml_element_name (value: STRING) is
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

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_SOAPFIELDATTRIBUTE
