indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSchemaImporter"

external class
	SYSTEM_XML_SERIALIZATION_XMLSCHEMAIMPORTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.XmlSchemaImporter"
		end

	frozen make_1 (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS; type_identifiers: SYSTEM_XML_SERIALIZATION_CODEIDENTIFIERS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas, System.Xml.Serialization.CodeIdentifiers) use System.Xml.Serialization.XmlSchemaImporter"
		end

feature -- Basic Operations

	frozen import_derived_type_mapping_xml_qualified_name_type_boolean (name: SYSTEM_XML_XMLQUALIFIEDNAME; base_type: SYSTEM_TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type, System.Boolean): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

	frozen import_members_mapping (names: ARRAY [SYSTEM_XML_XMLQUALIFIEDNAME]): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_type_mapping (name: SYSTEM_XML_XMLQUALIFIEDNAME): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportTypeMapping"
		end

	frozen import_members_mapping_array_xml_qualified_name_type (names: ARRAY [SYSTEM_XML_XMLQUALIFIEDNAME]; base_type: SYSTEM_TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName[], System.Type, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_xml_qualified_name (name: SYSTEM_XML_XMLQUALIFIEDNAME): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_any_type (type_name: SYSTEM_XML_XMLQUALIFIEDNAME; element_name: STRING): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.String): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportAnyType"
		end

	frozen import_derived_type_mapping (name: SYSTEM_XML_XMLQUALIFIEDNAME; base_type: SYSTEM_TYPE): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.XmlSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSCHEMAIMPORTER
