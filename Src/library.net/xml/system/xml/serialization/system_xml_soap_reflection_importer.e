indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapReflectionImporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_REFLECTION_IMPORTER

inherit
	SYSTEM_OBJECT

create
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (attribute_overrides: SYSTEM_XML_SOAP_ATTRIBUTE_OVERRIDES; default_namespace: SYSTEM_STRING) is
		external
			"IL creator signature (System.Xml.Serialization.SoapAttributeOverrides, System.String) use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make_2 (attribute_overrides: SYSTEM_XML_SOAP_ATTRIBUTE_OVERRIDES) is
		external
			"IL creator signature (System.Xml.Serialization.SoapAttributeOverrides) use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make is
		external
			"IL creator use System.Xml.Serialization.SoapReflectionImporter"
		end

	frozen make_1 (default_namespace: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Xml.Serialization.SoapReflectionImporter"
		end

feature -- Basic Operations

	frozen import_members_mapping_string_string_array_xml_reflection_member_boolean_boolean (element_name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_XML_REFLECTION_MEMBER]; has_wrapper_element: BOOLEAN; write_accessors: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_xml_reflection_member_boolean_boolean_boolean (element_name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_XML_REFLECTION_MEMBER]; has_wrapper_element: BOOLEAN; write_accessors: BOOLEAN; validate: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[], System.Boolean, System.Boolean, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

	frozen include_types (provider: ICUSTOM_ATTRIBUTE_PROVIDER) is
		external
			"IL signature (System.Reflection.ICustomAttributeProvider): System.Void use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"IncludeTypes"
		end

	frozen include_type (type: TYPE) is
		external
			"IL signature (System.Type): System.Void use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"IncludeType"
		end

	frozen import_type_mapping (type: TYPE): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_type_mapping_type_string (type: TYPE; default_namespace: SYSTEM_STRING): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Type, System.String): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping (element_name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_XML_REFLECTION_MEMBER]): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.XmlReflectionMember[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapReflectionImporter"
		alias
			"ImportMembersMapping"
		end

end -- class SYSTEM_XML_SOAP_REFLECTION_IMPORTER
