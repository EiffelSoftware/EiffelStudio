indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapEnumAttribute"

external class
	SYSTEM_XML_SERIALIZATION_SOAPENUMATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_soapenumattribute,
	make_soapenumattribute_1

feature {NONE} -- Initialization

	frozen make_soapenumattribute is
		external
			"IL creator use System.Xml.Serialization.SoapEnumAttribute"
		end

	frozen make_soapenumattribute_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapEnumAttribute"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapEnumAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapEnumAttribute"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPENUMATTRIBUTE
