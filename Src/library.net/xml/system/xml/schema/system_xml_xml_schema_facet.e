indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaFacet"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SCHEMA_FACET

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

feature -- Access

	get_is_fixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaFacet"
		alias
			"get_IsFixed"
		end

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaFacet"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaFacet"
		alias
			"set_Value"
		end

	set_is_fixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaFacet"
		alias
			"set_IsFixed"
		end

end -- class SYSTEM_XML_XML_SCHEMA_FACET
