indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.SoapSchemaExporter"

external class
	SYSTEM_XML_SERIALIZATION_SOAPSCHEMAEXPORTER

create
	make

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.SoapSchemaExporter"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_type_mapping: SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping_xml_members_mapping_boolean (xml_members_mapping: SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING; export_enclosing_type: BOOLEAN) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping, System.Boolean): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportMembersMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.SoapSchemaExporter"
		alias
			"ExportMembersMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_SOAPSCHEMAEXPORTER
