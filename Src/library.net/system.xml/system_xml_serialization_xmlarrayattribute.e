indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlArrayAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLARRAYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlarrayattribute,
	make_xmlarrayattribute_1

feature {NONE} -- Initialization

	frozen make_xmlarrayattribute is
		external
			"IL creator use System.Xml.Serialization.XmlArrayAttribute"
		end

	frozen make_xmlarrayattribute_1 (element_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlArrayAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_Form"
		end

	frozen get_element_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_ElementName"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_Namespace"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_Namespace"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_ElementName"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlArrayAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLARRAYATTRIBUTE
