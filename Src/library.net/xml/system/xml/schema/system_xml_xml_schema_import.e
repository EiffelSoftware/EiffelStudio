indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaImport"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_IMPORT

inherit
	SYSTEM_XML_XML_SCHEMA_EXTERNAL

create
	make_system_xml_xml_schema_import

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_import is
		external
			"IL creator use System.Xml.Schema.XmlSchemaImport"
		end

feature -- Access

	frozen get_annotation: SYSTEM_XML_XML_SCHEMA_ANNOTATION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnnotation use System.Xml.Schema.XmlSchemaImport"
		alias
			"get_Annotation"
		end

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaImport"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_annotation (value: SYSTEM_XML_XML_SCHEMA_ANNOTATION) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnnotation): System.Void use System.Xml.Schema.XmlSchemaImport"
		alias
			"set_Annotation"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaImport"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_XML_XML_SCHEMA_IMPORT
