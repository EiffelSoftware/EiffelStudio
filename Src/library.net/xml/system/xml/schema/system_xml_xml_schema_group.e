indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.XmlSchemaGroup"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_SCHEMA_GROUP

inherit
	SYSTEM_XML_XML_SCHEMA_ANNOTATED

create
	make_system_xml_xml_schema_group

feature {NONE} -- Initialization

	frozen make_system_xml_xml_schema_group is
		external
			"IL creator use System.Xml.Schema.XmlSchemaGroup"
		end

feature -- Access

	frozen get_particle: SYSTEM_XML_XML_SCHEMA_GROUP_BASE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaGroupBase use System.Xml.Schema.XmlSchemaGroup"
		alias
			"get_Particle"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaGroup"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaGroup"
		alias
			"set_Name"
		end

	frozen set_particle (value: SYSTEM_XML_XML_SCHEMA_GROUP_BASE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaGroupBase): System.Void use System.Xml.Schema.XmlSchemaGroup"
		alias
			"set_Particle"
		end

end -- class SYSTEM_XML_XML_SCHEMA_GROUP
