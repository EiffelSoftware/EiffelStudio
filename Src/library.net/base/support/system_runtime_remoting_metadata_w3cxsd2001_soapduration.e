indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPDURATION

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		end

feature -- Access

	frozen get_xsd_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"get_XsdType"
		end

feature -- Basic Operations

	frozen to_string_time_span (time_span: SYSTEM_TIMESPAN): STRING is
		external
			"IL static signature (System.TimeSpan): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"ToString"
		end

	frozen parse (value: STRING): SYSTEM_TIMESPAN is
		external
			"IL static signature (System.String): System.TimeSpan use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDuration"
		alias
			"Parse"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPDURATION
