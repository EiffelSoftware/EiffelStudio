indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapIncludeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_SOAPINCLUDEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_soapincludeattribute

feature {NONE} -- Initialization

	frozen make_soapincludeattribute (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.SoapIncludeAttribute"
		end

feature -- Access

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.SoapIncludeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.SoapIncludeAttribute"
		alias
			"set_Type"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPINCLUDEATTRIBUTE
