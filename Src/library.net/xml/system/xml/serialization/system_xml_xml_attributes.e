indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlAttributes"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ATTRIBUTES

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlAttributes"
		end

	frozen make_1 (provider: ICUSTOM_ATTRIBUTE_PROVIDER) is
		external
			"IL creator signature (System.Reflection.ICustomAttributeProvider) use System.Xml.Serialization.XmlAttributes"
		end

feature -- Access

	frozen get_xml_text: SYSTEM_XML_XML_TEXT_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlTextAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlText"
		end

	frozen get_xml_enum: SYSTEM_XML_XML_ENUM_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlEnumAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlEnum"
		end

	frozen get_xml_default_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlDefaultValue"
		end

	frozen get_xml_elements: SYSTEM_XML_XML_ELEMENT_ATTRIBUTES is
		external
			"IL signature (): System.Xml.Serialization.XmlElementAttributes use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlElements"
		end

	frozen get_xml_root: SYSTEM_XML_XML_ROOT_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlRootAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlRoot"
		end

	frozen get_xml_any_elements: SYSTEM_XML_XML_ANY_ELEMENT_ATTRIBUTES is
		external
			"IL signature (): System.Xml.Serialization.XmlAnyElementAttributes use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlAnyElements"
		end

	frozen get_xml_attribute: SYSTEM_XML_XML_ATTRIBUTE_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlAttributeAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlAttribute"
		end

	frozen get_xml_any_attribute: SYSTEM_XML_XML_ANY_ATTRIBUTE_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlAnyAttributeAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlAnyAttribute"
		end

	frozen get_xmlns: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlAttributes"
		alias
			"get_Xmlns"
		end

	frozen get_xml_type: SYSTEM_XML_XML_TYPE_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlTypeAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlType"
		end

	frozen get_xml_choice_identifier: SYSTEM_XML_XML_CHOICE_IDENTIFIER_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlChoiceIdentifierAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlChoiceIdentifier"
		end

	frozen get_xml_ignore: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlIgnore"
		end

	frozen get_xml_array_items: SYSTEM_XML_XML_ARRAY_ITEM_ATTRIBUTES is
		external
			"IL signature (): System.Xml.Serialization.XmlArrayItemAttributes use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlArrayItems"
		end

	frozen get_xml_array: SYSTEM_XML_XML_ARRAY_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Serialization.XmlArrayAttribute use System.Xml.Serialization.XmlAttributes"
		alias
			"get_XmlArray"
		end

feature -- Element Change

	frozen set_xml_enum (value: SYSTEM_XML_XML_ENUM_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlEnumAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlEnum"
		end

	frozen set_xml_text (value: SYSTEM_XML_XML_TEXT_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlTextAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlText"
		end

	frozen set_xml_type (value: SYSTEM_XML_XML_TYPE_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlType"
		end

	frozen set_xmlns (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_Xmlns"
		end

	frozen set_xml_default_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlDefaultValue"
		end

	frozen set_xml_root (value: SYSTEM_XML_XML_ROOT_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlRootAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlRoot"
		end

	frozen set_xml_ignore (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlIgnore"
		end

	frozen set_xml_any_attribute (value: SYSTEM_XML_XML_ANY_ATTRIBUTE_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlAnyAttributeAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlAnyAttribute"
		end

	frozen set_xml_attribute (value: SYSTEM_XML_XML_ATTRIBUTE_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlAttributeAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlAttribute"
		end

	frozen set_xml_array (value: SYSTEM_XML_XML_ARRAY_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Serialization.XmlArrayAttribute): System.Void use System.Xml.Serialization.XmlAttributes"
		alias
			"set_XmlArray"
		end

end -- class SYSTEM_XML_XML_ATTRIBUTES
