indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPPOSITIVEINTEGER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_ISOAPXSD
		rename
			get_xsd_type as get_xsd_type_string
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		end

	frozen make_1 (value: SYSTEM_DECIMAL) is
		external
			"IL creator signature (System.Decimal) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		end

feature -- Access

	frozen get_value: SYSTEM_DECIMAL is
		external
			"IL signature (): System.Decimal use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"get_Value"
		end

	frozen get_xsd_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"get_XsdType"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_DECIMAL) is
		external
			"IL signature (System.Decimal): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"set_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"GetHashCode"
		end

	frozen get_xsd_type_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"GetXsdType"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"Equals"
		end

	frozen parse (value: STRING): SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPPOSITIVEINTEGER is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapPositiveInteger"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPPOSITIVEINTEGER
