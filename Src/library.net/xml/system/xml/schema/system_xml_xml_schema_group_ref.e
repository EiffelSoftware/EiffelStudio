indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaGroupRef"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_GROUP_REF

inherit
	SYSTEM_XML_XML_SCHEMA_PARTICLE

create
	make_system_xml_xml_schema_group_ref

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_group_ref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaGroupRef"
		end

feature -- Access

	frozen get_particle: SYSTEM_XML_XML_SCHEMA_GROUP_BASE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaGroupBase use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"get_Particle"
		end

	frozen get_ref_name: SYSTEM_XML_XML_QUALIFIED_NAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"get_RefName"
		end

feature -- Element Change

	frozen set_ref_name (value: SYSTEM_XML_XML_QUALIFIED_NAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"set_RefName"
		end

end -- class SYSTEM_XML_XML_SCHEMA_GROUP_REF
