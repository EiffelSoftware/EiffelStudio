indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"

frozen external class
	SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPIDREF

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
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		end

	frozen make_1 (value: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"get_Value"
		end

	frozen get_xsd_type: STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"get_XsdType"
		end

feature -- Element Change

	frozen set_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"set_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"GetHashCode"
		end

	frozen get_xsd_type_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"GetXsdType"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"Equals"
		end

	frozen parse (value: STRING): SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPIDREF is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapIdref"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATA_W3CXSD2001_SOAPIDREF
