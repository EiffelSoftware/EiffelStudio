indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAttribute"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaattribute

feature {NONE} -- Initialization

	frozen make_xmlschemaattribute is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAttribute"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_Name"
		end

	frozen get_use: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaUse use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_Use"
		end

	frozen get_attribute_type: ANY is
		external
			"IL signature (): System.Object use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_AttributeType"
		end

	frozen get_schema_type: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaSimpleType use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_SchemaType"
		end

	frozen get_fixed_value: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_FixedValue"
		end

	frozen get_ref_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_RefName"
		end

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_Form"
		end

	frozen get_qualified_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_QualifiedName"
		end

	frozen get_default_value: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_DefaultValue"
		end

	frozen get_schema_type_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"get_SchemaTypeName"
		end

feature -- Element Change

	frozen set_schema_type (value: SYSTEM_XML_SCHEMA_XMLSCHEMASIMPLETYPE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaSimpleType): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_SchemaType"
		end

	frozen set_default_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_DefaultValue"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_Form"
		end

	frozen set_fixed_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_FixedValue"
		end

	frozen set_ref_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_RefName"
		end

	frozen set_use (value: SYSTEM_XML_SCHEMA_XMLSCHEMAUSE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaUse): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_Use"
		end

	frozen set_schema_type_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_SchemaTypeName"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAttribute"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAATTRIBUTE
