indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAnnotated"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAOBJECT

create
	make_xmlschemaannotated

feature {NONE} -- Initialization

	frozen make_xmlschemaannotated is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAnnotated"
		end

feature -- Access

	frozen get_annotation: SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaAnnotation use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"get_Annotation"
		end

	frozen get_unhandled_attributes: ARRAY [SYSTEM_XML_XMLATTRIBUTE] is
		external
			"IL signature (): System.Xml.XmlAttribute[] use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"get_UnhandledAttributes"
		end

	frozen get_id: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"get_Id"
		end

feature -- Element Change

	frozen set_id (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"set_Id"
		end

	frozen set_annotation (value: SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATION) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaAnnotation): System.Void use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"set_Annotation"
		end

	frozen set_unhandled_attributes (value: ARRAY [SYSTEM_XML_XMLATTRIBUTE]) is
		external
			"IL signature (System.Xml.XmlAttribute[]): System.Void use System.Xml.Schema.XmlSchemaAnnotated"
		alias
			"set_UnhandledAttributes"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED
