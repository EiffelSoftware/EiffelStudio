indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlText"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_TEXT

inherit
	SYSTEM_XML_XML_CHARACTER_DATA
		redefine
			set_value,
			get_value
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_IXPATH_NAVIGABLE

create {NONE}

feature -- Access

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_Value"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_LocalName"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlText"
		alias
			"get_NodeType"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlText"
		alias
			"get_Name"
		end

feature -- Element Change

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlText"
		alias
			"set_Value"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlText"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlText"
		alias
			"CloneNode"
		end

	split_text (offset: INTEGER): SYSTEM_XML_XML_TEXT is
		external
			"IL signature (System.Int32): System.Xml.XmlText use System.Xml.XmlText"
		alias
			"SplitText"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlText"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_TEXT
