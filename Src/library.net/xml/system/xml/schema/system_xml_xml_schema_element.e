indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaElement"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_ELEMENT

inherit
	SYSTEM_XML_XML_SCHEMA_PARTICLE

create
	make_system_xml_xml_schema_element

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_element is
		external
			"IL creator use System.Xml.Schema.XmlSchemaElement"
		end

feature -- Access

	frozen get_final_resolved: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_FinalResolved"
		end

	frozen get_element_type: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_ElementType"
		end

	frozen get_substitution_group: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_SubstitutionGroup"
		end

	frozen get_form: SYSTEM_XML_XML_SCHEMA_FORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_Form"
		end

	frozen get_schema_type: SYSTEM_XML_XML_SCHEMA_TYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaType use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_SchemaType"
		end

	frozen get_schema_type_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_SchemaTypeName"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_Name"
		end

	frozen get_final: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_Final"
		end

	frozen get_block_resolved: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_BlockResolved"
		end

	frozen get_default_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_DefaultValue"
		end

	frozen get_constraints: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_Constraints"
		end

	frozen get_is_abstract: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_IsAbstract"
		end

	frozen get_is_nillable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_IsNillable"
		end

	frozen get_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_QualifiedName"
		end

	frozen get_fixed_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_FixedValue"
		end

	frozen get_block: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaDerivationMethod use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_Block"
		end

	frozen get_ref_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaElement"
		alias
			"get_RefName"
		end

feature -- Element Change

	frozen set_fixed_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_FixedValue"
		end

	frozen set_is_abstract (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_IsAbstract"
		end

	frozen set_substitution_group (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_SubstitutionGroup"
		end

	frozen set_default_value (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_DefaultValue"
		end

	frozen set_form (value: SYSTEM_XML_XML_SCHEMA_FORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_Form"
		end

	frozen set_ref_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_RefName"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_Name"
		end

	frozen set_final (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_Final"
		end

	frozen set_block (value: SYSTEM_XML_XML_SCHEMA_DERIVATION_METHOD) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaDerivationMethod): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_Block"
		end

	frozen set_schema_type (value: SYSTEM_XML_XML_SCHEMA_TYPE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaType): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_SchemaType"
		end

	frozen set_schema_type_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_SchemaTypeName"
		end

	frozen set_is_nillable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Schema.XmlSchemaElement"
		alias
			"set_IsNillable"
		end

end -- class SYSTEM_XML_XML_SCHEMA_ELEMENT
