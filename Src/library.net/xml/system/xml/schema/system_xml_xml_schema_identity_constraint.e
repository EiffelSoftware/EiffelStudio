indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaIdentityConstraint"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_IDENTITY_CONSTRAINT

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_identity_constraint

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_identity_constraint is
		external
			"IL creator use System.Xml.Schema.XmlSchemaIdentityConstraint"
		end

feature -- Access

	frozen get_fields: SYSTEM_XML_XML_SCHEMA_OBJECT_COLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Fields"
		end

	frozen get_selector: SYSTEM_XML_XML_SCHEMA_XPATH is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaXPath use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Selector"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Name"
		end

	frozen get_qualified_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_QualifiedName"
		end

feature -- Element Change

	frozen set_selector (value: SYSTEM_XML_XML_SCHEMA_XPATH) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaXPath): System.Void use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"set_Selector"
		end

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_XML_SCHEMA_IDENTITY_CONSTRAINT
