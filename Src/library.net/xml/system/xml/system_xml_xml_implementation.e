indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.XmlImplementation"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_XML_XML_IMPLEMENTATION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Xml.XmlImplementation"
		end

feature -- Basic Operations

	create_document: SYSTEM_XML_XML_DOCUMENT is
		external
			"IL signature (): System.Xml.XmlDocument use System.Xml.XmlImplementation"
		alias
			"CreateDocument"
		end

	frozen has_feature (str_feature: SYSTEM_STRING; str_version: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String, System.String): System.Boolean use System.Xml.XmlImplementation"
		alias
			"HasFeature"
		end

end -- class SYSTEM_XML_XML_IMPLEMENTATION
