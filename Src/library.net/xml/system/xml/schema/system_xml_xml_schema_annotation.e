indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaAnnotation"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_ANNOTATION

inherit
	SYSTEM_XML_XML_SCHEMA_OBJECT

create
	make_system_xml_xml_schema_annotation

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_annotation is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAnnotation"
		end

feature -- Access

	frozen get_items: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"get_Items"
		end

	frozen get_unhandled_attributes: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE] is
		external
			"IL signature (): System.Xml.XmlAttribute[] use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"get_UnhandledAttributes"
		end

	frozen get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"get_Id"
		end

feature -- Element Change

	frozen set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"set_Id"
		end

	frozen set_unhandled_attributes (value: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE]) is
		external
			"IL signature (System.Xml.XmlAttribute[]): System.Void use System.Xml.Schema.XmlSchemaAnnotation"
		alias
			"set_UnhandledAttributes"
		end

end -- class SYSTEM_XML_XML_SCHEMA_ANNOTATION
