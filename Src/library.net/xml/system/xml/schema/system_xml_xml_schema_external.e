indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaExternal"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SCHEMA_EXTERNAL

inherit
	SYSTEM_XML_XML_SCHEMA_OBJECT

feature -- Access

	frozen get_schema_location: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_SchemaLocation"
		end

	frozen get_unhandled_attributes: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE] is
		external
			"IL signature (): System.Xml.XmlAttribute[] use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_UnhandledAttributes"
		end

	frozen get_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_Id"
		end

	frozen get_schema: SYSTEM_XML_XML_SCHEMA is
		external
			"IL signature (): System.Xml.Schema.XmlSchema use System.Xml.Schema.XmlSchemaExternal"
		alias
			"get_Schema"
		end

feature -- Element Change

	frozen set_id (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_Id"
		end

	frozen set_schema (value: SYSTEM_XML_XML_SCHEMA) is
		external
			"IL signature (System.Xml.Schema.XmlSchema): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_Schema"
		end

	frozen set_schema_location (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_SchemaLocation"
		end

	frozen set_unhandled_attributes (value: NATIVE_ARRAY [SYSTEM_XML_XML_ATTRIBUTE]) is
		external
			"IL signature (System.Xml.XmlAttribute[]): System.Void use System.Xml.Schema.XmlSchemaExternal"
		alias
			"set_UnhandledAttributes"
		end

end -- class SYSTEM_XML_XML_SCHEMA_EXTERNAL
