indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ATTRIBUTE

inherit
	SYSTEM_XML_XML_NODE
		redefine
			get_base_uri,
			set_inner_xml,
			get_inner_xml,
			set_inner_text,
			get_inner_text,
			set_prefix,
			get_prefix,
			get_namespace_uri,
			get_owner_document,
			get_parent_node,
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

	get_owner_element: SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (): System.Xml.XmlElement use System.Xml.XmlAttribute"
		alias
			"get_OwnerElement"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_Value"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_Prefix"
		end

	get_parent_node: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlAttribute"
		alias
			"get_ParentNode"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_LocalName"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_BaseURI"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_NamespaceURI"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_InnerXml"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlAttribute"
		alias
			"get_NodeType"
		end

	get_specified: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlAttribute"
		alias
			"get_Specified"
		end

	get_owner_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlAttribute"
		alias
			"get_OwnerDocument"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlAttribute"
		alias
			"get_InnerText"
		end

feature -- Element Change

	set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlAttribute"
		alias
			"set_Prefix"
		end

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlAttribute"
		alias
			"set_InnerXml"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlAttribute"
		alias
			"set_Value"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlAttribute"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlAttribute"
		alias
			"WriteContentTo"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlAttribute"
		alias
			"CloneNode"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlAttribute"
		alias
			"WriteTo"
		end

end -- class SYSTEM_XML_XML_ATTRIBUTE
