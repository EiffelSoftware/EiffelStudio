indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlTextAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLTEXTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmltextattribute,
	make_xmltextattribute_1

feature {NONE} -- Initialization

	frozen make_xmltextattribute is
		external
			"IL creator use System.Xml.Serialization.XmlTextAttribute"
		end

	frozen make_xmltextattribute_1 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Xml.Serialization.XmlTextAttribute"
		end

feature -- Access

	frozen get_type_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Xml.Serialization.XmlTextAttribute"
		alias
			"get_Type"
		end

feature -- Element Change

	frozen set_type (value: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlTextAttribute"
		alias
			"set_Type"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLTEXTATTRIBUTE
