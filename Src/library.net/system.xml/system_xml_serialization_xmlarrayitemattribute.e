indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlArrayItemAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlarrayitemattribute_1,
	make_xmlarrayitemattribute_3,
	make_xmlarrayitemattribute_2,
	make_xmlarrayitemattribute

feature {NONE} -- Initialization

	frozen make_xmlarrayitemattribute_1 (element_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_xmlarrayitemattribute_3 (element_name: STRING; type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.String, System.Type) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_xmlarrayitemattribute_2 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlArrayItemAttribute"
		end

	frozen make_xmlarrayitemattribute is
		external
			"IL creator use System.Xml.Serialization.XmlArrayItemAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Form"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Namespace"
		end

	frozen get_element_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_DataType"
		end

	frozen get_nesting_level: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_NestingLevel"
		end

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_Type"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Form"
		end

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Type"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_Namespace"
		end

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_DataType"
		end

	frozen set_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_ElementName"
		end

	frozen set_nesting_level (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Xml.Serialization.XmlArrayItemAttribute"
		alias
			"set_NestingLevel"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLARRAYITEMATTRIBUTE
