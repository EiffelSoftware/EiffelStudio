indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializationReader"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SERIALIZATION_READER

inherit
	SYSTEM_OBJECT

feature {NONE} -- Implementation

	frozen read_xml_node (wrapped: BOOLEAN): SYSTEM_XML_XML_NODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadXmlNode"
		end

	frozen to_xml_ncname (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlNCName"
		end

	frozen create_unknown_type_exception (type: SYSTEM_XML_XML_QUALIFIED_NAME): EXCEPTION is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownTypeException"
		end

	frozen get_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.Serialization.XmlSerializationReader"
		alias
			"get_Document"
		end

	frozen to_xml_qualified_name (value: SYSTEM_STRING): SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (System.String): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlQualifiedName"
		end

	frozen shrink_array (a: SYSTEM_ARRAY; length: INTEGER; element_type: TYPE; is_nullable: BOOLEAN): SYSTEM_ARRAY is
		external
			"IL signature (System.Array, System.Int32, System.Type, System.Boolean): System.Array use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ShrinkArray"
		end

	frozen create_unknown_constant_exception (value: SYSTEM_STRING; enum_type: TYPE): EXCEPTION is
		external
			"IL signature (System.String, System.Type): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownConstantException"
		end

	frozen create_read_only_collection_exception (name: SYSTEM_STRING): EXCEPTION is
		external
			"IL signature (System.String): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateReadOnlyCollectionException"
		end

	frozen to_byte_array_base64 (is_null: BOOLEAN): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Boolean): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayBase64"
		end

	frozen read_nullable_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNullableString"
		end

	frozen add_target (id: SYSTEM_STRING; o: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddTarget"
		end

	frozen parse_wsdl_array_type (attr: SYSTEM_XML_XML_ATTRIBUTE) is
		external
			"IL signature (System.Xml.XmlAttribute): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ParseWsdlArrayType"
		end

	frozen add_fixup (fixup: SYSTEM_XML_COLLECTION_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializationReader+CollectionFixup): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddFixup"
		end

	frozen get_target (id: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetTarget"
		end

	frozen get_reader: SYSTEM_XML_XML_READER is
		external
			"IL signature (): System.Xml.XmlReader use System.Xml.Serialization.XmlSerializationReader"
		alias
			"get_Reader"
		end

	frozen read_referencing_element_string_string_boolean (name: SYSTEM_STRING; ns: SYSTEM_STRING; element_can_be_type: BOOLEAN; fixup_reference: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.Boolean, System.String&): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencingElement"
		end

	frozen read_reference (fixup_reference: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String&): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReference"
		end

	frozen to_char (value: SYSTEM_STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToChar"
		end

	frozen read_referencing_element (fixup_reference: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String&): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencingElement"
		end

	frozen to_xml_name (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlName"
		end

	frozen to_xml_nm_token (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlNmToken"
		end

	frozen read_end_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadEndElement"
		end

	frozen get_array_length (name: SYSTEM_STRING; ns: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetArrayLength"
		end

	frozen to_enum (value: SYSTEM_STRING; h: HASHTABLE; type_name: SYSTEM_STRING): INTEGER_64 is
		external
			"IL static signature (System.String, System.Collections.Hashtable, System.String): System.Int64 use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToEnum"
		end

	frozen read_nullable_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNullableQualifiedName"
		end

	frozen create_abstract_type_exception (name: SYSTEM_STRING; ns: SYSTEM_STRING): EXCEPTION is
		external
			"IL signature (System.String, System.String): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateAbstractTypeException"
		end

	frozen read_referenced_elements is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElements"
		end

	frozen add_read_callback (name: SYSTEM_STRING; ns: SYSTEM_STRING; type: TYPE; read: SYSTEM_XML_XML_SERIALIZATION_READ_CALLBACK) is
		external
			"IL signature (System.String, System.String, System.Type, System.Xml.Serialization.XmlSerializationReadCallback): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddReadCallback"
		end

	frozen to_byte_array_hex (is_null: BOOLEAN): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (System.Boolean): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayHex"
		end

	frozen read_referenced_element: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElement"
		end

	frozen read_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNull"
		end

	frozen to_date (value: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToDate"
		end

	frozen referenced (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"Referenced"
		end

	init_callbacks is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"InitCallbacks"
		end

	frozen fixup_array_refs (fixup: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"FixupArrayRefs"
		end

	frozen read_typed_primitive (type: SYSTEM_XML_XML_QUALIFIED_NAME): SYSTEM_OBJECT is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadTypedPrimitive"
		end

	frozen to_byte_array_base64_string (value: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayBase64"
		end

	frozen ensure_array_index (a: SYSTEM_ARRAY; index: INTEGER; element_type: TYPE): SYSTEM_ARRAY is
		external
			"IL signature (System.Array, System.Int32, System.Type): System.Array use System.Xml.Serialization.XmlSerializationReader"
		alias
			"EnsureArrayIndex"
		end

	init_ids is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"InitIDs"
		end

	frozen read_serializable (serializable: SYSTEM_XML_IXML_SERIALIZABLE): SYSTEM_XML_IXML_SERIALIZABLE is
		external
			"IL signature (System.Xml.Serialization.IXmlSerializable): System.Xml.Serialization.IXmlSerializable use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadSerializable"
		end

	frozen read_referenced_element_string (name: SYSTEM_STRING; ns: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElement"
		end

	frozen to_time (value: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToTime"
		end

	frozen create_invalid_cast_exception (type: TYPE; value: SYSTEM_OBJECT): EXCEPTION is
		external
			"IL signature (System.Type, System.Object): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateInvalidCastException"
		end

	frozen unknown_node (o: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownNode"
		end

	frozen read_element_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadElementQualifiedName"
		end

	frozen is_xmlns_attribute (name: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"IsXmlnsAttribute"
		end

	frozen to_date_time (value: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToDateTime"
		end

	frozen add_fixup_fixup (fixup: SYSTEM_XML_FIXUP_IN_SYSTEM_XML_XML_SERIALIZATION_READER) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializationReader+Fixup): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddFixup"
		end

	frozen to_xml_nm_tokens (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlNmTokens"
		end

	frozen unreferenced_object (id: SYSTEM_STRING; o: SYSTEM_OBJECT) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnreferencedObject"
		end

	frozen create_unknown_node_exception: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownNodeException"
		end

	frozen unknown_element (o: SYSTEM_OBJECT; elem: SYSTEM_XML_XML_ELEMENT) is
		external
			"IL signature (System.Object, System.Xml.XmlElement): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownElement"
		end

	frozen read_referencing_element_string_string_string (name: SYSTEM_STRING; ns: SYSTEM_STRING; fixup_reference: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.String&): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencingElement"
		end

	frozen to_byte_array_hex_string (value: SYSTEM_STRING): NATIVE_ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayHex"
		end

	frozen get_xsi_type: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetXsiType"
		end

	frozen unknown_attribute (o: SYSTEM_OBJECT; attr: SYSTEM_XML_XML_ATTRIBUTE) is
		external
			"IL signature (System.Object, System.Xml.XmlAttribute): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownAttribute"
		end

	frozen read_string (value: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadString"
		end

	frozen get_null_attr: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetNullAttr"
		end

end -- class SYSTEM_XML_XML_SERIALIZATION_READER
