indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPNONPOSITIVEINTEGER

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
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		end

	frozen make_1 (value2: SYSTEM_DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		end

feature -- Access

	frozen get_value: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value2: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"set_Value"
		end

feature -- Basic Operations

	frozen parse (value2: STRING): SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPNONPOSITIVEINTEGER is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"Parse"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"ToString"
		end

	frozen get_xsd_type: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"GetXsdType"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapNonPositiveInteger"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPNONPOSITIVEINTEGER
