indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlReader"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_READER

inherit
	SYSTEM_OBJECT

feature -- Access

	get_base_uri: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_BaseURI"
		end

	get_depth: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.XmlReader"
		alias
			"get_Depth"
		end

	get_item_string_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.Xml.XmlReader"
		alias
			"get_Item"
		end

	get_attribute_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Xml.XmlReader"
		alias
			"get_AttributeCount"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_Prefix"
		end

	get_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_Name"
		end

	get_is_empty_element: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_IsEmptyElement"
		end

	get_read_state: SYSTEM_XML_READ_STATE is
		external
			"IL deferred signature (): System.Xml.ReadState use System.Xml.XmlReader"
		alias
			"get_ReadState"
		end

	get_has_attributes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_HasAttributes"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL deferred signature (): System.Xml.XmlNodeType use System.Xml.XmlReader"
		alias
			"get_NodeType"
		end

	get_quote_char: CHARACTER is
		external
			"IL deferred signature (): System.Char use System.Xml.XmlReader"
		alias
			"get_QuoteChar"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_LocalName"
		end

	get_eof: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_EOF"
		end

	get_can_resolve_entity: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_CanResolveEntity"
		end

	get_item_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL deferred signature (): System.Xml.XmlSpace use System.Xml.XmlReader"
		alias
			"get_XmlSpace"
		end

	get_is_default: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_IsDefault"
		end

	get_value: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_Value"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_NamespaceURI"
		end

	get_has_value: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"get_HasValue"
		end

	get_item (i: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Xml.XmlReader"
		alias
			"get_Item"
		end

	get_xml_lang: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL deferred signature (): System.Xml.XmlNameTable use System.Xml.XmlReader"
		alias
			"get_NameTable"
		end

feature -- Basic Operations

	get_attribute_int32 (i: INTEGER): SYSTEM_STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Xml.XmlReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToAttribute"
		end

	read_start_element_string (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlReader"
		alias
			"ReadStartElement"
		end

	read_inner_xml: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"ReadInnerXml"
		end

	read_attribute_value: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"ReadAttributeValue"
		end

	read: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"Read"
		end

	read_element_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlReader"
		alias
			"ReadElementString"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlReader"
		alias
			"Close"
		end

	move_to_attribute_int32 (i: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Xml.XmlReader"
		alias
			"MoveToAttribute"
		end

	get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"GetAttribute"
		end

	lookup_namespace (prefix_: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"LookupNamespace"
		end

	read_element_string_string_string (localname: SYSTEM_STRING; ns: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlReader"
		alias
			"ReadElementString"
		end

	skip is
		external
			"IL signature (): System.Void use System.Xml.XmlReader"
		alias
			"Skip"
		end

	read_end_element is
		external
			"IL signature (): System.Void use System.Xml.XmlReader"
		alias
			"ReadEndElement"
		end

	is_start_element_string (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsStartElement"
		end

	frozen is_name_token (str: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsNameToken"
		end

	is_start_element_string_string (localname: SYSTEM_STRING; ns: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsStartElement"
		end

	read_element_string_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"ReadElementString"
		end

	move_to_content: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlReader"
		alias
			"MoveToContent"
		end

	move_to_first_attribute: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToFirstAttribute"
		end

	move_to_next_attribute: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToNextAttribute"
		end

	read_outer_xml: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"ReadOuterXml"
		end

	frozen is_name (str: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsName"
		end

	resolve_entity is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlReader"
		alias
			"ResolveEntity"
		end

	move_to_attribute_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING): BOOLEAN is
		external
			"IL deferred signature (System.String, System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToAttribute"
		end

	get_attribute_string_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String, System.String): System.String use System.Xml.XmlReader"
		alias
			"GetAttribute"
		end

	read_start_element is
		external
			"IL signature (): System.Void use System.Xml.XmlReader"
		alias
			"ReadStartElement"
		end

	read_start_element_string_string (localname: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlReader"
		alias
			"ReadStartElement"
		end

	read_string: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"ReadString"
		end

	move_to_element: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToElement"
		end

	is_start_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlReader"
		alias
			"IsStartElement"
		end

end -- class SYSTEM_XML_XML_READER
