indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSchemaImporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_IMPORTER

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_XML_SCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.XmlSchemaImporter"
		end

	frozen make_1 (schemas: SYSTEM_XML_XML_SCHEMAS; type_identifiers: SYSTEM_XML_CODE_IDENTIFIERS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas, System.Xml.Serialization.CodeIdentifiers) use System.Xml.Serialization.XmlSchemaImporter"
		end

feature -- Basic Operations

	frozen import_derived_type_mapping_xml_qualified_name_type_boolean (name: SYSTEM_XML_XML_QUALIFIED_NAME; base_type: TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type, System.Boolean): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

	frozen import_members_mapping (name: SYSTEM_XML_XML_QUALIFIED_NAME): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_type_mapping (name: SYSTEM_XML_XML_QUALIFIED_NAME): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping_array_xml_qualified_name_type (names: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME]; base_type: TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName[], System.Type, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_array_xml_qualified_name (names: NATIVE_ARRAY [SYSTEM_XML_XML_QUALIFIED_NAME]): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_any_type (type_name: SYSTEM_XML_XML_QUALIFIED_NAME; element_name: SYSTEM_STRING): SYSTEM_XML_XML_MEMBERS_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.String): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportAnyType"
		end

	frozen import_derived_type_mapping (name: SYSTEM_XML_XML_QUALIFIED_NAME; base_type: TYPE): SYSTEM_XML_XML_TYPE_MAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

end -- class SYSTEM_XML_XML_SCHEMA_IMPORTER
