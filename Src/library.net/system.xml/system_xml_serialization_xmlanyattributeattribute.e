indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlAnyAttributeAttribute"

external class
	SYSTEM_XML_SERIALIZATION_XMLANYATTRIBUTEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_xmlanyattributeattribute_2,
	make_xmlanyattributeattribute,
	make_xmlanyattributeattribute_1

feature {NONE} -- Initialization

	frozen make_xmlanyattributeattribute_2 (name: STRING; ns: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Xml.Serialization.XmlAnyAttributeAttribute"
		end

	frozen make_xmlanyattributeattribute is
		external
			"IL creator use System.Xml.Serialization.XmlAnyAttributeAttribute"
		end

	frozen make_xmlanyattributeattribute_1 (name: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlAnyAttributeAttribute"
		end

feature -- Access

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyAttributeAttribute"
		alias
			"get_Namespace"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Serialization.XmlAnyAttributeAttribute"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyAttributeAttribute"
		alias
			"set_Name"
		end

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Serialization.XmlAnyAttributeAttribute"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLANYATTRIBUTEATTRIBUTE
