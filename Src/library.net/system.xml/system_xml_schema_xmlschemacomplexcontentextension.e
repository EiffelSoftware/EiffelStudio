indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaComplexContentExtension"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXCONTENTEXTENSION

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMACONTENT

create
	make_xmlschemacomplexcontentextension

feature {NONE} -- Initialization

	frozen make_xmlschemacomplexcontentextension is
		external
			"IL creator use System.Xml.Schema.XmlSchemaComplexContentExtension"
		end

feature -- Access

	frozen get_any_attribute: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnyAttribute use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"get_AnyAttribute"
		end

	frozen get_particle: SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaParticle use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"get_Particle"
		end

	frozen get_base_type_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"get_BaseTypeName"
		end

	frozen get_attributes: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"get_Attributes"
		end

feature -- Element Change

	frozen set_base_type_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"set_BaseTypeName"
		end

	frozen set_particle (value: SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaParticle): System.Void use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"set_Particle"
		end

	frozen set_any_attribute (value: SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnyAttribute): System.Void use System.Xml.Schema.XmlSchemaComplexContentExtension"
		alias
			"set_AnyAttribute"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMACOMPLEXCONTENTEXTENSION
