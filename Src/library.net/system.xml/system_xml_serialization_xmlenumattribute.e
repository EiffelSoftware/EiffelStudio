indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlEnumAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLENUMATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlenumattribute,
	make_xmlenumattribute_1

feature {NONE} -- Initialization

	frozen make_xmlenumattribute is
		external
			"IL creator use System.Xml.Serialization.XmlEnumAttribute"
		end

	frozen make_xmlenumattribute_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlEnumAttribute"
		end

feature -- Access

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlEnumAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlEnumAttribute"
		alias
			"set_Name"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLENUMATTRIBUTE
