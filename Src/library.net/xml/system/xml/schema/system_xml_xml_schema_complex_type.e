indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaComplexType"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_COMPLEX_TYPE

inherit
	SYSTEM_XML_XML_SCHEMA_TYPE
		redefine
			set_is_mixed,
			get_is_mixed
		end

create
	make_system_xml_xml_schema_complex_type

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_complex_type is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexType"
		end

feature -- Access

	frozen get_content_type: SYSTEM_XML_XML_SCHEMA_CONTENT_TYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContentType use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_ContentType"
		end

	frozen get_any_attribute: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_AnyAttribute"
		end

	frozen get_block: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Block"
		end

	frozen get_particle: SYSTEM_XML_XML_SCHEMA_PARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Particle"
		end

	frozen get_block_resolved: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_BlockResolved"
		end

	frozen get_attribute_uses: SYSTEM_XML_XML_SCHEMA_OBJECT_TABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_AttributeUses"
		end

	frozen get_content_type_particle: SYSTEM_XML_XML_SCHEMA_PARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_ContentTypeParticle"
		end

	frozen get_content_model: SYSTEM_XML_XML_SCHEMA_CONTENT_MODEL is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContentModel use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_ContentModel"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_IsAbstract"
		end

	get_is_mixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_IsMixed"
		end

	frozen get_attributes: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Attributes"
		end

	frozen get_attribute_wildcard: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_AttributeWildcard"
		end

feature -- Element Change

	frozen set_is_abstract (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_IsAbstract"
		end

	frozen set_particle (value: SYSTEM_XML_XML_SCHEMA_PARTICLE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaParticle): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_Particle"
		end

	frozen set_content_model (value: SYSTEM_XML_XML_SCHEMA_CONTENT_MODEL) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContentModel): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_ContentModel"
		end

	frozen set_any_attribute (value: SYSTEM_XML_XML_SCHEMA_ANY_ATTRIBUTE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnyAttribute): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_AnyAttribute"
		end

	set_is_mixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_IsMixed"
		end

	frozen set_block (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_Block"
		end

end -- class SYSTEM_XML_XML_SCHEMA_COMPLEX_TYPE
