indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlNodeReader"

external class
	SYSTEM_XML_XMLNODEREADER

inherit
	SYSTEM_XML_XMLREADER
		redefine
			get_has_attributes,
			skip,
			get_can_resolve_entity
		end

create
	make_xmlnodereader

feature {NONE} -- Initialization

	frozen make_xmlnodereader (node: SYSTEM_XML_XMLNODE) is
		external
			"IL creator signature (System.Xml.XmlNode) use System.Xml.XmlNodeReader"
		end

feature -- Access

	get_base_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_BaseURI"
		end

	get_depth: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNodeReader"
		alias
			"get_Depth"
		end

	get_item_string_string (name: STRING; namespace_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Item"
		end

	get_attribute_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlNodeReader"
		alias
			"get_AttributeCount"
		end

	get_prefix: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Prefix"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Name"
		end

	get_is_empty_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_IsEmptyElement"
		end

	get_read_state: SYSTEM_XML_READSTATE is
		external
			"IL signature (): System.Xml.ReadState use System.Xml.XmlNodeReader"
		alias
			"get_ReadState"
		end

	get_has_attributes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_HasAttributes"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlNodeReader"
		alias
			"get_NodeType"
		end

	get_quote_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Xml.XmlNodeReader"
		alias
			"get_QuoteChar"
		end

	get_local_name: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_LocalName"
		end

	get_eof: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_EOF"
		end

	get_can_resolve_entity: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_CanResolveEntity"
		end

	get_item_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XMLSPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlNodeReader"
		alias
			"get_XmlSpace"
		end

	get_is_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_IsDefault"
		end

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Value"
		end

	get_namespace_uri: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_NamespaceURI"
		end

	get_has_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"get_HasValue"
		end

	get_item (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlNodeReader"
		alias
			"get_Item"
		end

	get_xml_lang: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlNodeReader"
		alias
			"get_NameTable"
		end

feature -- Basic Operations

	get_attribute_int32 (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlNodeReader"
		alias
			"GetAttribute"
		end

	read_inner_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"ReadInnerXml"
		end

	read_attribute_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"ReadAttributeValue"
		end

	close is
		external
			"IL signature (): System.Void use System.Xml.XmlNodeReader"
		alias
			"Close"
		end

	get_attribute_string_string (name: STRING; namespace_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlNodeReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"MoveToAttribute"
		end

	move_to_attribute_string_string (name: STRING; namespace_uri: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"MoveToAttribute"
		end

	move_to_attribute_int32 (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.XmlNodeReader"
		alias
			"MoveToAttribute"
		end

	read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"Read"
		end

	move_to_first_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"MoveToFirstAttribute"
		end

	move_to_next_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"MoveToNextAttribute"
		end

	read_outer_xml: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"ReadOuterXml"
		end

	skip is
		external
			"IL signature (): System.Void use System.Xml.XmlNodeReader"
		alias
			"Skip"
		end

	resolve_entity is
		external
			"IL signature (): System.Void use System.Xml.XmlNodeReader"
		alias
			"ResolveEntity"
		end

	lookup_namespace (prefix_: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNodeReader"
		alias
			"LookupNamespace"
		end

	get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlNodeReader"
		alias
			"GetAttribute"
		end

	read_string: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlNodeReader"
		alias
			"ReadString"
		end

	move_to_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlNodeReader"
		alias
			"MoveToElement"
		end

end -- class SYSTEM_XML_XMLNODEREADER
