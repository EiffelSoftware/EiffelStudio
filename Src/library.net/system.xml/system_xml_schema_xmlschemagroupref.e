indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaGroupRef"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPREF

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAPARTICLE

create
	make_xmlschemagroupref

feature {NONE} -- Initialization

	frozen make_xmlschemagroupref is
		external
			"IL creator use System.Xml.Schema.XmlSchemaGroupRef"
		end

feature -- Access

	frozen get_particle: SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPBASE is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaGroupBase use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"get_Particle"
		end

	frozen get_ref_name: SYSTEM_XML_XMLQUALIFIEDNAME is
		external
			"IL signature (): System.Xml.XmlQualifiedName use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"get_RefName"
		end

feature -- Element Change

	frozen set_ref_name (value: SYSTEM_XML_XMLQUALIFIEDNAME) is
		external
			"IL signature (System.Xml.XmlQualifiedName): System.Void use System.Xml.Schema.XmlSchemaGroupRef"
		alias
			"set_RefName"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAGROUPREF
