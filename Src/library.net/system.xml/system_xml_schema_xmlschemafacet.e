indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaFacet"

deferred external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAFACET

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

feature -- Access

	frozen get_is_fixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaFacet"
		alias
			"get_IsFixed"
		end

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaFacet"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaFacet"
		alias
			"set_Value"
		end

	frozen set_is_fixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaFacet"
		alias
			"set_IsFixed"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAFACET
