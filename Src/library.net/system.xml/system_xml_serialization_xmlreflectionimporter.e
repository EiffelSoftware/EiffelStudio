indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlReflectionImporter"

external class
	SYSTEM_XML_SERIALIZATION_XMLREFLECTIONIMPORTER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (attribute_overrides: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEOVERRIDES; default_namespace: STRING) is
		external
			"IL creator signature (System.Xml.Serialization.XmlAttributeOverrides, System.String) use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make_2 (attribute_overrides: SYSTEM_XML_SERIALIZATION_XMLATTRIBUTEOVERRIDES) is
		external
			"IL creator signature (System.Xml.Serialization.XmlAttributeOverrides) use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make is
		external
			"IL creator use System.Xml.Serialization.XmlReflectionImporter"
		end

	frozen make_1 (default_namespace: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.XmlReflectionImporter"
		end

feature -- Basic Operations

	frozen import_type_mapping_type_xml_root_attribute (type: SYSTEM_TYPE; root: SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type, System.Xml.Serialization.XmlRootAttribute): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen include_types (provider: SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER) is
		external
			"IL signature (System.Reflection.ICustomAttributeProvider): System.Void use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"IncludeTypes"
		end

	frozen include_type (type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"IncludeType"
		end

	frozen import_type_mapping (type: SYSTEM_TYPE): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_type_mapping_type_string (type: SYSTEM_TYPE; default_namespace: STRING): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping (element_name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER]; has_wrapper_element: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_type_mapping_type_xml_root_attribute_string (type: SYSTEM_TYPE; root: SYSTEM_XML_SERIALIZATION_XMLROOTATTRIBUTE; default_namespace: STRING): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type, System.Xml.Serialization.XmlRootAttribute, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlReflectionImporter"
		alias
			"ImportTypeMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLREFLECTIONIMPORTER
