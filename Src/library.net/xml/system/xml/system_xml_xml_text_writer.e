indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlTextWriter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_TEXT_WRITER

inherit
	SYSTEM_XML_XML_WRITER

create
	make_system_xml_xml_text_writer,
	make_system_xml_xml_text_writer_2,
	make_system_xml_xml_text_writer_1

feature {NONE} -- Initialization

	frozen make_system_xml_xml_text_writer (w: SYSTEM_STREAM; encoding: ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.Xml.XmlTextWriter"
		end

	frozen make_system_xml_xml_text_writer_2 (w: TEXT_WRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Xml.XmlTextWriter"
		end

	frozen make_system_xml_xml_text_writer_1 (filename: SYSTEM_STRING; encoding: ENCODING) is
		external
			"IL creator signature (System.String, System.Text.Encoding) use System.Xml.XmlTextWriter"
		end

feature -- Access

	get_xml_lang: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.XmlTextWriter"
		alias
			"get_XmlLang"
		end

	frozen get_formatting: SYSTEM_XML_FORMATTING is
		external
			"IL signature (): System.Xml.Formatting use System.Xml.XmlTextWriter"
		alias
			"get_Formatting"
		end

	frozen get_namespaces: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.XmlTextWriter"
		alias
			"get_Namespaces"
		end

	frozen get_indentation: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.XmlTextWriter"
		alias
			"get_Indentation"
		end

	frozen get_indent_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Xml.XmlTextWriter"
		alias
			"get_IndentChar"
		end

	get_write_state: SYSTEM_XML_WRITE_STATE is
		external
			"IL signature (): System.Xml.WriteState use System.Xml.XmlTextWriter"
		alias
			"get_WriteState"
		end

	get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlTextWriter"
		alias
			"get_XmlSpace"
		end

	frozen get_base_stream: SYSTEM_STREAM is
		external
			"IL signature (): System.IO.Stream use System.Xml.XmlTextWriter"
		alias
			"get_BaseStream"
		end

	frozen get_quote_char: CHARACTER is
		external
			"IL signature (): System.Char use System.Xml.XmlTextWriter"
		alias
			"get_QuoteChar"
		end

feature -- Element Change

	frozen set_indent_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Xml.XmlTextWriter"
		alias
			"set_IndentChar"
		end

	frozen set_formatting (value: SYSTEM_XML_FORMATTING) is
		external
			"IL signature (System.Xml.Formatting): System.Void use System.Xml.XmlTextWriter"
		alias
			"set_Formatting"
		end

	frozen set_indentation (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"set_Indentation"
		end

	frozen set_namespaces (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlTextWriter"
		alias
			"set_Namespaces"
		end

	frozen set_quote_char (value: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Xml.XmlTextWriter"
		alias
			"set_QuoteChar"
		end

feature -- Basic Operations

	write_start_attribute_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteStartAttribute"
		end

	close is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"Close"
		end

	write_base64 (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteBase64"
		end

	write_full_end_element is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteFullEndElement"
		end

	write_chars (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteChars"
		end

	write_name (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteName"
		end

	write_end_document is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteEndDocument"
		end

	write_start_document is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteStartDocument"
		end

	write_doc_type (name: SYSTEM_STRING; pubid: SYSTEM_STRING; sysid: SYSTEM_STRING; subset: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteDocType"
		end

	lookup_prefix (ns: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextWriter"
		alias
			"LookupPrefix"
		end

	write_raw_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteRaw"
		end

	write_start_document_boolean (standalone: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteStartDocument"
		end

	write_start_element_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteStartElement"
		end

	write_comment (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteComment"
		end

	write_surrogate_char_entity (low_char: CHARACTER; high_char: CHARACTER) is
		external
			"IL signature (System.Char, System.Char): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteSurrogateCharEntity"
		end

	flush is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"Flush"
		end

	write_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteQualifiedName"
		end

	write_processing_instruction (name: SYSTEM_STRING; text: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteProcessingInstruction"
		end

	write_end_attribute is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteEndAttribute"
		end

	write_raw (data: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteRaw"
		end

	write_string (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteString"
		end

	write_entity_ref (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteEntityRef"
		end

	write_bin_hex (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteBinHex"
		end

	write_cdata (text: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteCData"
		end

	write_whitespace (ws: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteWhitespace"
		end

	write_char_entity (ch: CHARACTER) is
		external
			"IL signature (System.Char): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteCharEntity"
		end

	write_nm_token (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteNmToken"
		end

	write_end_element is
		external
			"IL signature (): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteEndElement"
		end

end -- class SYSTEM_XML_XML_TEXT_WRITER
