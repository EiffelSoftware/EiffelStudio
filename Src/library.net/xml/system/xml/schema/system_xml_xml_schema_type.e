indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaType"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_TYPE

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_type

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_type is
		external
			"IL creator use System.Xml.Schema.XmlSchemaType"
		end

feature -- Access

	frozen get_final_resolved: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_FinalResolved"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Name"
		end

	frozen get_derived_by: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_DerivedBy"
		end

	frozen get_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME is
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

	frozen get_base_schema_type: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaType"
		alias
			"get_BaseSchemaType"
		end

	frozen get_datatype: SYSTEM_XML_XML_SCHEMA_DATATYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDatatype use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Datatype"
		end

	frozen get_final: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaType"
		alias
			"get_Final"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaType"
		alias
			"set_Name"
		end

	frozen set_final (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
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

end -- class SYSTEM_XML_XML_SCHEMA_TYPE
