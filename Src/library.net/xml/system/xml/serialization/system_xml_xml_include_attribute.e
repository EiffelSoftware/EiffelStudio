indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlIncludeAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_INCLUDE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_include_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_xml_include_attribute (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlIncludeAttribute"
		end

feature -- Access

	frozen get_type_type: TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlIncludeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlIncludeAttribute"
		alias
			"set_Type"
		end

end -- class SYSTEM_XML_XML_INCLUDE_ATTRIBUTE
