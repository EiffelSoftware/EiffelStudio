indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchema"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMA

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschema

feature {NONE} -- Initialization

	frozen make_xmlschema is
		external
			"IL creator use System.Xml.Schema.XmlSchema"
		end

feature -- Access

	frozen get_attributes: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Attributes"
		end

	frozen get_final_default: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchema"
		alias
			"get_FinalDefault"
		end

	frozen get_schema_types: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_SchemaTypes"
		end

	frozen get_elements: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Elements"
		end

	frozen get_target_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchema"
		alias
			"get_TargetNamespace"
		end

	frozen get_groups: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Groups"
		end

	frozen get_element_form_default: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchema"
		alias
			"get_ElementFormDefault"
		end

	frozen get_block_default: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchema"
		alias
			"get_BlockDefault"
		end

	frozen get_items: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchema"
		alias
			"get_Items"
		end

	frozen get_attribute_groups: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_AttributeGroups"
		end

	frozen get_attribute_form_default: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchema"
		alias
			"get_AttributeFormDefault"
		end

	frozen get_version: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchema"
		alias
			"get_Version"
		end

	frozen get_includes: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
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

	frozen get_notations: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchema"
		alias
			"get_Notations"
		end

feature -- Element Change

	frozen set_attribute_form_default (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_AttributeFormDefault"
		end

	frozen set_final_default (value: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_FinalDefault"
		end

	frozen set_element_form_default (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_ElementFormDefault"
		end

	frozen set_version (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_Version"
		end

	frozen set_target_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_TargetNamespace"
		end

	frozen set_block_default (value: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"set_BlockDefault"
		end

feature -- Basic Operations

	frozen read (reader: SYSTEM_XML_XMLREADER; validation_event_handler: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL static signature (System.Xml.XmlReader, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen write_stream (stream: SYSTEM_IO_STREAM) is
		external
			"IL signature (System.IO.Stream): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen read_stream (stream: SYSTEM_IO_STREAM; validation_event_handler: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL static signature (System.IO.Stream, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen compile (validation_event_handler: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER) is
		external
			"IL signature (System.Xml.Schema.ValidationEventHandler): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Compile"
		end

	frozen read_text_reader (reader: SYSTEM_IO_TEXTREADER; validation_event_handler: SYSTEM_XML_SCHEMA_VALIDATIONEVENTHANDLER): SYSTEM_XML_SCHEMA_XMLSCHEMA is
		external
			"IL static signature (System.IO.TextReader, System.Xml.Schema.ValidationEventHandler): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchema"
		alias
			"Read"
		end

	frozen can_read (reader: SYSTEM_XML_XMLREADER): BOOLEAN is
		external
			"IL static signature (System.Xml.XmlReader): System.Boolean use System.Xml.Schema.XmlSchema"
		alias
			"CanRead"
		end

	frozen write_text_writer (writer: SYSTEM_IO_TEXTWRITER) is
		external
			"IL signature (System.IO.TextWriter): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

	frozen write (writer: SYSTEM_XML_XMLWRITER) is
		external
			"IL signature (System.Xml.XmlWriter): System.Void use System.Xml.Schema.XmlSchema"
		alias
			"Write"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMA
