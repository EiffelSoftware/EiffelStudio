indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlTextAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_TEXT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_text_attribute,
	make_system_xml_xml_text_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_text_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlTextAttribute"
		end

	frozen make_system_xml_xml_text_attribute_1 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlTextAttribute"
		end

feature -- Access

	frozen get_data_type: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlTextAttribute"
		alias
			"get_DataType"
		end

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlTextAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlTextAttribute"
		alias
			"set_Type"
		end

	frozen set_data_type (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlTextAttribute"
		alias
			"set_DataType"
		end

end -- class SYSTEM_XML_XML_TEXT_ATTRIBUTE
