indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlElementAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlelementattribute_3,
	make_xmlelementattribute_2,
	make_xmlelementattribute_1,
	make_xmlelementattribute

feature {NONE} -- Initialization

	frozen make_xmlelementattribute_3 (element_name: STRING; type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Xml.Serialization.XmlElementAttribute"
		end

	frozen make_xmlelementattribute_2 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlElementAttribute"
		end

	frozen make_xmlelementattribute_1 (element_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlElementAttribute"
		end

	frozen make_xmlelementattribute is
		external
			"IL creator use System.Xml.Serialization.XmlElementAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_Form"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_Namespace"
		end

	frozen get_element_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_DataType"
		end

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_Type"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlElementAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_Type"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_Namespace"
		end

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_DataType"
		end

	frozen set_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_ElementName"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlElementAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLELEMENTATTRIBUTE
