indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlRootAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlrootattribute,
	make_xmlrootattribute_1

feature {NONE} -- Initialization

	frozen make_xmlrootattribute is
		external
			"IL creator use System.Xml.Serialization.XmlRootAttribute"
		end

	frozen make_xmlrootattribute_1 (element_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlRootAttribute"
		end

feature -- Access

	frozen get_form: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaForm use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_Form"
		end

	frozen get_element_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_ElementName"
		end

	frozen get_data_type: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_DataType"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_Namespace"
		end

	frozen get_is_nullable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlRootAttribute"
		alias
			"get_IsNullable"
		end

feature -- Element Change

	frozen set_data_type (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_DataType"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_Namespace"
		end

	frozen set_is_nullable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_IsNullable"
		end

	frozen set_element_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_ElementName"
		end

	frozen set_form (value: SYSTEM_XML_SCHEMA_XMLSCHEMAFORM) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaForm): System.Void use System.Xml.Serialization.XmlRootAttribute"
		alias
			"set_Form"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE
