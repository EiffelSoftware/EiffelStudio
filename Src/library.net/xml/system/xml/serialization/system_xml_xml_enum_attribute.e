indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlEnumAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ENUM_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_enum_attribute,
	make_system_xml_xml_enum_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_enum_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlEnumAttribute"
		end

	frozen make_system_xml_xml_enum_attribute_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlEnumAttribute"
		end

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlEnumAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlEnumAttribute"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_XML_ENUM_ATTRIBUTE
