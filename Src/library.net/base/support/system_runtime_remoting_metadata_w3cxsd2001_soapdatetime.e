indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPDATETIME

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		end

feature -- Access

	frozen get_xsd_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"get_XsdType"
		end

feature -- Basic Operations

	frozen parse (value: STRING): SYSTEM_DATETIME is
		external
			"IL static signature (System.String): System.DateTime use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"Parse"
		end

	frozen to_string_date_time (value: SYSTEM_DATETIME): STRING is
		external
			"IL static signature (System.DateTime): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapDateTime"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPDATETIME
