indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapCodeExporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_CODE_EXPORTER

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (code_namespace: SYSTEM_DLL_CODE_NAMESPACE) is
		external
			"IL creator signature (System.CodeDom.CodeNamespace) use System.Xml.Serialization.SoapCodeExporter"
		end

	frozen make_1 (code_namespace: SYSTEM_DLL_CODE_NAMESPACE; code_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT) is
		external
			"IL creator signature (System.CodeDom.CodeNamespace, System.CodeDom.CodeCompileUnit) use System.Xml.Serialization.SoapCodeExporter"
		end

feature -- Access

	frozen get_include_metadata: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.Xml.Serialization.SoapCodeExporter"
		alias
			"get_IncludeMetadata"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_type_mapping: SYSTEM_XML_XML_TYPE_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_XML_MEMBERS_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"ExportMembersMapping"
		end

	frozen add_mapping_metadata_code_attribute_declaration_collection_xml_member_mapping_boolean (metadata: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION; member: SYSTEM_XML_XML_MEMBER_MAPPING; force_use_member_name: BOOLEAN) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection, System.Xml.Serialization.XmlMemberMapping, System.Boolean): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"AddMappingMetadata"
		end

	frozen add_mapping_metadata (metadata: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION; member: SYSTEM_XML_XML_MEMBER_MAPPING) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection, System.Xml.Serialization.XmlMemberMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"AddMappingMetadata"
		end

end -- class SYSTEM_XML_SOAP_CODE_EXPORTER
