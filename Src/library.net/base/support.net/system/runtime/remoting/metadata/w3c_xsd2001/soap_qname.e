indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SOAP_QNAME

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
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_3 (key: SYSTEM_STRING; name: SYSTEM_STRING; namespace_value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		end

	frozen make_2 (key: SYSTEM_STRING; name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		end

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		end

	frozen make_1 (value: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		end

feature -- Access

	frozen get_namespace: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"get_Namespace"
		end

	frozen get_key: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"get_Key"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"get_Name"
		end

	frozen get_xsd_type: SYSTEM_STRING is
		external
			"IL static signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"get_XsdType"
		end

feature -- Element Change

	frozen set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"set_Name"
		end

	frozen set_namespace (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"set_Namespace"
		end

	frozen set_key (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"set_Key"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"GetHashCode"
		end

	frozen get_xsd_type_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"GetXsdType"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"Equals"
		end

	frozen parse (value: SYSTEM_STRING): SOAP_QNAME is
		external
			"IL static signature (System.String): System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"Parse"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Metadata.W3cXsd2001.SoapQName"
		alias
			"Finalize"
		end

end -- class SOAP_QNAME
