indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlNode"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_NODE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
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

feature -- Access

	get_attributes: SYSTEM_XML_XML_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.Xml.XmlAttributeCollection use System.Xml.XmlNode"
		alias
			"get_Attributes"
		end

	get_outer_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_OuterXml"
		end

	get_has_child_nodes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNode"
		alias
			"get_HasChildNodes"
		end

	get_first_child: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_FirstChild"
		end

	get_next_sibling: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_NextSibling"
		end

	get_item_string_string (localname: SYSTEM_STRING; ns: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String, System.String): System.Xml.XmlElement use System.Xml.XmlNode"
		alias
			"get_Item"
		end

	get_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_InnerXml"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL deferred signature (): System.Xml.XmlNodeType use System.Xml.XmlNode"
		alias
			"get_NodeType"
		end

	get_last_child: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_LastChild"
		end

	get_parent_node: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_ParentNode"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlNode"
		alias
			"get_LocalName"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Value"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Prefix"
		end

	get_previous_sibling: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_PreviousSibling"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_NamespaceURI"
		end

	get_item (name: SYSTEM_STRING): SYSTEM_XML_XML_ELEMENT is
		external
			"IL signature (System.String): System.Xml.XmlElement use System.Xml.XmlNode"
		alias
			"get_Item"
		end

	get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNode"
		alias
			"get_IsReadOnly"
		end

	get_inner_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_InnerText"
		end

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_BaseURI"
		end

	get_owner_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlNode"
		alias
			"get_OwnerDocument"
		end

	get_child_nodes: SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"get_ChildNodes"
		end

feature -- Element Change

	set_prefix (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_Prefix"
		end

	set_inner_xml (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_InnerXml"
		end

	set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_Value"
		end

	set_inner_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	get_namespace_of_prefix (prefix_: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNode"
		alias
			"GetNamespaceOfPrefix"
		end

	prepend_child (new_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"PrependChild"
		end

	append_child (new_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"AppendChild"
		end

	normalize is
		external
			"IL signature (): System.Void use System.Xml.XmlNode"
		alias
			"Normalize"
		end

	write_content_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNode"
		alias
			"WriteContentTo"
		end

	get_prefix_of_namespace (namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNode"
		alias
			"GetPrefixOfNamespace"
		end

	frozen select_nodes_string_xml_namespace_manager (xpath: SYSTEM_STRING; nsmgr: SYSTEM_XML_XML_NAMESPACE_MANAGER): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String, System.Xml.XmlNamespaceManager): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"SelectNodes"
		end

	write_to (w: SYSTEM_XML_XML_WRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNode"
		alias
			"WriteTo"
		end

	replace_child (new_child: SYSTEM_XML_XML_NODE; old_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"ReplaceChild"
		end

	frozen select_single_node_string_xml_namespace_manager (xpath: SYSTEM_STRING; nsmgr: SYSTEM_XML_XML_NAMESPACE_MANAGER): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String, System.Xml.XmlNamespaceManager): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"SelectSingleNode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNode"
		alias
			"Equals"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNode"
		alias
			"GetEnumerator"
		end

	frozen select_nodes (xpath: SYSTEM_STRING): SYSTEM_XML_XML_NODE_LIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"SelectNodes"
		end

	remove_child (old_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"RemoveChild"
		end

	clone_: SYSTEM_XML_XML_NODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"Clone"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"ToString"
		end

	frozen create_navigator: SYSTEM_XML_XPATH_NAVIGATOR is
		external
			"IL signature (): System.Xml.XPath.XPathNavigator use System.Xml.XmlNode"
		alias
			"CreateNavigator"
		end

	frozen select_single_node (xpath: SYSTEM_STRING): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"SelectSingleNode"
		end

	insert_after (new_child: SYSTEM_XML_XML_NODE; ref_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"InsertAfter"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL deferred signature (System.Boolean): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"CloneNode"
		end

	remove_all is
		external
			"IL signature (): System.Void use System.Xml.XmlNode"
		alias
			"RemoveAll"
		end

	supports (feature_: SYSTEM_STRING; version: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlNode"
		alias
			"Supports"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNode"
		alias
			"GetHashCode"
		end

	insert_before (new_child: SYSTEM_XML_XML_NODE; ref_child: SYSTEM_XML_XML_NODE): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"InsertBefore"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Xml.XmlNode"
		alias
			"Finalize"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.XmlNode"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNode"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_XML_XML_NODE
