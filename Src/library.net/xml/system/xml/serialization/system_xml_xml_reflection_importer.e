indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlReflectionImporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_REFLECTION_IMPORTER

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (attribute_overrides: SYSTEM_XML_XML_ATTRIBUTE_OVERRIDES; default_namespace: SYSTEM_STRING) is
		external
			"IL creator signature (System.Xml.Serialization.XmlAttributeOverrides, System.String) use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make_2 (attribute_overrides: SYSTEM_XML_XML_ATTRIBUTE_OVERRIDES) is
		external
			"IL creator signature (System.Xml.Serialization.XmlAttributeOverrides) use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make_1 (default_namespace: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlReflectionImporter"
		end

feature -- Basic Operations

	frozen import_type_mapping_type_xml_root_attribute (type: TYPE; root: SYSTEM_XML_XML_ROOT_ATTRIBUTE): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type, System.Xml.Serialization.XmlRootAttribute): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen include_types (provider: ICUSTOM_ATTRIBUTE_PROVIDER) is
		external
			"IL signature (System.Reflection.ICustomAttributeProvider): System.Void use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"IncludeTypes"
		end

	frozen include_type (type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"IncludeType"
		end

	frozen import_type_mapping (type: TYPE): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_type_mapping_type_string (type: TYPE; default_namespace: SYSTEM_STRING): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping (element_name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_XML_REFLECTION_MEMBER]; has_wrapper_element: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_type_mapping_type_xml_root_attribute_string (type: TYPE; root: SYSTEM_XML_XML_ROOT_ATTRIBUTE; default_namespace: SYSTEM_STRING): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type, System.Xml.Serialization.XmlRootAttribute, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

end -- class SYSTEM_XML_XML_REFLECTION_IMPORTER
