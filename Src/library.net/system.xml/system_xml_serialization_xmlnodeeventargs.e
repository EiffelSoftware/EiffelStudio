indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlNodeEventArgs"

external class
	SYSTEM_XML_SERIALIZATION_XMLNODEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_Name"
		end

	frozen get_object_being_deserialized: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

	frozen get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_LocalName"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_Text"
		end

	frozen get_namespace_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_NamespaceURI"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_LinePosition"
		end

	frozen get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_NodeType"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_LineNumber"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLNODEEVENTARGS
