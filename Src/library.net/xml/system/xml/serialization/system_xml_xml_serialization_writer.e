indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationWriter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SERIALIZATION_WRITER

inherit
	SYSTEM_OBJECT

feature {NONE} -- Implementation

	frozen write_null_tag_encoded (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagEncoded"
		end

	frozen write_referenced_elements is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteReferencedElements"
		end

	frozen write_nullable_qualified_name_literal (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableQualifiedNameLiteral"
		end

	frozen from_byte_array_hex (value: NATIVE_ARRAY [INTEGER_8]): SYSTEM_STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromByteArrayHex"
		end

	frozen create_unknown_type_exception_object (o: SYSTEM_OBJECT): EXCEPTION is
		external
			"IL signature (System.Object): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateUnknownTypeException"
		end

	frozen write_potentially_referencing_element_string_string_object_type (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; ambient_type: TYPE) is
		external
			"IL signature (System.String, System.String, System.Object, System.Type): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen from_xml_nm_tokens (nm_tokens: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlNmTokens"
		end

	frozen from_enum (value: INTEGER_64; values: NATIVE_ARRAY [SYSTEM_STRING]; ids: NATIVE_ARRAY [INTEGER_64]): SYSTEM_STRING is
		external
			"IL static signature (System.Int64, System.String[], System.Int64[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromEnum"
		end

	frozen from_date (value: SYSTEM_DATE_TIME): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromDate"
		end

	frozen from_time (value: SYSTEM_DATE_TIME): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromTime"
		end

	frozen write_serializable (serializable: SYSTEM_XML_IXML_SERIALIZABLE; name: SYSTEM_STRING; ns: SYSTEM_STRING; is_nullable: BOOLEAN) is
		external
			"IL signature (System.Xml.Serialization.IXmlSerializable, System.String, System.String, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteSerializable"
		end

	frozen write_element_string_raw_string_string_string_xml_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_typed_primitive (name: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; xsi_type: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteTypedPrimitive"
		end

	frozen write_attribute_string_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen write_element_string (local_name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen write_potentially_referencing_element_string_string_object_type_boolean_boolean (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; ambient_type: TYPE; suppress_reference: BOOLEAN; is_nullable: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Type, System.Boolean, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen write_element_string_string_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen write_element_string_raw_string_array_byte_xml_qualified_name (local_name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.Byte[], System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_attribute (local_name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen write_element_qualified_name_string_string_xml_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen write_element_string_raw (local_name: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_element_string_raw_string_string_xml_qualified_name (local_name: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_nullable_string_literal_raw (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringLiteralRaw"
		end

	frozen write_element_qualified_name_string_xml_qualified_name_xml_qualified_name (local_name: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen write_start_element_string_string_boolean (name: SYSTEM_STRING; ns: SYSTEM_STRING; write_prefixed: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_xml_attribute (node: SYSTEM_XML_XML_NODE) is
		external
			"IL signature (System.Xml.XmlNode): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteXmlAttribute"
		end

	frozen write_end_element_object (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEndElement"
		end

	frozen write_xml_attribute_xml_node_object (node: SYSTEM_XML_XML_NODE; container: SYSTEM_OBJECT) is
		external
			"IL signature (System.Xml.XmlNode, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteXmlAttribute"
		end

	frozen write_element_string_raw_string_array_byte (local_name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_null_tag_encoded_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagEncoded"
		end

	frozen write_referencing_element (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteReferencingElement"
		end

	frozen write_nullable_string_encoded_raw_string_string_array_byte (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Byte[], System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringEncodedRaw"
		end

	frozen write_nullable_string_literal (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringLiteral"
		end

	frozen write_nullable_string_literal_raw_string_string_array_byte (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.String, System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringLiteralRaw"
		end

	frozen write_value_array_byte (value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteValue"
		end

	frozen get_namespaces: ARRAY_LIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"get_Namespaces"
		end

	frozen write_element_string_string_string_string_xml_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen top_level_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"TopLevelElement"
		end

	frozen write_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteValue"
		end

	frozen set_writer (value: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"set_Writer"
		end

	frozen write_attribute_string_string_string_string (prefix_: SYSTEM_STRING; local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen add_write_callback (type: TYPE; type_name: SYSTEM_STRING; type_ns: SYSTEM_STRING; callback: SYSTEM_XML_XML_SERIALIZATION_WRITE_CALLBACK) is
		external
			"IL signature (System.Type, System.String, System.String, System.Xml.Serialization.XmlSerializationWriteCallback): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"AddWriteCallback"
		end

	frozen write_null_tag_literal_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagLiteral"
		end

	frozen write_element_string_raw_string_string_string (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_empty_tag (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEmptyTag"
		end

	init_callbacks is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"InitCallbacks"
		end

	frozen write_start_document is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartDocument"
		end

	frozen from_byte_array_base64 (value: NATIVE_ARRAY [INTEGER_8]): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.Byte[]): System.Byte[] use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromByteArrayBase64"
		end

	frozen write_start_element_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_nullable_qualified_name_encoded (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableQualifiedNameEncoded"
		end

	frozen write_attribute_string_array_byte (local_name: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen write_nullable_string_encoded (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringEncoded"
		end

	frozen from_xml_qualified_name (xml_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME): SYSTEM_STRING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlQualifiedName"
		end

	frozen write_element_string_raw_string_string_array_byte (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.String, System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen from_xml_ncname (nc_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlNCName"
		end

	frozen write_namespace_declarations (xmlns: SYSTEM_XML_XML_SERIALIZER_NAMESPACES) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializerNamespaces): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNamespaceDeclarations"
		end

	frozen write_element_string_string_string_xml_qualified_name (local_name: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen write_potentially_referencing_element_string_string_object_type_boolean (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; ambient_type: TYPE; suppress_reference: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Type, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen create_mismatch_choice_exception (value: SYSTEM_STRING; element_name: SYSTEM_STRING; enum_value: SYSTEM_STRING): EXCEPTION is
		external
			"IL signature (System.String, System.String, System.String): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateMismatchChoiceException"
		end

	frozen create_unknown_any_element_exception (name: SYSTEM_STRING; ns: SYSTEM_STRING): EXCEPTION is
		external
			"IL signature (System.String, System.String): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateUnknownAnyElementException"
		end

	frozen write_empty_tag_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEmptyTag"
		end

	frozen write_element_literal (node: SYSTEM_XML_XML_NODE; name: SYSTEM_STRING; ns: SYSTEM_STRING; is_nullable: BOOLEAN; any: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlNode, System.String, System.String, System.Boolean, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementLiteral"
		end

	frozen write_start_element (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_potentially_referencing_element (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen from_xml_nm_token (nm_token: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlNmToken"
		end

	frozen write_attribute_string_string_array_byte (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.String, System.Byte[]): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen write_start_element_string_string_object_boolean (name: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; write_prefixed: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_id (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteId"
		end

	frozen write_start_element_string_string_object (name: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen get_writer: SYSTEM_XML_XML_WRITER is
		external
			"IL signature (): System.Xml.XmlWriter use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"get_Writer"
		end

	frozen write_nullable_string_encoded_raw (name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_STRING; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringEncodedRaw"
		end

	frozen set_namespaces (value: ARRAY_LIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"set_Namespaces"
		end

	frozen write_element_qualified_name (local_name: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen write_element_qualified_name_string_string_xml_qualified_name_xml_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: SYSTEM_XML_XML_QUALIFIED_NAME; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen from_char (value: CHARACTER): SYSTEM_STRING is
		external
			"IL static signature (System.Char): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromChar"
		end

	frozen write_referencing_element_string_string_object_boolean (n: SYSTEM_STRING; ns: SYSTEM_STRING; o: SYSTEM_OBJECT; is_nullable: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteReferencingElement"
		end

	frozen from_date_time (value: SYSTEM_DATE_TIME): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromDateTime"
		end

	frozen from_xml_name (name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlName"
		end

	frozen write_end_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEndElement"
		end

	frozen create_unknown_type_exception (type: TYPE): EXCEPTION is
		external
			"IL signature (System.Type): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateUnknownTypeException"
		end

	frozen write_element_encoded (node: SYSTEM_XML_XML_NODE; name: SYSTEM_STRING; ns: SYSTEM_STRING; is_nullable: BOOLEAN; any: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlNode, System.String, System.String, System.Boolean, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementEncoded"
		end

	frozen write_xsi_type (name: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteXsiType"
		end

	frozen write_element_string_raw_string_string_array_byte_xml_qualified_name (local_name: SYSTEM_STRING; ns: SYSTEM_STRING; value: NATIVE_ARRAY [INTEGER_8]; xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.String, System.String, System.Byte[], System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_null_tag_literal (name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagLiteral"
		end

end -- class SYSTEM_XML_XML_SERIALIZATION_WRITER
