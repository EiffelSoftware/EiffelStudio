indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlWriter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_WRITER

inherit
	SYSTEM_OBJECT

feature -- Access

	get_write_state: SYSTEM_XML_WRITE_STATE is
		external
			"IL deferred signature (): System.Xml.WriteState use System.Xml.XmlWriter"
		alias
			"get_WriteState"
		end

	get_xml_space: SYSTEM_XML_XML_SPACE is
		external
			"IL deferred signature (): System.Xml.XmlSpace use System.Xml.XmlWriter"
		alias
			"get_XmlSpace"
		end

	get_xml_lang: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlWriter"
		alias
			"get_XmlLang"
		end

feature -- Basic Operations

	frozen write_element_string_string_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteElementString"
		end

	lookup_prefix (ns: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL deferred signature (System.String): System.String use System.Xml.XmlWriter"
		alias
			"LookupPrefix"
		end

	write_surrogate_char_entity (low_char: CHARACTER; high_char: CHARACTER) is
		external
			"IL deferred signature (System.Char, System.Char): System.Void use System.Xml.XmlWriter"
		alias
			"WriteSurrogateCharEntity"
		end

	frozen write_start_element (local_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_doc_type (name: SYSTEM_STRING; pubid: SYSTEM_STRING; sysid: SYSTEM_STRING; subset: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteDocType"
		end

	write_base64 (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteBase64"
		end

	write_comment (text: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteComment"
		end

	write_string (text: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteString"
		end

	write_chars (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteChars"
		end

	frozen write_start_element_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteQualifiedName"
		end

	write_start_document is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartDocument"
		end

	write_full_end_element is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"WriteFullEndElement"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"Close"
		end

	write_node (reader: SYSTEM_XML_XML_READER; defattr: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlReader, System.Boolean): System.Void use System.Xml.XmlWriter"
		alias
			"WriteNode"
		end

	write_attributes (reader: SYSTEM_XML_XML_READER; defattr: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlReader, System.Boolean): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributes"
		end

	write_whitespace (ws: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteWhitespace"
		end

	write_nm_token (name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteNmToken"
		end

	write_bin_hex (buffer: NATIVE_ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteBinHex"
		end

	frozen write_start_attribute (local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartAttribute"
		end

	write_char_entity (ch: CHARACTER) is
		external
			"IL deferred signature (System.Char): System.Void use System.Xml.XmlWriter"
		alias
			"WriteCharEntity"
		end

	write_start_attribute_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartAttribute"
		end

	write_name (name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteName"
		end

	write_start_element_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_cdata (text: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteCData"
		end

	write_raw (data: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteRaw"
		end

	frozen write_attribute_string (local_name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributeString"
		end

	frozen write_attribute_string_string_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributeString"
		end

	write_end_document is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"WriteEndDocument"
		end

	write_raw_array_char (buffer: NATIVE_ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteRaw"
		end

	frozen write_attribute_string_string_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributeString"
		end

	write_end_element is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"WriteEndElement"
		end

	write_processing_instruction (name: SYSTEM_STRING; text: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteProcessingInstruction"
		end

	write_entity_ref (name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteEntityRef"
		end

	write_end_attribute is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"WriteEndAttribute"
		end

	write_start_document_boolean (standalone: BOOLEAN) is
		external
			"IL deferred signature (System.Boolean): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartDocument"
		end

	flush is
		external
			"IL deferred signature (): System.Void use System.Xml.XmlWriter"
		alias
			"Flush"
		end

	frozen write_element_string (local_name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteElementString"
		end

end -- class SYSTEM_XML_XML_WRITER
