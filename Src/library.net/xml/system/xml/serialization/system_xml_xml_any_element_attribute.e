indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlAnyElementAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ANY_ELEMENT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_any_element_attribute_2,
	make_system_xml_xml_any_element_attribute_1,
	make_system_xml_xml_any_element_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_xml_any_element_attribute_2 (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.Serialization.XmlAnyElementAttribute"
		end

	frozen make_system_xml_xml_any_element_attribute_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlAnyElementAttribute"
		end

	frozen make_system_xml_xml_any_element_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlAnyElementAttribute"
		end

feature -- Access

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"get_Namespace"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"set_Name"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_XML_XML_ANY_ELEMENT_ATTRIBUTE
