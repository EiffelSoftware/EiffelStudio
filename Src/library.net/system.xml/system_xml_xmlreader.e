indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlReader"

deferred external class
	SYSTEM_XML_XMLREADER

feature -- Access

	get_base_uri: STRING is
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

	get_item_string_string (name: STRING; namespace_uri: STRING): STRING is
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

	get_prefix: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_Prefix"
		end

	get_name: STRING is
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

	get_read_state: SYSTEM_XML_READSTATE is
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

	get_node_type: SYSTEM_XML_XMLNODETYPE is
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

	get_local_name: STRING is
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

	get_item_string (name: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XMLSPACE is
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

	get_value: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_Value"
		end

	get_namespace_uri: STRING is
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

	get_item (i: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Xml.XmlReader"
		alias
			"get_Item"
		end

	get_xml_lang: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL deferred signature (): System.Xml.XmlNameTable use System.Xml.XmlReader"
		alias
			"get_NameTable"
		end

feature -- Basic Operations

	get_attribute_int32 (i: INTEGER): STRING is
		external
			"IL deferred signature (System.Int32): System.String use System.Xml.XmlReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToAttribute"
		end

	read_start_element_string (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlReader"
		alias
			"ReadStartElement"
		end

	read_inner_xml: STRING is
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

	read_element_string: STRING is
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

	get_attribute (name: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"GetAttribute"
		end

	lookup_namespace (prefix_: STRING): STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"LookupNamespace"
		end

	read_element_string_string_string (localname: STRING; ns: STRING): STRING is
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

	is_start_element_string (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsStartElement"
		end

	frozen is_name_token (str: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsNameToken"
		end

	is_start_element_string_string (localname: STRING; ns: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"IsStartElement"
		end

	read_element_string_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlReader"
		alias
			"ReadElementString"
		end

	move_to_content: SYSTEM_XML_XMLNODETYPE is
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

	read_outer_xml: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlReader"
		alias
			"ReadOuterXml"
		end

	frozen is_name (str: STRING): BOOLEAN is
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

	move_to_attribute_string_string (name: STRING; ns: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String, System.String): System.Boolean use System.Xml.XmlReader"
		alias
			"MoveToAttribute"
		end

	get_attribute_string_string (name: STRING; namespace_uri: STRING): STRING is
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

	read_start_element_string_string (localname: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlReader"
		alias
			"ReadStartElement"
		end

	read_string: STRING is
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

end -- class SYSTEM_XML_XMLREADER
