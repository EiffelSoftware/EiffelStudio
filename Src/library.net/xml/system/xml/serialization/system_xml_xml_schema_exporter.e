indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.XmlSchemaExporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_EXPORTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_XML_SCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.XmlSchemaExporter"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_members_mapping: SYSTEM_XML_XML_MEMBERS_MAPPING): SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_XML_MEMBERS_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportMembersMapping"
		end

	frozen export_any_type (ns: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportAnyType"
		end

	frozen export_type_mapping_xml_type_mapping (xml_type_mapping: SYSTEM_XML_XML_TYPE_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportTypeMapping"
		end

end -- class SYSTEM_XML_XML_SCHEMA_EXPORTER
