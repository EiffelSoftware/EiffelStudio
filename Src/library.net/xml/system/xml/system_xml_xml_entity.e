indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlEntity"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ENTITY

inherit
	SYSTEM_XML_XML_NODE
		redefine
			get_base_uri,
			set_inner_xml,
			get_inner_xml,
			get_outer_xml,
			set_inner_text,
			get_inner_text,
			get_is_read_only
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

	frozen get_notation_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_NotationName"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_Name"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_LocalName"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_BaseURI"
		end

	frozen get_public_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_PublicId"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlEntity"
		alias
			"get_IsReadOnly"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlEntity"
		alias
			"get_NodeType"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_InnerXml"
		end

	frozen get_system_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_SystemId"
		end

	get_outer_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_OuterXml"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlEntity"
		alias
			"get_InnerText"
		end

feature -- Element Change

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlEntity"
		alias
			"set_InnerXml"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlEntity"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntity"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlEntity"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlEntity"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_ENTITY
