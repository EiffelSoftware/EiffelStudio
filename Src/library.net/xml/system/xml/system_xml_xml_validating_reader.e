indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlValidatingReader"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_VALIDATING_READER

inherit
	SYSTEM_XML_XML_READER
		redefine
			get_can_resolve_entity
		end
	SYSTEM_XML_IXML_LINE_INFO
		rename
			get_line_position as system_xml_ixml_line_info_get_line_position,
			get_line_number as system_xml_ixml_line_info_get_line_number,
			has_line_info as system_xml_ixml_line_info_has_line_info
		end

create
	make_system_xml_xml_validating_reader,
	make_system_xml_xml_validating_reader_2,
	make_system_xml_xml_validating_reader_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_validating_reader (reader: SYSTEM_XML_XML_READER) is
		external
			"IL creator signature (System.Xml.XmlReader) use System.Xml.XmlValidatingReader"
		end

	frozen make_system_xml_xml_validating_reader_2 (xml_fragment: SYSTEM_STREAM; frag_type: SYSTEM_XML_XML_NODE_TYPE; context: SYSTEM_XML_XML_PARSER_CONTEXT) is
		external
			"IL creator signature (System.IO.Stream, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlValidatingReader"
		end

	frozen make_system_xml_xml_validating_reader_1 (xml_fragment: SYSTEM_STRING; frag_type: SYSTEM_XML_XML_NODE_TYPE; context: SYSTEM_XML_XML_PARSER_CONTEXT) is
		external
			"IL creator signature (System.String, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlValidatingReader"
		end

feature -- Access

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_BaseURI"
		end

	get_depth: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlValidatingReader"
		alias
			"get_Depth"
		end

	frozen get_schema_type: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.XmlValidatingReader"
		alias
			"get_SchemaType"
		end

	frozen get_namespaces: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_Namespaces"
		end

	get_item_string_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Item"
		end

	get_attribute_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlValidatingReader"
		alias
			"get_AttributeCount"
		end

	frozen get_schemas: SYSTEM_XML_XML_SCHEMA_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaCollection use System.Xml.XmlValidatingReader"
		alias
			"get_Schemas"
		end

	frozen get_validation_type: SYSTEM_XML_VALIDATION_TYPE is
		external
			"IL signature (): System.Xml.ValidationType use System.Xml.XmlValidatingReader"
		alias
			"get_ValidationType"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Prefix"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Name"
		end

	get_is_empty_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_IsEmptyElement"
		end

	get_read_state: SYSTEM_XML_READ_STATE is
		external
			"IL signature (): System.Xml.ReadState use System.Xml.XmlValidatingReader"
		alias
			"get_ReadState"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlValidatingReader"
		alias
			"get_NodeType"
		end

	get_quote_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Xml.XmlValidatingReader"
		alias
			"get_QuoteChar"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_LocalName"
		end

	get_eof: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_EOF"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Value"
		end

	get_item_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlValidatingReader"
		alias
			"get_XmlSpace"
		end

	get_is_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_IsDefault"
		end

	frozen get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Xml.XmlValidatingReader"
		alias
			"get_Encoding"
		end

	frozen get_reader: SYSTEM_XML_XML_READER is
		external
			"IL signature (): System.Xml.XmlReader use System.Xml.XmlValidatingReader"
		alias
			"get_Reader"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_NamespaceURI"
		end

	get_has_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_HasValue"
		end

	get_can_resolve_entity: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"get_CanResolveEntity"
		end

	get_item (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_Item"
		end

	frozen get_entity_handling: SYSTEM_XML_ENTITY_HANDLING is
		external
			"IL signature (): System.Xml.EntityHandling use System.Xml.XmlValidatingReader"
		alias
			"get_EntityHandling"
		end

	get_xml_lang: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlValidatingReader"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen remove_validation_event_handler (value: SYSTEM_XML_VALIDATION_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.XmlValidatingReader"
		alias
			"remove_ValidationEventHandler"
		end

	frozen add_validation_event_handler (value: SYSTEM_XML_VALIDATION_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.XmlValidatingReader"
		alias
			"add_ValidationEventHandler"
		end

	frozen set_xml_resolver (value: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.XmlValidatingReader"
		alias
			"set_XmlResolver"
		end

	frozen set_namespaces (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlValidatingReader"
		alias
			"set_Namespaces"
		end

	frozen set_entity_handling (value: SYSTEM_XML_ENTITY_HANDLING) is
		external
			"IL signature (System.Xml.EntityHandling): System.Void use System.Xml.XmlValidatingReader"
		alias
			"set_EntityHandling"
		end

	frozen set_validation_type (value: SYSTEM_XML_VALIDATION_TYPE) is
		external
			"IL signature (System.Xml.ValidationType): System.Void use System.Xml.XmlValidatingReader"
		alias
			"set_ValidationType"
		end

feature -- Basic Operations

	get_attribute_int32 (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlValidatingReader"
		alias
			"GetAttribute"
		end

	read_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"ReadInnerXml"
		end

	read_attribute_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"ReadAttributeValue"
		end

	frozen read_typed_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.XmlValidatingReader"
		alias
			"ReadTypedValue"
		end

	close is
		external
			"IL signature (): System.Void use System.Xml.XmlValidatingReader"
		alias
			"Close"
		end

	get_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlValidatingReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"MoveToAttribute"
		end

	move_to_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"MoveToAttribute"
		end

	move_to_attribute_int32 (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.XmlValidatingReader"
		alias
			"MoveToAttribute"
		end

	read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"Read"
		end

	move_to_first_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"MoveToFirstAttribute"
		end

	move_to_next_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"MoveToNextAttribute"
		end

	read_outer_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"ReadOuterXml"
		end

	resolve_entity is
		external
			"IL signature (): System.Void use System.Xml.XmlValidatingReader"
		alias
			"ResolveEntity"
		end

	lookup_namespace (prefix_: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlValidatingReader"
		alias
			"LookupNamespace"
		end

	get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlValidatingReader"
		alias
			"GetAttribute"
		end

	read_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlValidatingReader"
		alias
			"ReadString"
		end

	move_to_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"MoveToElement"
		end

feature {NONE} -- Implementation

	frozen system_xml_ixml_line_info_has_line_info: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlValidatingReader"
		alias
			"System.Xml.IXmlLineInfo.HasLineInfo"
		end

	frozen system_xml_ixml_line_info_get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlValidatingReader"
		alias
			"System.Xml.IXmlLineInfo.get_LinePosition"
		end

	frozen system_xml_ixml_line_info_get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlValidatingReader"
		alias
			"System.Xml.IXmlLineInfo.get_LineNumber"
		end

end -- class SYSTEM_XML_XML_VALIDATING_READER
