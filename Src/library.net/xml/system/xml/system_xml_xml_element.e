indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlElement"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_ELEMENT

inherit
	SYSTEM_XML_XML_LINKED_NODE
		redefine
			remove_all,
			set_inner_xml,
			get_inner_xml,
			set_inner_text,
			get_inner_text,
			set_prefix,
			get_prefix,
			get_namespace_uri,
			get_owner_document,
			get_attributes,
			get_next_sibling
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

	get_next_sibling: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlElement"
		alias
			"get_NextSibling"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_Name"
		end

	frozen get_is_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlElement"
		alias
			"get_IsEmpty"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_Prefix"
		end

	get_has_attributes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlElement"
		alias
			"get_HasAttributes"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_LocalName"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_NamespaceURI"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlElement"
		alias
			"get_NodeType"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_InnerXml"
		end

	get_attributes: SYSTEM_XML_XML_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Xml.XmlAttributeCollection use System.Xml.XmlElement"
		alias
			"get_Attributes"
		end

	get_owner_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlElement"
		alias
			"get_OwnerDocument"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_InnerText"
		end

feature -- Element Change

	frozen set_is_empty (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlElement"
		alias
			"set_IsEmpty"
		end

	set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_Prefix"
		end

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_InnerXml"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	get_elements_by_tag_name (name: SYSTEM_STRING): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlElement"
		alias
			"GetElementsByTagName"
		end

	has_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlElement"
		alias
			"HasAttribute"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlElement"
		alias
			"WriteTo"
		end

	set_attribute_string_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING; value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String, System.String): System.String use System.Xml.XmlElement"
		alias
			"SetAttribute"
		end

	get_elements_by_tag_name_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNodeList use System.Xml.XmlElement"
		alias
			"GetElementsByTagName"
		end

	get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlElement"
		alias
			"GetAttribute"
		end

	remove_attribute_node (old_attr: SYSTEM_XML_XML_ATTRIBUTE): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"RemoveAttributeNode"
		end

	get_attribute_node (name: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"GetAttributeNode"
		end

	get_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlElement"
		alias
			"GetAttribute"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlElement"
		alias
			"CloneNode"
		end

	remove_all_attributes is
		external
			"IL signature (): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAllAttributes"
		end

	set_attribute_node_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"SetAttributeNode"
		end

	set_attribute (name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlElement"
		alias
			"SetAttribute"
		end

	remove_all is
		external
			"IL signature (): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAll"
		end

	remove_attribute_at (i: INTEGER): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlElement"
		alias
			"RemoveAttributeAt"
		end

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlElement"
		alias
			"WriteContentTo"
		end

	remove_attribute (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAttribute"
		end

	set_attribute_node (new_attr: SYSTEM_XML_XML_ATTRIBUTE): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"SetAttributeNode"
		end

	has_attribute (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlElement"
		alias
			"HasAttribute"
		end

	remove_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAttribute"
		end

	remove_attribute_node_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"RemoveAttributeNode"
		end

	get_attribute_node_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_XML_XML_ATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"GetAttributeNode"
		end

end -- class SYSTEM_XML_XML_ELEMENT
