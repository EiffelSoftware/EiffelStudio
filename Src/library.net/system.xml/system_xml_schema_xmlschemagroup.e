indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaGroup"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAGROUP

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemagroup

feature {NONE} -- Initialization

	frozen make_xmlschemagroup is
		external
			"IL creator use System.Xml.Schema.XmlSchemaGroup"
		end

feature -- Access

	frozen get_particle: SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaGroupBase use System.Xml.Schema.XmlSchemaGroup"
		alias
			"get_Particle"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaGroup"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaGroup"
		alias
			"set_Name"
		end

	frozen set_particle (value: SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaGroupBase): System.Void use System.Xml.Schema.XmlSchemaGroup"
		alias
			"set_Particle"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAGROUP
