indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaAnyAttribute"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_any_attribute

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_any_attribute is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAnyAttribute"
		end

feature -- Access

	frozen get_process_contents: SYSTEM_XML_XML_SCHEMA_CONTENT_PROCESSING is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContentProcessing use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"get_ProcessContents"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"set_Namespace"
		end

	frozen set_process_contents (value: SYSTEM_XML_XML_SCHEMA_CONTENT_PROCESSING) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContentProcessing): System.Void use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"set_ProcessContents"
		end

end -- class SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE
