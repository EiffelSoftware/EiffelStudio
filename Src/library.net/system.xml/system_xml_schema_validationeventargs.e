indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Xml.Schema.ValidationEventArgs"

frozen external class
	SYSTEM_XML_SCHEMA_VALIDATIONEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_severity: SYSTEM_XML_SCHEMA_XMLSEVERITYTYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSeverityType use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Severity"
		end

	frozen get_exception: SYSTEM_XML_SCHEMA_XMLSCHEMAEXCEPTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaException use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Exception"
		end

	frozen get_message: STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Message"
		end

end -- class SYSTEM_XML_SCHEMA_VALIDATIONEVENTARGS
