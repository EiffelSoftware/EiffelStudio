indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlChoiceIdentifierAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_CHOICE_IDENTIFIER_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_system_xml_xml_choice_identifier_attribute,
	make_system_xml_xml_choice_identifier_attribute_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_choice_identifier_attribute is
		external
			"IL creator use System.Xml.Serialization.XmlChoiceIdentifierAttribute"
		end

	frozen make_system_xml_xml_choice_identifier_attribute_1 (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlChoiceIdentifierAttribute"
		end

feature -- Access

	frozen get_member_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlChoiceIdentifierAttribute"
		alias
			"get_MemberName"
		end

feature -- Element Change

	frozen set_member_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlChoiceIdentifierAttribute"
		alias
			"set_MemberName"
		end

end -- class SYSTEM_XML_XML_CHOICE_IDENTIFIER_ATTRIBUTE
