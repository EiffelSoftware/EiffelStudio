indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlNodeEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_NODE_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_Name"
		end

	frozen get_object_being_deserialized: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_ObjectBeingDeserialized"
		end

	frozen get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_LocalName"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlNodeEventArgs"
		alias
			"get_Text"
		end

	frozen get_namespace_uri: SYSTEM_STRING is
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

	frozen get_node_type: SYSTEM_XML_XML_NODE_TYPE is
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

end -- class SYSTEM_XML_XML_NODE_EVENT_ARGS
