indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlTextReader"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_TEXT_READER

inherit
	SYSTEM_XML_XML_READER
	SYSTEM_XML_IXML_LINE_INFO
		rename
			has_line_info as system_xml_ixml_line_info_has_line_info
		end

create
	make_system_xml_xml_text_reader_7,
	make_system_xml_xml_text_reader_6,
	make_system_xml_xml_text_reader_1,
	make_system_xml_xml_text_reader,
	make_system_xml_xml_text_reader_3,
	make_system_xml_xml_text_reader_2,
	make_system_xml_xml_text_reader_9,
	make_system_xml_xml_text_reader_8,
	make_system_xml_xml_text_reader_10,
	make_system_xml_xml_text_reader_11,
	make_system_xml_xml_text_reader_5,
	make_system_xml_xml_text_reader_4

feature {NONE} -- Initialization

	frozen make_system_xml_xml_text_reader_7 (url: SYSTEM_STRING; input: TEXT_READER; nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.String, System.IO.TextReader, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_6 (input: TEXT_READER; nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.IO.TextReader, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_1 (url: SYSTEM_STRING; input: SYSTEM_STREAM) is
		external
			"IL creator signature (System.String, System.IO.Stream) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader (input: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_3 (url: SYSTEM_STRING; input: SYSTEM_STREAM; nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.String, System.IO.Stream, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_2 (input: SYSTEM_STREAM; nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.IO.Stream, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_9 (xml_fragment: SYSTEM_STRING; frag_type: SYSTEM_XML_XML_NODE_TYPE; context: SYSTEM_XML_XML_PARSER_CONTEXT) is
		external
			"IL creator signature (System.String, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_8 (xml_fragment: SYSTEM_STREAM; frag_type: SYSTEM_XML_XML_NODE_TYPE; context: SYSTEM_XML_XML_PARSER_CONTEXT) is
		external
			"IL creator signature (System.IO.Stream, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_10 (url: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_11 (url: SYSTEM_STRING; nt: SYSTEM_XML_XML_NAME_TABLE) is
		external
			"IL creator signature (System.String, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_5 (url: SYSTEM_STRING; input: TEXT_READER) is
		external
			"IL creator signature (System.String, System.IO.TextReader) use System.Xml.XmlTextReader"
		end

	frozen make_system_xml_xml_text_reader_4 (input: TEXT_READER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Xml.XmlTextReader"
		end

feature -- Access

	get_base_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_BaseURI"
		end

	get_is_empty_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_IsEmptyElement"
		end

	get_has_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_HasValue"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlTextReader"
		alias
			"get_LineNumber"
		end

	get_item_string_string (name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlTextReader"
		alias
			"get_Item"
		end

	get_attribute_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlTextReader"
		alias
			"get_AttributeCount"
		end

	get_prefix: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_Prefix"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_Name"
		end

	get_depth: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlTextReader"
		alias
			"get_Depth"
		end

	get_read_state: SYSTEM_XML_READ_STATE is
		external
			"IL signature (): System.Xml.ReadState use System.Xml.XmlTextReader"
		alias
			"get_ReadState"
		end

	get_node_type: SYSTEM_XML_XML_NODE_TYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlTextReader"
		alias
			"get_NodeType"
		end

	frozen get_whitespace_handling: SYSTEM_XML_WHITESPACE_HANDLING is
		external
			"IL signature (): System.Xml.WhitespaceHandling use System.Xml.XmlTextReader"
		alias
			"get_WhitespaceHandling"
		end

	get_quote_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Xml.XmlTextReader"
		alias
			"get_QuoteChar"
		end

	get_local_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_LocalName"
		end

	get_eof: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_EOF"
		end

	get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_Value"
		end

	get_item_string (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlTextReader"
		alias
			"get_XmlSpace"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlTextReader"
		alias
			"get_LinePosition"
		end

	get_is_default: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_IsDefault"
		end

	frozen get_encoding: ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Xml.XmlTextReader"
		alias
			"get_Encoding"
		end

	get_namespace_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_NamespaceURI"
		end

	frozen get_namespaces: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_Namespaces"
		end

	frozen get_normalization: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"get_Normalization"
		end

	get_item (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlTextReader"
		alias
			"get_Item"
		end

	get_xml_lang: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XML_NAME_TABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlTextReader"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen set_xml_resolver (value: SYSTEM_XML_XML_RESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.XmlTextReader"
		alias
			"set_XmlResolver"
		end

	frozen set_whitespace_handling (value: SYSTEM_XML_WHITESPACE_HANDLING) is
		external
			"IL signature (System.Xml.WhitespaceHandling): System.Void use System.Xml.XmlTextReader"
		alias
			"set_WhitespaceHandling"
		end

	frozen set_namespaces (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlTextReader"
		alias
			"set_Namespaces"
		end

	frozen set_normalization (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlTextReader"
		alias
			"set_Normalization"
		end

feature -- Basic Operations

	get_attribute_int32 (i: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	read_inner_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"ReadInnerXml"
		end

	read_attribute_value: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"ReadAttributeValue"
		end

	close is
		external
			"IL signature (): System.Void use System.Xml.XmlTextReader"
		alias
			"Close"
		end

	get_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToAttribute"
		end

	frozen reset_state is
		external
			"IL signature (): System.Void use System.Xml.XmlTextReader"
		alias
			"ResetState"
		end

	frozen read_base64 (array: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; len: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Xml.XmlTextReader"
		alias
			"ReadBase64"
		end

	move_to_attribute_string_string (local_name: SYSTEM_STRING; namespace_uri: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToAttribute"
		end

	frozen read_chars (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Xml.XmlTextReader"
		alias
			"ReadChars"
		end

	frozen read_bin_hex (array: NATIVE_ARRAY [INTEGER_8]; offset: INTEGER; len: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Xml.XmlTextReader"
		alias
			"ReadBinHex"
		end

	move_to_attribute_int32 (i: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.XmlTextReader"
		alias
			"MoveToAttribute"
		end

	read: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"Read"
		end

	move_to_first_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToFirstAttribute"
		end

	move_to_next_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToNextAttribute"
		end

	read_outer_xml: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"ReadOuterXml"
		end

	resolve_entity is
		external
			"IL signature (): System.Void use System.Xml.XmlTextReader"
		alias
			"ResolveEntity"
		end

	lookup_namespace (prefix_: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"LookupNamespace"
		end

	frozen get_remainder: TEXT_READER is
		external
			"IL signature (): System.IO.TextReader use System.Xml.XmlTextReader"
		alias
			"GetRemainder"
		end

	get_attribute (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	read_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"ReadString"
		end

	move_to_element: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToElement"
		end

feature {NONE} -- Implementation

	frozen system_xml_ixml_line_info_has_line_info: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextReader"
		alias
			"System.Xml.IXmlLineInfo.HasLineInfo"
		end

end -- class SYSTEM_XML_XML_TEXT_READER
