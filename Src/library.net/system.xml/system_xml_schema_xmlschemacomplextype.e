indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaComplexType"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXTYPE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMATYPE
		redefine
			set_is_mixed,
			get_is_mixed
		end

create
	make_xmlschemacomplextype

feature {NONE} -- Initialization

	frozen make_xmlschemacomplextype is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexType"
		end

feature -- Access

	frozen get_content_type: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTTYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContentType use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_ContentType"
		end

	frozen get_any_attribute: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_AnyAttribute"
		end

	frozen get_block: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Block"
		end

	frozen get_particle: SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Particle"
		end

	frozen get_block_resolved: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_BlockResolved"
		end

	frozen get_attribute_uses: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTTABLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectTable use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_AttributeUses"
		end

	frozen get_content_type_particle: SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_ContentTypeParticle"
		end

	frozen get_content_model: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTMODEL is
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

	frozen get_attributes: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"get_Attributes"
		end

	frozen get_attribute_wildcard: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE is
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

	frozen set_particle (value: SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaParticle): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_Particle"
		end

	frozen set_content_model (value: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTMODEL) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContentModel): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_ContentModel"
		end

	frozen set_any_attribute (value: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE) is
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

	frozen set_block (value: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchemaComplexType"
		alias
			"set_Block"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXTYPE
