indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchema"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA

inherit
	SYSTEM_XML_XML_SCHEMA_OBJECT

create
	make_system_xml_xml_schema

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema is
		external
			"IL creator use System.Xml.Schema.XmlSchema"
		end

feature -- Access

	frozen get_attributes: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Attributes"
		end

	frozen get_final_default: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchema"
		alias
			"get_FinalDefault"
		end

--	frozen namespace: SYSTEM_STRING is "http://www.w3.org/2001/XMLSchema"

	frozen get_schema_types: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_SchemaTypes"
		end

	frozen get_elements: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Elements"
		end

	frozen get_target_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchema"
		alias
			"get_TargetNamespace"
		end

	frozen get_unhandled_attributes: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE] is
		external
			"IL signature (): System.Xml.XmlAttribute[] use System.Xml.Schema.XmlSchema"
		alias
			"get_UnhandledAttributes"
		end

	frozen get_element_form_default: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchema"
		alias
			"get_ElementFormDefault"
		end

	frozen get_groups: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Groups"
		end

--	frozen instance_namespace: SYSTEM_STRING is "http://www.w3.org/2001/XMLSchema-instance"

	frozen get_block_default: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchema"
		alias
			"get_BlockDefault"
		end

	frozen get_items: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchema"
		alias
			"get_Items"
		end

	frozen get_attribute_groups: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_AttributeGroups"
		end

	frozen get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchema"
		alias
			"get_Id"
		end

	frozen get_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchema"
		alias
			"get_Version"
		end

	frozen get_notations: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Notations"
		end

	frozen get_includes: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchema"
		alias
			"get_Includes"
		end

	frozen get_is_compiled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchema"
		alias
			"get_IsCompiled"
		end

	frozen get_attribute_form_default: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchema"
		alias
			"get_AttributeFormDefault"
		end

feature -- Element Change

	frozen set_unhandled_attributes (value: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE]) is
		external
			"IL signature (System.Xml.XmlAttribute[]): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_UnhandledAttributes"
		end

	frozen set_target_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_TargetNamespace"
		end

	frozen set_block_default (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_BlockDefault"
		end

	frozen set_attribute_form_default (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_AttributeFormDefault"
		end

	frozen set_version (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_Version"
		end

	frozen set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_Id"
		end

	frozen set_final_default (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_FinalDefault"
		end

	frozen set_element_form_default (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_ElementFormDefault"
		end

feature -- Basic Operations

	frozen read (reader: SYSTEM_XML_XML_READER; validation_event_handler: SYSTEM_XML_VALIDATION_EVENT_HANDLER): SYSTEM_XML_XML_SCHEMA is
		external
			"IL static signature (System.Xml.XmlReader, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen write_stream (stream: SYSTEM_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen write_xml_writer (writer: SYSTEM_XML_XML_WRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen read_stream (stream: SYSTEM_STREAM; validation_event_handler: SYSTEM_XML_VALIDATION_EVENT_HANDLER): SYSTEM_XML_XML_SCHEMA is
		external
			"IL static signature (System.IO.Stream, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen write_stream_xml_namespace_manager (stream: SYSTEM_STREAM; namespace_manager: SYSTEM_XML_XML_NAMESPACE_MANAGER) is
		external
			"IL signature (System.IO.Stream, System.Xml.XmlNamespaceManager): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen write_text_writer_xml_namespace_manager (writer: TEXT_WRITER; namespace_manager: SYSTEM_XML_XML_NAMESPACE_MANAGER) is
		external
			"IL signature (System.IO.TextWriter, System.Xml.XmlNamespaceManager): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen write_xml_writer_xml_namespace_manager (writer: SYSTEM_XML_XML_WRITER; namespace_manager: SYSTEM_XML_XML_NAMESPACE_MANAGER) is
		external
			"IL signature (System.Xml.XmlWriter, System.Xml.XmlNamespaceManager): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen read_text_reader (reader: TEXT_READER; validation_event_handler: SYSTEM_XML_VALIDATION_EVENT_HANDLER): SYSTEM_XML_XML_SCHEMA is
		external
			"IL static signature (System.IO.TextReader, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen write (writer: TEXT_WRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen compile (validation_event_handler: SYSTEM_XML_VALIDATION_EVENT_HANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Compile"
		end

end -- class SYSTEM_XML_XML_SCHEMA
