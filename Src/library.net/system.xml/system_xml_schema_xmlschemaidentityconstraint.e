indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaIdentityConstraint"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAIDENTITYCONSTRAINT

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaidentityconstraint

feature {NONE} -- Initialization

	frozen make_xmlschemaidentityconstraint is
		external
			"IL creator use System.Xml.Schema.XmlSchemaIdentityConstraint"
		end

feature -- Access

	frozen get_fields: SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECTCOLLECTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaObjectCollection use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Fields"
		end

	frozen get_selector: SYSTEM_XML_SCHEMA_XMLSCHEMAXPATH is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaXPath use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Selector"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_selector (value: SYSTEM_XML_SCHEMA_XMLSCHEMAXPATH) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaXPath): System.Void use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"set_Selector"
		end

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaIdentityConstraint"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAIDENTITYCONSTRAINT
