indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationWriter"

deferred external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONWRITER

feature {NONE} -- Implementation

	frozen write_serializable (serializable: SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE; name: STRING; ns: STRING; is_nullable: BOOLEAN) is
		external
			"IL signature (System.Xml.Serialization.IXmlSerializable, System.String, System.String, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteSerializable"
		end

	frozen write_nullable_string_literal_raw (name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringLiteralRaw"
		end

	frozen set_namespaces (value: SYSTEM_COLLECTIONS_ARRAYLIST) is
		external
			"IL signature (System.Collections.ArrayList): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"set_Namespaces"
		end

	frozen write_null_tag_literal (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagLiteral"
		end

	frozen write_element_string (local_name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen create_unknown_type_exception (type: SYSTEM_TYPE): SYSTEM_EXCEPTION is
		external
			"IL signature (System.Type): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateUnknownTypeException"
		end

	frozen from_byte_array (value: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromByteArray"
		end

	frozen write_xsi_type (name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteXsiType"
		end

	frozen write_start_element (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_potentially_referencing_element_string_string_object_type (n: STRING; ns: STRING; o: ANY; ambient_type: SYSTEM_TYPE) is
		external
			"IL signature (System.String, System.String, System.Object, System.Type): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen write_element_string_string_string_string_xml_qualified_name (local_name: STRING; ns: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen write_referencing_element (n: STRING; ns: STRING; o: ANY) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteReferencingElement"
		end

	frozen write_element_string_raw_string_string_string_xml_qualified_name (local_name: STRING; ns: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_typed_primitive (name: STRING; ns: STRING; o: ANY; xsi_type: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteTypedPrimitive"
		end

	frozen from_byte_array_base64 (value: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromByteArrayBase64"
		end

	frozen write_element_qualified_name_string_string_xml_qualified_name_xml_qualified_name (local_name: STRING; ns: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen add_write_callback (type: SYSTEM_TYPE; type_name: STRING; type_ns: STRING; callback: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONWRITECALLBACK) is
		external
			"IL signature (System.Type, System.String, System.String, System.Xml.Serialization.XmlSerializationWriteCallback): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"AddWriteCallback"
		end

	frozen write_null_tag_encoded_string_string (name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagEncoded"
		end

	frozen write_null_tag_literal_string_string (name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagLiteral"
		end

	frozen write_start_element_string_string (name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen from_time (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromTime"
		end

	frozen set_writer (value: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"set_Writer"
		end

	frozen write_start_element_string_string_object (name: STRING; ns: STRING; o: ANY) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_element_qualified_name (local_name: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen write_xml_attribute (node: SYSTEM_XML_XMLNODE) is
		external
			"IL signature (System.Xml.XmlNode): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteXmlAttribute"
		end

	frozen write_null_tag_encoded (name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullTagEncoded"
		end

	frozen write_element_string_string_string_xml_qualified_name (local_name: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen write_element_qualified_name_string_xml_qualified_name_xml_qualified_name (local_name: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen from_char (value: CHARACTER): STRING is
		external
			"IL static signature (System.Char): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromChar"
		end

	frozen write_element_literal (node: SYSTEM_XML_XMLNODE; name: STRING; ns: STRING; is_nullable: BOOLEAN; any: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlNode, System.String, System.String, System.Boolean, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementLiteral"
		end

	frozen from_date (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromDate"
		end

	frozen write_element_string_raw (local_name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_element_encoded (node: SYSTEM_XML_XMLNODE; name: STRING; ns: STRING; is_nullable: BOOLEAN; any: BOOLEAN) is
		external
			"IL signature (System.Xml.XmlNode, System.String, System.String, System.Boolean, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementEncoded"
		end

	frozen write_end_element_object (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEndElement"
		end

	frozen write_start_document is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartDocument"
		end

	frozen write_nullable_string_encoded (name: STRING; ns: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringEncoded"
		end

	frozen from_date_time (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromDateTime"
		end

	frozen from_byte_array_hex (value: ARRAY [INTEGER_8]): STRING is
		external
			"IL static signature (System.Byte[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromByteArrayHex"
		end

	frozen write_potentially_referencing_element_string_string_object_type_boolean (n: STRING; ns: STRING; o: ANY; ambient_type: SYSTEM_TYPE; suppress_reference: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Type, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	frozen write_element_string_raw_string_string_xml_qualified_name (local_name: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_start_element_string_string_object_boolean (name: STRING; ns: STRING; o: ANY; write_prefixed: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Object, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen write_potentially_referencing_element (n: STRING; ns: STRING; o: ANY) is
		external
			"IL signature (System.String, System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WritePotentiallyReferencingElement"
		end

	init_callbacks is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"InitCallbacks"
		end

	frozen write_nullable_qualified_name_literal (name: STRING; ns: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableQualifiedNameLiteral"
		end

	frozen write_element_qualified_name_string_string_xml_qualified_name (local_name: STRING; ns: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementQualifiedName"
		end

	frozen write_empty_tag (name: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEmptyTag"
		end

	frozen write_element_string_raw_string_string_string (local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementStringRaw"
		end

	frozen write_nullable_string_literal (name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringLiteral"
		end

	frozen write_attribute_string_string_string_string (prefix_: STRING; local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen from_xml_qualified_name (xml_qualified_name: SYSTEM_XML_XMLQUALIFIEDNAME): STRING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromXmlQualifiedName"
		end

	frozen write_end_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteEndElement"
		end

	frozen create_unknown_type_exception_object (o: ANY): SYSTEM_EXCEPTION is
		external
			"IL signature (System.Object): System.Exception use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"CreateUnknownTypeException"
		end

	frozen write_nullable_qualified_name_encoded (name: STRING; ns: STRING; value: SYSTEM_XML_XMLQUALIFIEDNAME; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.Xml.XmlQualifiedName, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableQualifiedNameEncoded"
		end

	frozen top_level_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"TopLevelElement"
		end

	frozen write_referenced_elements is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteReferencedElements"
		end

	frozen write_id (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteId"
		end

	frozen write_attribute_string_string_string (local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen write_start_element_string_string_boolean (name: STRING; ns: STRING; write_prefixed: BOOLEAN) is
		external
			"IL signature (System.String, System.String, System.Boolean): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteStartElement"
		end

	frozen from_enum (value: INTEGER_64; values: ARRAY [STRING]; ids: ARRAY [INTEGER_64]): STRING is
		external
			"IL static signature (System.Int64, System.String[], System.Int64[]): System.String use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"FromEnum"
		end

	frozen write_nullable_string_encoded_raw (name: STRING; ns: STRING; value: STRING; xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.String, System.String, System.String, System.Xml.XmlQualifiedName): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteNullableStringEncodedRaw"
		end

	frozen write_element_string_string_string_string (local_name: STRING; ns: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteElementString"
		end

	frozen get_writer: SYSTEM_XML_XMLWRITER is
		external
			"IL signature (): System.Xml.XmlWriter use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"get_Writer"
		end

	frozen write_attribute (local_name: STRING; value: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"WriteAttribute"
		end

	frozen get_namespaces: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (): System.Collections.ArrayList use System.Xml.Serialization.XmlSerializationWriter"
		alias
			"get_Namespaces"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONWRITER
