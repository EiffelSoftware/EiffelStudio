indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.XmlImplementation"

external class
	SYSTEM_XML_XMLIMPLEMENTATION

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.XmlImplementation"
		end

feature -- Basic Operations

	create_document: SYSTEM_XML_XMLDOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlImplementation"
		alias
			"CreateDocument"
		end

	frozen has_feature (str_feature: STRING; str_version: STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlImplementation"
		alias
			"HasFeature"
		end

end -- class SYSTEM_XML_XMLIMPLEMENTATION
