indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_YEAR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISOAP_XSD
		rename
			get_xsd_type as get_xsd_type_string
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (value: SYSTEM_DATE_TIME; sign: INTEGER) is
		external
			"IL creator signature (System.DateTime, System.Int32) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		end

	frozen make_1 (value: SYSTEM_DATE_TIME) is
		external
			"IL creator signature (System.DateTime) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		end

feature -- Access

	frozen get_sign: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"get_Sign"
		end

	frozen get_value: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"get_Value"
		end

	frozen get_xsd_type: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"get_XsdType"
		end

feature -- Element Change

	frozen set_sign (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"set_Sign"
		end

	frozen set_value (value: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"set_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"GetHashCode"
		end

	frozen get_xsd_type_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"GetXsdType"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"Equals"
		end

	frozen parse (value: SYSTEM_STRING): SOAP_YEAR is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapYear"
		alias
			"Finalize"
		end

end -- class SOAP_YEAR
