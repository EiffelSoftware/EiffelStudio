indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaComplexContentRestriction"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_COMPLEX_CONTENT_RESTRICTION

inherit
	SYSTEM_XML_XML_SCHEMA_CONTENT

create
	make_system_xml_xml_schema_complex_content_restriction

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_complex_content_restriction is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		end

feature -- Access

	frozen get_any_attribute: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"get_AnyAttribute"
		end

	frozen get_particle: SYSTEM_XML_XML_SCHEMA_PARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"get_Particle"
		end

	frozen get_base_type_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"get_BaseTypeName"
		end

	frozen get_attributes: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_base_type_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"set_BaseTypeName"
		end

	frozen set_particle (value: SYSTEM_XML_XML_SCHEMA_PARTICLE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaParticle): System.Void use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"set_Particle"
		end

	frozen set_any_attribute (value: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnyAttribute): System.Void use System.Xml.Schema.XmlSchemaComplexContentRestriction"
		alias
			"set_AnyAttribute"
		end

end -- class SYSTEM_XML_XML_SCHEMA_COMPLEX_CONTENT_RESTRICTION
