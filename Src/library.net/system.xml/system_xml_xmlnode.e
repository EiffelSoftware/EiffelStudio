indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNode"

deferred external class
	SYSTEM_XML_XMLNODE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_XML_XPATH_IXPATHNAVIGABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

feature -- Access

	get_attributes: SYSTEM_XML_XMLATTRIBUTECOLLECTION is
		external
			"IL signature (): System.Xml.XmlAttributeCollection use System.Xml.XmlNode"
		alias
			"get_Attributes"
		end

	get_outer_xml: STRING is
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

	get_first_child: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_FirstChild"
		end

	get_next_sibling: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_NextSibling"
		end

	get_item_string_string (localname: STRING; ns: STRING): SYSTEM_XML_XMLELEMENT is
		external
			"IL signature (System.String, System.String): System.Xml.XmlElement use System.Xml.XmlNode"
		alias
			"get_Item"
		end

	get_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_InnerXml"
		end

	get_name: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Name"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL deferred signature (): System.Xml.XmlNodeType use System.Xml.XmlNode"
		alias
			"get_NodeType"
		end

	get_last_child: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_LastChild"
		end

	get_parent_node: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_ParentNode"
		end

	get_local_name: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlNode"
		alias
			"get_LocalName"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Value"
		end

	get_prefix: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_Prefix"
		end

	get_previous_sibling: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"get_PreviousSibling"
		end

	get_namespace_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_NamespaceURI"
		end

	get_item (name: STRING): SYSTEM_XML_XMLELEMENT is
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

	get_inner_text: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_InnerText"
		end

	get_base_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"get_BaseURI"
		end

	get_owner_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlNode"
		alias
			"get_OwnerDocument"
		end

	get_child_nodes: SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"get_ChildNodes"
		end

feature -- Element Change

	set_prefix (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_Prefix"
		end

	set_inner_xml (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_InnerXml"
		end

	set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_Value"
		end

	set_inner_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlNode"
		alias
			"set_InnerText"
		end

feature -- Basic Operations

	get_namespace_of_prefix (prefix_: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNode"
		alias
			"GetNamespaceOfPrefix"
		end

	prepend_child (new_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"PrependChild"
		end

	append_child (new_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
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

	write_content_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNode"
		alias
			"WriteContentTo"
		end

	get_prefix_of_namespace (namespace_uri: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNode"
		alias
			"GetPrefixOfNamespace"
		end

	clone: SYSTEM_XML_XMLNODE is
		external
			"IL signature (): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"Clone"
		end

	frozen select_nodes_string_xml_namespace_manager (xpath: STRING; nsmgr: SYSTEM_XML_XMLNAMESPACEMANAGER): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String, System.Xml.XmlNamespaceManager): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"SelectNodes"
		end

	write_to (w: SYSTEM_XML_XMLWRITER) is
		external
			"IL deferred signature (System.Xml.XmlWriter): System.Void use System.Xml.XmlNode"
		alias
			"WriteTo"
		end

	replace_child (new_child: SYSTEM_XML_XMLNODE; old_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"ReplaceChild"
		end

	frozen select_single_node_string_xml_namespace_manager (xpath: STRING; nsmgr: SYSTEM_XML_XMLNAMESPACEMANAGER): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String, System.Xml.XmlNamespaceManager): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"SelectSingleNode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Xml.XmlNode"
		alias
			"Equals"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNode"
		alias
			"GetEnumerator"
		end

	frozen select_nodes (xpath: STRING): SYSTEM_XML_XMLNODELIST is
		external
			"IL signature (System.String): System.Xml.XmlNodeList use System.Xml.XmlNode"
		alias
			"SelectNodes"
		end

	remove_child (old_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"RemoveChild"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNode"
		alias
			"ToString"
		end

	frozen create_navigator: SYSTEM_XML_XPATH_XPATHNAVIGATOR is
		external
			"IL signature (): System.Xml.XPath.XPathNavigator use System.Xml.XmlNode"
		alias
			"CreateNavigator"
		end

	frozen select_single_node (xpath: STRING): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.String): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"SelectSingleNode"
		end

	insert_after (new_child: SYSTEM_XML_XMLNODE; ref_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Xml.XmlNode, System.Xml.XmlNode): System.Xml.XmlNode use System.Xml.XmlNode"
		alias
			"InsertAfter"
		end

	clone_node (deep: BOOLEAN): SYSTEM_XML_XMLNODE is
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

	supports (feature_: STRING; version: STRING): BOOLEAN is
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

	insert_before (new_child: SYSTEM_XML_XMLNODE; ref_child: SYSTEM_XML_XMLNODE): SYSTEM_XML_XMLNODE is
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

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Xml.XmlNode"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Xml.XmlNode"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_XML_XMLNODE
