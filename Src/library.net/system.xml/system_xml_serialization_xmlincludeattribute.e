indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlIncludeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLINCLUDEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlincludeattribute

feature {NONE} -- Initialization

	frozen make_xmlincludeattribute (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlIncludeAttribute"
		end

feature -- Access

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlIncludeAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlIncludeAttribute"
		alias
			"set_Type"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLINCLUDEATTRIBUTE
