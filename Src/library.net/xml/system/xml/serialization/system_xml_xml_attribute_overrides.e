indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlAttributeOverrides"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ATTRIBUTE_OVERRIDES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlAttributeOverrides"
		end

feature -- Access

	frozen get_item (type: TYPE): SYSTEM_XML_XML_ATTRIBUTES is
		external
			"IL signature (System.Type): System.Xml.Serialization.XmlAttributes use System.Xml.Serialization.XmlAttributeOverrides"
		alias
			"get_Item"
		end

	frozen get_item_type_string (type: TYPE; member: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTES is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.XmlAttributes use System.Xml.Serialization.XmlAttributeOverrides"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen add (type: TYPE; attributes: SYSTEM_XML_XML_ATTRIBUTES) is
		external
			"IL signature (System.Type, System.Xml.Serialization.XmlAttributes): System.Void use System.Xml.Serialization.XmlAttributeOverrides"
		alias
			"Add"
		end

	frozen add_type_string (type: TYPE; member: SYSTEM_STRING; attributes: SYSTEM_XML_XML_ATTRIBUTES) is
		external
			"IL signature (System.Type, System.String, System.Xml.Serialization.XmlAttributes): System.Void use System.Xml.Serialization.XmlAttributeOverrides"
		alias
			"Add"
		end

end -- class SYSTEM_XML_XML_ATTRIBUTE_OVERRIDES
