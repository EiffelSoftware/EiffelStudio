indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlAttributeEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ATTRIBUTE_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_LinePosition"
		end

	frozen get_object_being_deserialized: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

	frozen get_attr: SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (): System.Xml.XmlAttribute use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_Attr"
		end

end -- class SYSTEM_XML_XML_ATTRIBUTE_EVENT_ARGS
