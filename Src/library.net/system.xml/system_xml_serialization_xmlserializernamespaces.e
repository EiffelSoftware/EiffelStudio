indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSerializerNamespaces"

external class
	SYSTEM_XML_SERIALIZATION_XMLSERIALIZERNAMESPACES

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlSerializerNamespaces"
		end

	frozen make_1 (namespaces: ARRAY [SYSTEM_XML_XMLQUALIFIEDNAME]) is
		external
			"IL creator signature (System.Xml.XmlQualifiedName[]) use System.Xml.Serialization.XmlSerializerNamespaces"
		end

feature -- Basic Operations

	frozen to_array: ARRAY [SYSTEM_XML_XMLQUALIFIEDNAME] is
		external
			"IL signature (): System.Xml.XmlQualifiedName[] use System.Xml.Serialization.XmlSerializerNamespaces"
		alias
			"ToArray"
		end

	frozen add (prefix_: STRING; ns: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializerNamespaces"
		alias
			"Add"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSERIALIZERNAMESPACES
