indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_DATE_TIME

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		end

feature -- Access

	frozen get_xsd_type: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"get_XsdType"
		end

feature -- Basic Operations

	frozen to_string_date_time (value: SYSTEM_DATE_TIME): SYSTEM_STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"ToString"
		end

	frozen parse (value: SYSTEM_STRING): SYSTEM_DATE_TIME is
		external
			"IL static signature (System.String): System.DateTime use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"Parse"
		end

end -- class SOAP_DATE_TIME
