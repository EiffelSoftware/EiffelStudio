indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaImport"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAIMPORT

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAEXTERNAL

create
	make_xmlschemaimport

feature {NONE} -- Initialization

	frozen make_xmlschemaimport is
		external
			"IL creator use System.Xml.Schema.XmlSchemaImport"
		end

feature -- Access

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaImport"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaImport"
		alias
			"set_Namespace"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAIMPORT
