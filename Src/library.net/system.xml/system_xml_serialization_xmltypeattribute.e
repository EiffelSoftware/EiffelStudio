indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlTypeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLTYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmltypeattribute_1,
	make_xmltypeattribute

feature {NONE} -- Initialization

	frozen make_xmltypeattribute_1 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlTypeAttribute"
		end

	frozen make_xmltypeattribute is
		external
			"IL creator use System.Xml.Serialization.XmlTypeAttribute"
		end

feature -- Access

	frozen get_type_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_TypeName"
		end

	frozen get_include_in_schema: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_IncludeInSchema"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_type_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_TypeName"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_Namespace"
		end

	frozen set_include_in_schema (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Xml.Serialization.XmlTypeAttribute"
		alias
			"set_IncludeInSchema"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLTYPEATTRIBUTE
