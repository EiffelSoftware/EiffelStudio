indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlElement"

external class
	SYSTEM_XML_XMLELEMENT

inherit
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	SYSTEM_XML_XMLLINKEDNODE
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

create {NONE}

feature -- Access

	get_next_sibling: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlElement"
		alias
			"get_NextSibling"
		end

	get_name: STRING is
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

	get_prefix: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_Prefix"
		end

	frozen get_has_attributes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlElement"
		alias
			"get_HasAttributes"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_LocalName"
		end

	get_namespace_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_NamespaceURI"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlElement"
		alias
			"get_NodeType"
		end

	get_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlElement"
		alias
			"get_InnerXml"
		end

	get_attributes: SYSTEM_XML_XMLATTRIBUTECOLLECTION is
		external
			"IL signature (): System.Xml.XmlAttributeCollection use System.Xml.XmlElement"
		alias
			"get_Attributes"
		end

	get_owner_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlElement"
		alias
			"get_OwnerDocument"
		end

	get_inner_text: STRING is
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

	set_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_Prefix"
		end

	set_inner_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_InnerXml"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	get_elements_by_tag_name (name: STRING): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlElement"
		alias
			"GetElementsByTagName"
		end

	has_attribute_string_string (local_name: STRING; namespace_uri: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlElement"
		alias
			"HasAttribute"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlElement"
		alias
			"WriteTo"
		end

	set_attribute_string_string_string (local_name: STRING; namespace_uri: STRING; value: STRING): STRING is
		external
			"IL signature (System.String, System.String, System.String): System.String use System.Xml.XmlElement"
		alias
			"SetAttribute"
		end

	get_elements_by_tag_name_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String, System.String): System.Xml.XmlNodeList use System.Xml.XmlElement"
		alias
			"GetElementsByTagName"
		end

	get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlElement"
		alias
			"GetAttribute"
		end

	remove_attribute_node (old_attr: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"RemoveAttributeNode"
		end

	get_attribute_node (name: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"GetAttributeNode"
		end

	get_attribute_string_string (local_name: STRING; namespace_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlElement"
		alias
			"GetAttribute"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
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

	set_attribute_node_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"SetAttributeNode"
		end

	set_attribute (name: STRING; value: STRING) is
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

	remove_attribute_at (i: INTEGER): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Int32): System.Xml.XmlNode use System.Xml.XmlElement"
		alias
			"RemoveAttributeAt"
		end

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlElement"
		alias
			"WriteContentTo"
		end

	remove_attribute (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAttribute"
		end

	set_attribute_node (new_attr: SYSTEM_XML_XMLATTRIBUTE): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.Xml.XmlAttribute): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"SetAttributeNode"
		end

	has_attribute (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlElement"
		alias
			"HasAttribute"
		end

	remove_attribute_string_string (local_name: STRING; namespace_uri: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlElement"
		alias
			"RemoveAttribute"
		end

	remove_attribute_node_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"RemoveAttributeNode"
		end

	get_attribute_node_string_string (local_name: STRING; namespace_uri: STRING): SYSTEM_XML_XMLATTRIBUTE is
		external
			"IL signature (System.String, System.String): System.Xml.XmlAttribute use System.Xml.XmlElement"
		alias
			"GetAttributeNode"
		end

end -- class SYSTEM_XML_XMLELEMENT
