indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Metadata.W3cXsd2001.ISoapXsd"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ISOAP_XSD

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_xsd_type: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Runtime.Remoting.Metadata.W3cXsd2001.ISoapXsd"
		alias
			"GetXsdType"
		end

end -- class ISOAP_XSD
