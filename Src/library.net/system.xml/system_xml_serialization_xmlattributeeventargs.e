indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAttributeEventArgs"

external class
	SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTARGS

inherit
	SYSTEM_EVENTARGS

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

	frozen get_object_being_deserialized: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

	frozen get_attr: SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (): System.Xml.XmlAttribute use System.Xml.Serialization.XmlAttributeEventArgs"
		alias
			"get_Attr"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTARGS
