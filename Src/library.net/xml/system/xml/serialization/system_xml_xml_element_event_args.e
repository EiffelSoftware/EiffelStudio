indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlElementEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ELEMENT_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_LinePosition"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_LineNumber"
		end

	frozen get_element: SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (): System.Xml.XmlElement use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_Element"
		end

	frozen get_object_being_deserialized: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlElementEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

end -- class SYSTEM_XML_XML_ELEMENT_EVENT_ARGS
