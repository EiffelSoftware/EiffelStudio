indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPYEARMONTH

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_ISOAPXSD

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (value2: SYSTEM_DATETIME; sign2: INTEGER) is
		external
			"IL creator signature (System.DateTime, System.Int32) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		end

	frozen make_1 (value2: SYSTEM_DATETIME) is
		external
			"IL creator signature (System.DateTime) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		end

feature -- Access

	frozen get_sign: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"get_Sign"
		end

	frozen get_value: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_sign (value2: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"set_Sign"
		end

	frozen set_value (value2: SYSTEM_DATETIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"set_Value"
		end

feature -- Basic Operations

	frozen parse (value2: STRING): SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPYEARMONTH is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"Parse"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"ToString"
		end

	frozen get_xsd_type: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"GetXsdType"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYearMonth"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPYEARMONTH
