indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaInclude"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_INCLUDE

inherit
	SYSTEM_XML_XML_SCHEMA_EXTERNAL

create
	make_system_xml_xml_schema_include

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_include is
		external
			"IL creator use System.Xml.Schema.XmlSchemaInclude"
		end

feature -- Access

	frozen get_annotation: SYSTEM_XML_XML_SCHEMA_ANNOTATION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnnotation use System.Xml.Schema.XmlSchemaInclude"
		alias
			"get_Annotation"
		end

feature -- Element Change

	frozen set_annotation (value: SYSTEM_XML_XML_SCHEMA_ANNOTATION) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnnotation): System.Void use System.Xml.Schema.XmlSchemaInclude"
		alias
			"set_Annotation"
		end

end -- class SYSTEM_XML_XML_SCHEMA_INCLUDE
