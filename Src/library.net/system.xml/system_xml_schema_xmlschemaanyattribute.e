indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaAnyAttribute"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaanyattribute

feature {NONE} -- Initialization

	frozen make_xmlschemaanyattribute is
		external
			"IL creator use System.Xml.Schema.XmlSchemaAnyAttribute"
		end

feature -- Access

	frozen get_process_contents: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTPROCESSING is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaContentProcessing use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"get_ProcessContents"
		end

	frozen get_namespace: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"get_Namespace"
		end

feature -- Element Change

	frozen set_namespace (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"set_Namespace"
		end

	frozen set_process_contents (value: SYSTEM_XML_SCHEMA_XMLSCHEMACONTENTPROCESSING) is
		external
			"IL signature (System.Xml.Schema.XmlSchemaContentProcessing): System.Void use System.Xml.Schema.XmlSchemaAnyAttribute"
		alias
			"set_ProcessContents"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAANYATTRIBUTE
