indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapSchemaImporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_SCHEMA_IMPORTER

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_XML_SCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.SoapSchemaImporter"
		end

	frozen make_1 (schemas: SYSTEM_XML_XML_SCHEMAS; type_identifiers: SYSTEM_XML_CODE_IDENTIFIERS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas, System.Xml.Serialization.CodeIdentifiers) use System.Xml.Serialization.SoapSchemaImporter"
		end

feature -- Basic Operations

	frozen import_members_mapping (name: SYSTEM_STRING; ns: SYSTEM_STRING; member: SYSTEM_XML_SOAP_SCHEMA_MEMBER): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_soap_schema_member_boolean (name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_SOAP_SCHEMA_MEMBER]; has_wrapper_element: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[], System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_soap_schema_member_boolean_type (name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_SOAP_SCHEMA_MEMBER]; has_wrapper_element: BOOLEAN; base_type: TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[], System.Boolean, System.Type, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_soap_schema_member (name: SYSTEM_STRING; ns: SYSTEM_STRING; members: NATIVE_ARRAY [SYSTEM_XML_SOAP_SCHEMA_MEMBER]): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_derived_type_mapping (name: SYSTEM_XML_XML_QUALIFIED_NAME; base_type: TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type, System.Boolean): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

end -- class SYSTEM_XML_SOAP_SCHEMA_IMPORTER
