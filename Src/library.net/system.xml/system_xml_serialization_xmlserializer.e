indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializer"

external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZER

create
	make_6,
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_6 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make_5 (xml_type_mapping: SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING) is
		external
			"IL creator signature (System.Xml.Serialization.XmlTypeMapping) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make_4 (type: SYSTEM_TYPE; overrides: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEOVERRIDES) is
		external
			"IL creator signature (System.Type, System.Xml.Serialization.XmlAttributeOverrides) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make_3 (type: SYSTEM_TYPE; extra_types: ARRAY [SYSTEM_TYPE]) is
		external
			"IL creator signature (System.Type, System.Type[]) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make_2 (type: SYSTEM_TYPE; root: SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE) is
		external
			"IL creator signature (System.Type, System.Xml.Serialization.XmlRootAttribute) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make (type: SYSTEM_TYPE; overrides: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEOVERRIDES; extra_types: ARRAY [SYSTEM_TYPE]; root: SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE; default_namespace: STRING) is
		external
			"IL creator signature (System.Type, System.Xml.Serialization.XmlAttributeOverrides, System.Type[], System.Xml.Serialization.XmlRootAttribute, System.String) use System.Xml.Serialization.XmlSerializer"
		end

	frozen make_1 (type: SYSTEM_TYPE; default_namespace: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Xml.Serialization.XmlSerializer"
		end

feature -- Element Change

	frozen remove_unknown_node (value: SYSTEM_XML_SERIALIZATION_XMLNODEEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlNodeEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"remove_UnknownNode"
		end

	frozen add_unreferenced_object (value: SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.UnreferencedObjectEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"add_UnreferencedObject"
		end

	frozen remove_unknown_element (value: SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlElementEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"remove_UnknownElement"
		end

	frozen remove_unknown_attribute (value: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlAttributeEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"remove_UnknownAttribute"
		end

	frozen add_unknown_node (value: SYSTEM_XML_SERIALIZATION_XMLNODEEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlNodeEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"add_UnknownNode"
		end

	frozen add_unknown_element (value: SYSTEM_XML_SERIALIZATION_XMLELEMENTEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlElementEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"add_UnknownElement"
		end

	frozen add_unknown_attribute (value: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.XmlAttributeEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"add_UnknownAttribute"
		end

	frozen remove_unreferenced_object (value: SYSTEM_XML_SERIALIZATION_UNREFERENCEDOBJECTEVENTHANDLER) is
		external
			"IL signature (System.Xml.Serialization.UnreferencedObjectEventHandler): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"remove_UnreferencedObject"
		end

feature -- Basic Operations

	frozen serialize_text_writer_object_xml_serializer_namespaces (text_writer: SYSTEM_IO_TEXTWRITER; o: ANY; namespaces: SYSTEM_XML_SERIALIZATION_XMLSERIALIZERNAMESPACES) is
		external
			"IL signature (System.IO.TextWriter, System.Object, System.Xml.Serialization.XmlSerializerNamespaces): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	frozen serialize (stream: SYSTEM_IO_STREAM; o: ANY) is
		external
			"IL signature (System.IO.Stream, System.Object): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	frozen deserialize (text_reader: SYSTEM_IO_TEXTREADER): ANY is
		external
			"IL signature (System.IO.TextReader): System.Object use System.Xml.Serialization.XmlSerializer"
		alias
			"Deserialize"
		end

	frozen from_types (types: ARRAY [SYSTEM_TYPE]): ARRAY [SYSTEM_XML_SERIALIZATION_XMLSERIALIZER] is
		external
			"IL static signature (System.Type[]): System.Xml.Serialization.XmlSerializer[] use System.Xml.Serialization.XmlSerializer"
		alias
			"FromTypes"
		end

	frozen serialize_text_writer_object (text_writer: SYSTEM_IO_TEXTWRITER; o: ANY) is
		external
			"IL signature (System.IO.TextWriter, System.Object): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	frozen serialize_xml_writer_object_xml_serializer_namespaces (xml_writer: SYSTEM_XML_XMLWRITER; o: ANY; namespaces: SYSTEM_XML_SERIALIZATION_XMLSERIALIZERNAMESPACES) is
		external
			"IL signature (System.Xml.XmlWriter, System.Object, System.Xml.Serialization.XmlSerializerNamespaces): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	frozen serialize_stream_object_xml_serializer_namespaces (stream: SYSTEM_IO_STREAM; o: ANY; namespaces: SYSTEM_XML_SERIALIZATION_XMLSERIALIZERNAMESPACES) is
		external
			"IL signature (System.IO.Stream, System.Object, System.Xml.Serialization.XmlSerializerNamespaces): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	can_deserialize (xml_reader: SYSTEM_XML_XMLREADER): BOOLEAN is
		external
			"IL signature (System.Xml.XmlReader): System.Boolean use System.Xml.Serialization.XmlSerializer"
		alias
			"CanDeserialize"
		end

	frozen from_mappings (mappings: ARRAY [SYSTEM_XML_SERIALIZATION_XMLMAPPING]): ARRAY [SYSTEM_XML_SERIALIZATION_XMLSERIALIZER] is
		external
			"IL static signature (System.Xml.Serialization.XmlMapping[]): System.Xml.Serialization.XmlSerializer[] use System.Xml.Serialization.XmlSerializer"
		alias
			"FromMappings"
		end

	frozen serialize_xml_writer_object (xml_writer: SYSTEM_XML_XMLWRITER; o: ANY) is
		external
			"IL signature (System.Xml.XmlWriter, System.Object): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	frozen deserialize_stream (stream: SYSTEM_IO_STREAM): ANY is
		external
			"IL signature (System.IO.Stream): System.Object use System.Xml.Serialization.XmlSerializer"
		alias
			"Deserialize"
		end

	frozen deserialize_xml_reader (xml_reader: SYSTEM_XML_XMLREADER): ANY is
		external
			"IL signature (System.Xml.XmlReader): System.Object use System.Xml.Serialization.XmlSerializer"
		alias
			"Deserialize"
		end

feature {NONE} -- Implementation

	deserialize_xml_serialization_reader (reader: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER): ANY is
		external
			"IL signature (System.Xml.Serialization.XmlSerializationReader): System.Object use System.Xml.Serialization.XmlSerializer"
		alias
			"Deserialize"
		end

	serialize_object (o: ANY; writer: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONWRITER) is
		external
			"IL signature (System.Object, System.Xml.Serialization.XmlSerializationWriter): System.Void use System.Xml.Serialization.XmlSerializer"
		alias
			"Serialize"
		end

	create_reader: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONREADER is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationReader use System.Xml.Serialization.XmlSerializer"
		alias
			"CreateReader"
		end

	create_writer: SYSTEM_XML_SERIALIZATION_XMLSERIALIZATIONWRITER is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializationWriter use System.Xml.Serialization.XmlSerializer"
		alias
			"CreateWriter"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZER
