indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.InternalRemotingServices"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	INTERNAL_REMOTING_SERVICES

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.InternalRemotingServices"
		end

feature -- Basic Operations

	frozen remoting_assert (condition: BOOLEAN; message: SYSTEM_STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"RemotingAssert"
		end

	frozen debug_out_chnl (s: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"DebugOutChnl"
		end

	frozen remoting_trace (messages: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL static signature (System.Object[]): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"RemotingTrace"
		end

	frozen get_cached_soap_attribute (reflection_object: SYSTEM_OBJECT): SOAP_ATTRIBUTE is
		external
			"IL static signature (System.Object): System.Runtime.Remoting.Metadata.SoapAttribute use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"GetCachedSoapAttribute"
		end

end -- class INTERNAL_REMOTING_SERVICES
