indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaParticle"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_XML_XML_SCHEMA_PARTICLE

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

feature -- Access

	frozen get_min_occurs: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MinOccurs"
		end

	frozen get_max_occurs_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MaxOccursString"
		end

	frozen get_max_occurs: DECIMAL is
		external
			"IL signature (): System.Decimal use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MaxOccurs"
		end

	frozen get_min_occurs_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MinOccursString"
		end

feature -- Element Change

	frozen set_min_occurs (value: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MinOccurs"
		end

	frozen set_min_occurs_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MinOccursString"
		end

	frozen set_max_occurs_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MaxOccursString"
		end

	frozen set_max_occurs (value: DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MaxOccurs"
		end

end -- class SYSTEM_XML_XML_SCHEMA_PARTICLE
