indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapSchemaImporter"

external class
	SYSTEM_XML_SERIALIZATION_SOAPSCHEMAIMPORTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.SoapSchemaImporter"
		end

	frozen make_1 (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS; type_identifiers: SYSTEM_XML_SERIALIZATION_CODEIDENTIFIERS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas, System.Xml.Serialization.CodeIdentifiers) use System.Xml.Serialization.SoapSchemaImporter"
		end

feature -- Basic Operations

	frozen import_members_mapping (name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER]): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[]): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_soap_schema_member_boolean (name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER]; has_wrapper_element: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[], System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_array_soap_schema_member_boolean_type (name: STRING; ns: STRING; members: ARRAY [SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER]; has_wrapper_element: BOOLEAN; base_type: SYSTEM_TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember[], System.Boolean, System.Type, System.Boolean): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_members_mapping_string_string_soap_schema_member (name: STRING; ns: STRING; member: SYSTEM_XML_SERIALIZATION_SOAPSCHEMAMEMBER): SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING is
		external
			"IL signature (System.String, System.String, System.Xml.Serialization.SoapSchemaMember): System.Xml.Serialization.XmlMembersMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportMembersMapping"
		end

	frozen import_derived_type_mapping (name: SYSTEM_XML_XMLQUALIFIEDNAME; base_type: SYSTEM_TYPE; base_type_can_be_indirect: BOOLEAN): SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING is
		external
			"IL signature (System.Xml.XmlQualifiedName, System.Type, System.Boolean): System.Xml.Serialization.XmlTypeMapping use System.Xml.Serialization.SoapSchemaImporter"
		alias
			"ImportDerivedTypeMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPSCHEMAIMPORTER
