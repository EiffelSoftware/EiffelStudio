indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlEntityReference"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ENTITY_REFERENCE

inherit
	SYSTEM_XML_XML_LINKED_NODE
		redefine
			get_base_uri,
			get_is_read_only,
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
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_Value"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_LocalName"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlEntityReference"
		alias
			"get_NodeType"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntityReference"
		alias
			"get_BaseURI"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlEntityReference"
		alias
			"get_IsReadOnly"
		end

feature -- Element Change

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlEntityReference"
		alias
			"set_Value"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntityReference"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlEntityReference"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntityReference"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_ENTITY_REFERENCE
