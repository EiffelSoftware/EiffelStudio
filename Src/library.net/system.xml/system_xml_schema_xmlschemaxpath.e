indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.XmlSchemaXPath"

external class
	SYSTEM_XML_SCHEMA_XMLSCHEMAXPATH

inherit
	SYSTEM_XML_SCHEMA_XMLSCHEMAANNOTATED

create
	make_xmlschemaxpath

feature {NONE} -- Initialization

	frozen make_xmlschemaxpath is
		external
			"IL creator use System.Xml.Schema.XmlSchemaXPath"
		end

feature -- Access

	frozen get_xpath: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.XmlSchemaXPath"
		alias
			"get_XPath"
		end

feature -- Element Change

	frozen set_xpath (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Xml.Schema.XmlSchemaXPath"
		alias
			"set_XPath"
		end

end -- class SYSTEM_XML_SCHEMA_XMLSCHEMAXPATH
