indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPBASE64BINARY

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
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		end

	frozen make_1 (value: ARRAY [INTEGER_8]) is
		external
			"IL creator signature (System.Byte[]) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		end

feature -- Access

	frozen get_value: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"get_Value"
		end

	frozen get_xsd_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"get_XsdType"
		end

feature -- Element Change

	frozen set_value (value: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"set_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"GetHashCode"
		end

	frozen get_xsd_type_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"GetXsdType"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"Equals"
		end

	frozen parse (value: STRING): SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPBASE64BINARY is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapBase64Binary"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPBASE64BINARY
