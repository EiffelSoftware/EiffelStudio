indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaType"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMATYPE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschematype

feature {NONE} -- Initialization

	frozen make_xmlschematype is
		external
			"IL creator use System.Xml.Schema.XmlSchemaType"
		end

feature -- Access

	frozen get_final_resolved: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_FinalResolved"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Name"
		end

	frozen get_derived_by: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_DerivedBy"
		end

	frozen get_qualified_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaType"
		alias
			"get_QualifiedName"
		end

	get_is_mixed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaType"
		alias
			"get_IsMixed"
		end

	frozen get_base_schema_type: ANY is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaType"
		alias
			"get_BaseSchemaType"
		end

	frozen get_datatype: SYSTEM_XML_SCHEMA_XMLSCHEMADATATYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDatatype use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Datatype"
		end

	frozen get_final: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Final"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaType"
		alias
			"set_Name"
		end

	frozen set_final (value: SYSTEM_XML_SCHEMA_XMLSCHEMADERIVATIONMETHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchemaType"
		alias
			"set_Final"
		end

	set_is_mixed (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaType"
		alias
			"set_IsMixed"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMATYPE
