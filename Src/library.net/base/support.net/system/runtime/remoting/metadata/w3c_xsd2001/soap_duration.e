indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_DURATION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		end

feature -- Access

	frozen get_xsd_type: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"get_XsdType"
		end

feature -- Basic Operations

	frozen to_string_time_span (time_span: TIME_SPAN): SYSTEM_STRING is
		external
			"IL static signature (System.TimeSpan): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"ToString"
		end

	frozen parse (value: SYSTEM_STRING): TIME_SPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"Parse"
		end

end -- class SOAP_DURATION
