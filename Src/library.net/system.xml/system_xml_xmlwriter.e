indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlWriter"

deferred external class
	SYSTEM_XML_XMLWRITER

feature -- Access

	get_write_state: SYSTEM_XML_WRITESTATE is
		external
			"IL deferred signature (): System.Xml.WriteState use System.Xml.XmlWriter"
		alias
			"get_WriteState"
		end

	get_xml_space: SYSTEM_XML_XMLSPACE is
		external
			"IL deferred signature (): System.Xml.XmlSpace use System.Xml.XmlWriter"
		alias
			"get_XmlSpace"
		end

	get_xml_lang: STRING is
		external
			"IL deferred signature (): System.String use System.Xml.XmlWriter"
		alias
			"get_XmlLang"
		end

feature -- Basic Operations

	frozen write_element_string_string_string_string (local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteElementString"
		end

	lookup_prefix (ns: STRING): STRING is
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

	frozen write_start_element (local_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_doc_type (name: STRING; pubid: STRING; sysid: STRING; subset: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteDocType"
		end

	write_base64 (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteBase64"
		end

	write_comment (text: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteComment"
		end

	write_string (text: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteString"
		end

	write_chars (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteChars"
		end

	frozen write_start_element_string_string (local_name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_qualified_name (local_name: STRING; ns: STRING) is
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

	write_node (reader: SYSTEM_XML_XMLREADER; defattr: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlReader, System.Boolean): System.Void use System.Xml.XmlWriter"
		alias
			"WriteNode"
		end

	write_attributes (reader: SYSTEM_XML_XMLREADER; defattr: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlReader, System.Boolean): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributes"
		end

	write_whitespace (ws: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteWhitespace"
		end

	write_nm_token (name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteNmToken"
		end

	write_bin_hex (buffer: ARRAY [INTEGER_8]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Byte[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteBinHex"
		end

	frozen write_start_attribute (local_name: STRING; ns: STRING) is
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

	write_start_attribute_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartAttribute"
		end

	write_name (name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteName"
		end

	write_start_element_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteStartElement"
		end

	write_cdata (text: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteCData"
		end

	write_raw (data: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteRaw"
		end

	frozen write_attribute_string (local_name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttributeString"
		end

	frozen write_attribute_string_string_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING; value: STRING) is
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

	write_raw_array_char (buffer: ARRAY [CHARACTER]; index: INTEGER; count: INTEGER) is
		external
			"IL deferred signature (System.Char[], System.Int32, System.Int32): System.Void use System.Xml.XmlWriter"
		alias
			"WriteRaw"
		end

	frozen write_attribute_string_string_string_string (local_name: STRING; ns: STRING; value: STRING) is
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

	write_processing_instruction (name: STRING; text: STRING) is
		external
			"IL deferred signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteProcessingInstruction"
		end

	write_entity_ref (name: STRING) is
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

	frozen write_attribute (prefix_: STRING; local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteAttribute"
		end

	frozen write_element_string (local_name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.XmlWriter"
		alias
			"WriteElementString"
		end

end -- class SYSTEM_XML_XMLWRITER
