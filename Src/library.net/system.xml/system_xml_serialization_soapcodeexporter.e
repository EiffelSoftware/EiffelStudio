indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapCodeExporter"

external class
	SYSTEM_XML_SERIALIZATION_SOAPCODEEXPORTER

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (code_namespace: SYSTEM_CODEDOM_CODENAMESPACE) is
		external
			"IL creator signature (System.CodeDom.CodeNamespace) use System.Xml.Serialization.SoapCodeExporter"
		end

	frozen make_1 (code_namespace: SYSTEM_CODEDOM_CODENAMESPACE; code_compile_unit: SYSTEM_CODEDOM_CODECOMPILEUNIT) is
		external
			"IL creator signature (System.CodeDom.CodeNamespace, System.CodeDom.CodeCompileUnit) use System.Xml.Serialization.SoapCodeExporter"
		end

feature -- Access

	frozen get_include_metadata: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION is
		external
			"IL signature (): System.CodeDom.CodeAttributeDeclarationCollection use System.Xml.Serialization.SoapCodeExporter"
		alias
			"get_IncludeMetadata"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_type_mapping: SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"ExportMembersMapping"
		end

	frozen add_mapping_metadata_code_attribute_declaration_collection_xml_member_mapping_boolean (metadata: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION; member: SYSTEM_XML_SERIALIZATION_XMLMEMBERMAPPING; force_use_member_name: BOOLEAN) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection, System.Xml.Serialization.XmlMemberMapping, System.Boolean): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"AddMappingMetadata"
		end

	frozen add_mapping_metadata (metadata: SYSTEM_CODEDOM_CODEATTRIBUTEDECLARATIONCOLLECTION; member: SYSTEM_XML_SERIALIZATION_XMLMEMBERMAPPING) is
		external
			"IL signature (System.CodeDom.CodeAttributeDeclarationCollection, System.Xml.Serialization.XmlMemberMapping): System.Void use System.Xml.Serialization.SoapCodeExporter"
		alias
			"AddMappingMetadata"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPCODEEXPORTER
