indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapReflectionImporter"

external class
	SYSTEM_XML_SERIALIZATION_SOAPREFLECTIONIMPORTER

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (attribute_overrides: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEOVERRIDES; default_namespace: STRING) is
		external
			"IL creator signature (System.Xml.Serialization.SoapAttributeOverrides, System.String) use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make_2 (attribute_overrides: SYSTEM_XML_SERIALIZATION_SOAPATTRIBUTEOVERRIDES) is
		external
			"IL creator signature (System.Xml.Serialization.SoapAttributeOverrides) use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make_1 (default_namespace: STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapReflectionImporter"
		end

feature -- Basic Operations

	frozen import_members_mapping_string_string_array_xml_reflection_member_boolean_boolean (element_name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER]; has_wrapper_element: BOOLEAN; write_accessors: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_xml_reflection_member_boolean_boolean_boolean (element_name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER]; has_wrapper_element: BOOLEAN; write_accessors: BOOLEAN; validate: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean, System.Boolean, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen include_types (provider: SYSTEM_REFLECTION_ICUSTOMATTRIBUTEPROVIDER) is
		external
			"IL signature (System.Reflection.ICustomAttributeProvider): System.Void use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"IncludeTypes"
		end

	frozen include_type (type: SYSTEM_TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"IncludeType"
		end

	frozen import_type_mapping (type: SYSTEM_TYPE): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_type_mapping_type_string (type: SYSTEM_TYPE; default_namespace: STRING): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping (element_name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_XMLREFLECTIONMEMBER]): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPREFLECTIONIMPORTER
