indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSerializerNamespaces"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SERIALIZER_NAMESPACES

inherit
	SYSTEM_OBJECT

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (namespaces: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME]) is
		external
			"IL creator signature (System.Xml.XmlQualifiedName[]) use System.Xml.Serialization.XmlSerializerNamespaces"
		end

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlSerializerNamespaces"
		end

	frozen make_1 (namespaces: SYSTEM_XML_XML_SERIALIZER_NAMESPACES) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSerializerNamespaces) use System.Xml.Serialization.XmlSerializerNamespaces"
		end

feature -- Access

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Xml.Serialization.XmlSerializerNamespaces"
		alias
			"get_Count"
		end

feature -- Basic Operations

	frozen to_array: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME] is
		external
			"IL signature (): System.Xml.XmlQualifiedName[] use System.Xml.Serialization.XmlSerializerNamespaces"
		alias
			"ToArray"
		end

	frozen add (prefix_: SYSTEM_STRING; ns: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Xml.Serialization.XmlSerializerNamespaces"
		alias
			"Add"
		end

end -- class SYSTEM_XML_XML_SERIALIZER_NAMESPACES
