indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaParticle"

deferred external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

feature -- Access

	frozen get_min_occurs: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MinOccurs"
		end

	frozen get_max_occurs_string: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MaxOccursString"
		end

	frozen get_max_occurs: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MaxOccurs"
		end

	frozen get_min_occurs_string: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaParticle"
		alias
			"get_MinOccursString"
		end

feature -- Element Change

	frozen set_min_occurs (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MinOccurs"
		end

	frozen set_min_occurs_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MinOccursString"
		end

	frozen set_max_occurs_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MaxOccursString"
		end

	frozen set_max_occurs (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Xml.Schema.XmlSchemaParticle"
		alias
			"set_MaxOccurs"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE
