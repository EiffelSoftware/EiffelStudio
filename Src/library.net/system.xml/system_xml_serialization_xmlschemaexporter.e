indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Serialization.XmlSchemaExporter"

external class
	SYSTEM_XML_SERIALIZATION_XMLSCHEMAEXPORTER

create
	make

feature {NONE} -- Initialization

	frozen make (schemas: SYSTEM_XML_SERIALIZATION_XMLSCHEMAS) is
		external
			"IL creator signature (System.Xml.Serialization.XmlSchemas) use System.Xml.Serialization.XmlSchemaExporter"
		end

feature -- Basic Operations

	frozen export_type_mapping (xml_members_mapping: SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING): SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Xml.XmlQualifiedName use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportTypeMapping"
		end

	frozen export_members_mapping (xml_members_mapping: SYSTEM_XML_SERIALIZATION_XMLMEMBERSMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlMembersMapping): System.Void use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportMembersMapping"
		end

	frozen export_any_type (ns: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportAnyType"
		end

	frozen export_type_mapping_xml_type_mapping (xml_type_mapping: SYSTEM_XML_SERIALIZATION_XMLTYPEMAPPING) is
		external
			"IL signature (System.Xml.Serialization.XmlTypeMapping): System.Void use System.Xml.Serialization.XmlSchemaExporter"
		alias
			"ExportTypeMapping"
		end

end -- class SYSTEM_XML_SERIALIZATION_XMLSCHEMAEXPORTER
