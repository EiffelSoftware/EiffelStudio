indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapElementAttribute"

external class
	SYSTEM_XML_SERIALIZATION_SOAPELEMENTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_soapelementattribute_1,
	make_soapelementattribute

feature {NONE} -- Initialization

	frozen make_soapelementattribute_1 (element_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapElementAttribute"
		end

	frozen make_soapelementattribute is
		external
			"IL creator use System.Xml.Serialization.SoapElementAttribute"
		end

feature -- Access

	frozen get_element_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapElementAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.SoapElementAttribute"
		alias
			"get_DataType"
		end

feature -- Element Change

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapElementAttribute"
		alias
			"set_DataType"
		end

	frozen set_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.SoapElementAttribute"
		alias
			"set_ElementName"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPELEMENTATTRIBUTE
