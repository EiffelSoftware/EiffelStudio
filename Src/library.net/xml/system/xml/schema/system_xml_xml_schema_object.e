indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaObject"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SCHEMA_OBJECT

inherit
	SYSTEM_OBJECT

feature -- Access

	frozen get_source_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_SourceUri"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_LineNumber"
		end

	frozen get_line_position: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_LinePosition"
		end

	frozen get_namespaces: SYSTEM_XML_XML_SERIALIZER_NAMESPACES is
		external
			"IL signature (): System.Xml.Serialization.XmlSerializerNamespaces use System.Xml.Schema.XmlSchemaObject"
		alias
			"get_Namespaces"
		end

feature -- Element Change

	frozen set_line_position (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_LinePosition"
		end

	frozen set_source_uri (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_SourceUri"
		end

	frozen set_line_number (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_LineNumber"
		end

	frozen set_namespaces (value: SYSTEM_XML_XML_SERIALIZER_NAMESPACES) is
		external
			"IL signature (System.Xml.Serialization.XmlSerializerNamespaces): System.Void use System.Xml.Schema.XmlSchemaObject"
		alias
			"set_Namespaces"
		end

end -- class SYSTEM_XML_XML_SCHEMA_OBJECT
