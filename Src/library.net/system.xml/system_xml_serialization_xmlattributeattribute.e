indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAttributeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlattributeattribute,
	make_xmlattributeattribute_1,
	make_xmlattributeattribute_3,
	make_xmlattributeattribute_2

feature {NONE} -- Initialization

	frozen make_xmlattributeattribute is
		external
			"IL creator use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_xmlattributeattribute_1 (attribute_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_xmlattributeattribute_3 (attribute_name: STRING; type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Xml.Serialization.XmlAttributeAttribute"
		end

	frozen make_xmlattributeattribute_2 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlAttributeAttribute"
		end

feature -- Access

	frozen get_attribute_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_AttributeName"
		end

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Form"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Namespace"
		end

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Type"
		end

	frozen set_attribute_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_AttributeName"
		end

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_DataType"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlAttributeAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEATTRIBUTE
