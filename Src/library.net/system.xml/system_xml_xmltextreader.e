indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlTextReader"

external class
	SYSTEM_XML_XMLTEXTREADER

inherit
	SYSTEM_XML_XMLREADER
	SYSTEM_XML_IXMLLINEINFO
		rename
			has_line_info as system_xml_ixml_line_info_has_line_info
		end

create
	make_xmltextreader_5,
	make_xmltextreader_4,
	make_xmltextreader_7,
	make_xmltextreader_6,
	make_xmltextreader_10,
	make_xmltextreader_9,
	make_xmltextreader_8,
	make_xmltextreader_11,
	make_xmltextreader,
	make_xmltextreader_1,
	make_xmltextreader_3,
	make_xmltextreader_2

feature {NONE} -- Initialization

	frozen make_xmltextreader_5 (url: STRING; input: SYSTEM_IO_TEXTREADER) is
		external
			"IL creator signature (System.String, System.IO.TextReader) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_4 (input: SYSTEM_IO_TEXTREADER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_7 (url: STRING; input: SYSTEM_IO_TEXTREADER; nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.String, System.IO.TextReader, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_6 (input: SYSTEM_IO_TEXTREADER; nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.IO.TextReader, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_10 (url: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_9 (xml_fragment: STRING; frag_type: SYSTEM_XML_XMLNODETYPE; context: SYSTEM_XML_XMLPARSERCONTEXT) is
		external
			"IL creator signature (System.String, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_8 (xml_fragment: SYSTEM_IO_STREAM; frag_type: SYSTEM_XML_XMLNODETYPE; context: SYSTEM_XML_XMLPARSERCONTEXT) is
		external
			"IL creator signature (System.IO.Stream, System.Xml.XmlNodeType, System.Xml.XmlParserContext) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_11 (url: STRING; nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.String, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader (input: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_1 (url: STRING; input: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.String, System.IO.Stream) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_3 (url: STRING; input: SYSTEM_IO_STREAM; nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.String, System.IO.Stream, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

	frozen make_xmltextreader_2 (input: SYSTEM_IO_STREAM; nt: SYSTEM_XML_XMLNAMETABLE) is
		external
			"IL creator signature (System.IO.Stream, System.Xml.XmlNameTable) use System.Xml.XmlTextReader"
		end

feature -- Access

	get_base_uri: STRING is
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

	get_item_string_string (name: STRING; namespace_uri: STRING): STRING is
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

	get_prefix: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_Prefix"
		end

	get_name: STRING is
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

	get_read_state: SYSTEM_XML_READSTATE is
		external
			"IL signature (): System.Xml.ReadState use System.Xml.XmlTextReader"
		alias
			"get_ReadState"
		end

	get_node_type: SYSTEM_XML_XMLNODETYPE is
		external
			"IL signature (): System.Xml.XmlNodeType use System.Xml.XmlTextReader"
		alias
			"get_NodeType"
		end

	frozen get_whitespace_handling: SYSTEM_XML_WHITESPACEHANDLING is
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

	get_local_name: STRING is
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

	get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_Value"
		end

	get_item_string (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"get_Item"
		end

	get_xml_space: SYSTEM_XML_XMLSPACE is
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

	frozen get_encoding: SYSTEM_TEXT_ENCODING is
		external
			"IL signature (): System.Text.Encoding use System.Xml.XmlTextReader"
		alias
			"get_Encoding"
		end

	get_namespace_uri: STRING is
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

	get_item (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlTextReader"
		alias
			"get_Item"
		end

	get_xml_lang: STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextReader"
		alias
			"get_XmlLang"
		end

	get_name_table: SYSTEM_XML_XMLNAMETABLE is
		external
			"IL signature (): System.Xml.XmlNameTable use System.Xml.XmlTextReader"
		alias
			"get_NameTable"
		end

feature -- Element Change

	frozen set_xml_resolver (value: SYSTEM_XML_XMLRESOLVER) is
		external
			"IL signature (System.Xml.XmlResolver): System.Void use System.Xml.XmlTextReader"
		alias
			"set_XmlResolver"
		end

	frozen set_whitespace_handling (value: SYSTEM_XML_WHITESPACEHANDLING) is
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

	get_attribute_int32 (i: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	read_inner_xml: STRING is
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

	get_attribute_string_string (local_name: STRING; namespace_uri: STRING): STRING is
		external
			"IL signature (System.String, System.String): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	move_to_attribute (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToAttribute"
		end

	frozen read_base64 (array: ARRAY [INTEGER_8]; offset: INTEGER; len: INTEGER): INTEGER is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Int32 use System.Xml.XmlTextReader"
		alias
			"ReadBase64"
		end

	move_to_attribute_string_string (local_name: STRING; namespace_uri: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlTextReader"
		alias
			"MoveToAttribute"
		end

	frozen read_chars (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER): INTEGER is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Int32 use System.Xml.XmlTextReader"
		alias
			"ReadChars"
		end

	frozen read_bin_hex (array: ARRAY [INTEGER_8]; offset: INTEGER; len: INTEGER): INTEGER is
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

	read_outer_xml: STRING is
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

	lookup_namespace (prefix_: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"LookupNamespace"
		end

	frozen get_remainder: SYSTEM_IO_TEXTREADER is
		external
			"IL signature (): System.IO.TextReader use System.Xml.XmlTextReader"
		alias
			"GetRemainder"
		end

	get_attribute (name: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextReader"
		alias
			"GetAttribute"
		end

	read_string: STRING is
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

end -- class SYSTEM_XML_XMLTEXTREADER
