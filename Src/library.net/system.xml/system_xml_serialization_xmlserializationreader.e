indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializationReader"

deferred external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER

feature {NONE} -- Implementation

	frozen read_xml_node (wrapped: BOOLEAN): SYSTEM_XML_XMLNODE is
		external
			"IL signature (System.Boolean): System.Xml.XmlNode use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadXmlNode"
		end

	frozen create_unknown_type_exception (type: SYSTEM_XML_XMLQUALIFIEDNAME): SYSTEM_EXCEPTION is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownTypeException"
		end

	frozen get_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.Serialization.XmlSerializationReader"
		alias
			"get_Document"
		end

	frozen to_xml_qualified_name (value: STRING): SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (System.String): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToXmlQualifiedName"
		end

	frozen shrink_array (a: SYSTEM_ARRAY; length: INTEGER; element_type: SYSTEM_TYPE; is_nullable: BOOLEAN): SYSTEM_ARRAY is
		external
			"IL signature (System.Array, System.Int32, System.Type, System.Boolean): System.Array use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ShrinkArray"
		end

	frozen create_unknown_constant_exception (value: STRING; enum_type: SYSTEM_TYPE): SYSTEM_EXCEPTION is
		external
			"IL signature (System.String, System.Type): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownConstantException"
		end

	frozen read_null: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNull"
		end

	frozen to_byte_array_base64 (value: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayBase64"
		end

	frozen create_unknown_node_exception: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateUnknownNodeException"
		end

	frozen add_target (id: STRING; o: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddTarget"
		end

	frozen parse_wsdl_array_type (attr: SYSTEM_XML_XMLATTRIBUTE) is
		external
			"IL signature (System.Xml.XmlAttribute): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ParseWsdlArrayType"
		end

	frozen add_fixup (fixup: COLLECTIONFIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializationReader+CollectionFixup): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddFixup"
		end

	frozen get_target (id: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetTarget"
		end

	frozen get_reader: SYSTEM_XML_XMLREADER is
		external
			"IL signature (): System.Xml.XmlReader use System.Xml.Serialization.XmlSerializationReader"
		alias
			"get_Reader"
		end

	frozen read_referencing_element_string (name: STRING; ns: STRING; fixup_reference: STRING): ANY is
		external
			"IL signature (System.String, System.String, System.String&): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencingElement"
		end

	frozen read_reference (fixup_reference: STRING): BOOLEAN is
		external
			"IL signature (System.String&): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReference"
		end

	frozen to_char (value: STRING): CHARACTER is
		external
			"IL static signature (System.String): System.Char use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToChar"
		end

	frozen read_referencing_element (fixup_reference: STRING): ANY is
		external
			"IL signature (System.String&): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencingElement"
		end

	frozen to_byte_array (value: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArray"
		end

	frozen read_end_element is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadEndElement"
		end

	frozen get_array_length (name: STRING; ns: STRING): INTEGER is
		external
			"IL signature (System.String, System.String): System.Int32 use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetArrayLength"
		end

	frozen to_enum (value: STRING; h: SYSTEM_COLLECTIONS_HASHTABLE; type_name: STRING): INTEGER_64 is
		external
			"IL static signature (System.String, System.Collections.Hashtable, System.String): System.Int64 use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToEnum"
		end

	frozen read_nullable_qualified_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNullableQualifiedName"
		end

	frozen read_referenced_elements is
		external
			"IL signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElements"
		end

	init_ids is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"InitIDs"
		end

	frozen add_read_callback (name: STRING; ns: STRING; type: SYSTEM_TYPE; read: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADCALLBACK) is
		external
			"IL signature (System.String, System.String, System.Type, System.Xml.Serialization.XmlSerializationReadCallback): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddReadCallback"
		end

	frozen to_byte_array_hex (value: STRING): ARRAY [INTEGER_8] is
		external
			"IL static signature (System.String): System.Byte[] use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToByteArrayHex"
		end

	frozen read_referenced_element: ANY is
		external
			"IL signature (): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElement"
		end

	frozen read_nullable_string: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadNullableString"
		end

	frozen to_date (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToDate"
		end

	init_callbacks is
		external
			"IL deferred signature (): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"InitCallbacks"
		end

	frozen fixup_array_refs (fixup: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"FixupArrayRefs"
		end

	frozen read_typed_primitive (type: SYSTEM_XML_XMLQUALIFIEDNAME): ANY is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadTypedPrimitive"
		end

	frozen ensure_array_index (a: SYSTEM_ARRAY; index: INTEGER; element_type: SYSTEM_TYPE): SYSTEM_ARRAY is
		external
			"IL signature (System.Array, System.Int32, System.Type): System.Array use System.Xml.Serialization.XmlSerializationReader"
		alias
			"EnsureArrayIndex"
		end

	frozen create_abstract_type_exception (name: STRING; ns: STRING): SYSTEM_EXCEPTION is
		external
			"IL signature (System.String, System.String): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateAbstractTypeException"
		end

	frozen read_serializable (serializable: SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE): SYSTEM_XML_SERIALIZATION_IXMLSERIALIZABLE is
		external
			"IL signature (System.Xml.Serialization.IXmlSerializable): System.Xml.Serialization.IXmlSerializable use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadSerializable"
		end

	frozen read_referenced_element_string (name: STRING; ns: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadReferencedElement"
		end

	frozen to_time (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToTime"
		end

	frozen unknown_node (o: ANY) is
		external
			"IL signature (System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownNode"
		end

	frozen read_element_qualified_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ReadElementQualifiedName"
		end

	frozen is_xmlns_attribute (name: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Xml.Serialization.XmlSerializationReader"
		alias
			"IsXmlnsAttribute"
		end

	frozen to_date_time (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Xml.Serialization.XmlSerializationReader"
		alias
			"ToDateTime"
		end

	frozen add_fixup_fixup (fixup: FIXUP_IN_SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializationReader+Fixup): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"AddFixup"
		end

	frozen create_read_only_collection_exception (name: STRING): SYSTEM_EXCEPTION is
		external
			"IL signature (System.String): System.Exception use System.Xml.Serialization.XmlSerializationReader"
		alias
			"CreateReadOnlyCollectionException"
		end

	frozen unreferenced_object (id: STRING; o: ANY) is
		external
			"IL signature (System.String, System.Object): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnreferencedObject"
		end

	frozen unknown_element (o: ANY; elem: SYSTEM_XML_XMLELEMENT) is
		external
			"IL signature (System.Object, System.Xml.XmlElement): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownElement"
		end

	frozen get_xsi_type: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSerializationReader"
		alias
			"GetXsiType"
		end

	frozen unknown_attribute (o: ANY; attr: SYSTEM_XML_XMLATTRIBUTE) is
		external
			"IL signature (System.Object, System.Xml.XmlAttribute): System.Void use System.Xml.Serialization.XmlSerializationReader"
		alias
			"UnknownAttribute"
		end

	frozen read_string (value: STRING): STRING is
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

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER
