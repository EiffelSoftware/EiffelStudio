indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlTextWriter"

external class
	SYSTEM_XML_XMLTEXTWRITER

inherit
	SYSTEM_XML_XMLWRITER

create
	make_xmltextwriter_2,
	make_xmltextwriter_1,
	make_xmltextwriter

feature {NONE} -- Initialization

	frozen make_xmltextwriter_2 (w: SYSTEM_IO_TEXTWRITER) is
		external
			"IL creator signature (System.IO.TextWriter) use System.Xml.XmlTextWriter"
		end

	frozen make_xmltextwriter_1 (filename: STRING; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.String, System.Text.Encoding) use System.Xml.XmlTextWriter"
		end

	frozen make_xmltextwriter (w: SYSTEM_IO_STREAM; encoding: SYSTEM_TEXT_ENCODING) is
		external
			"IL creator signature (System.IO.Stream, System.Text.Encoding) use System.Xml.XmlTextWriter"
		end

feature -- Access

	get_xml_lang: STRING is
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

	get_write_state: SYSTEM_XML_WRITESTATE is
		external
			"IL signature (): System.Xml.WriteState use System.Xml.XmlTextWriter"
		alias
			"get_WriteState"
		end

	get_xml_space: SYSTEM_XML_XMLSPACE is
		external
			"IL signature (): System.Xml.XmlSpace use System.Xml.XmlTextWriter"
		alias
			"get_XmlSpace"
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

	write_start_attribute_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING) is
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

	write_base64 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
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

	write_chars (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteChars"
		end

	write_name (name: STRING) is
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

	write_doc_type (name: STRING; pubid: STRING; sysid: STRING; subset: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteDocType"
		end

	lookup_prefix (ns: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.XmlTextWriter"
		alias
			"LookupPrefix"
		end

	write_raw_array_char (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
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

	write_start_element_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteStartElement"
		end

	write_comment (text: STRING) is
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

	write_qualified_name (local_name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteQualifiedName"
		end

	write_processing_instruction (name: STRING; text: STRING) is
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

	write_raw (data: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteRaw"
		end

	write_string (text: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteString"
		end

	write_entity_ref (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteEntityRef"
		end

	write_bin_hex (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteBinHex"
		end

	write_cdata (text: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlTextWriter"
		alias
			"WriteCData"
		end

	write_whitespace (ws: STRING) is
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

	write_nm_token (name: STRING) is
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

end -- class SYSTEM_XML_XMLTEXTWRITER
