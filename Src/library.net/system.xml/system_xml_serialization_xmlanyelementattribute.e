indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAnyElementAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlanyelementattribute,
	make_xmlanyelementattribute_1,
	make_xmlanyelementattribute_2

feature {NONE} -- Initialization

	frozen make_xmlanyelementattribute is
		external
			"IL creator use System.Xml.Serialization.XmlAnyElementAttribute"
		end

	frozen make_xmlanyelementattribute_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlAnyElementAttribute"
		end

	frozen make_xmlanyelementattribute_2 (name: STRING; ns: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.Serialization.XmlAnyElementAttribute"
		end

feature -- Access

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"get_Namespace"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"set_Name"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyElementAttribute"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLANYELEMENTATTRIBUTE
