indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Xml.Schema.ValidationEventArgs"
	assembly: "System.Xml", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_XML_VALIDATION_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_severity: SYSTEM_XML_XML_SEVERITY_TYPE is
		external
			"IL signature (): System.Xml.Schema.XmlSeverityType use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Severity"
		end

	frozen get_exception: SYSTEM_XML_XML_SCHEMA_EXCEPTION is
		external
			"IL signature (): System.Xml.Schema.XmlSchemaException use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Exception"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Xml.Schema.ValidationEventArgs"
		alias
			"get_Message"
		end

end -- class SYSTEM_XML_VALIDATION_EVENT_ARGS
