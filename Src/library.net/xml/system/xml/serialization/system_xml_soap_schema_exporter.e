indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Serialization.SoapSchemaExporter"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_SOAP_SCHEMA_EXPORTER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_XML_SCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.SoapSchemaExporter"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_type_mapping: SYSTEM_XML_XML_TYPE_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping_xml_members_mapping_boolean (xml_members_mapping: SYSTEM_XML_XML_MEMBERS_MAPPING; export_enclosing_type: BOOLEAN) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping, System.Boolean): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportMembersMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_XML_MEMBERS_MAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportMembersMapping"
		end

end -- class SYSTEM_XML_SOAP_SCHEMA_EXPORTER
