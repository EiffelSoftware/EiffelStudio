indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.InternalRemotingServices"

external class
	SYSTEM_RUNTIME_REMOTING_INTERNALREMOTINGSERVICES

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.InternalRemotingServices"
		end

feature -- Basic Operations

	frozen remoting_assert (condition: BOOLEAN; message: STRING) is
		external
			"IL static signature (System.Boolean, System.String): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"RemotingAssert"
		end

	frozen debug_out_chnl (s: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"DebugOutChnl"
		end

	frozen remoting_trace (messages: ARRAY [ANY]) is
		external
			"IL static signature (System.Object[]): System.Void use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"RemotingTrace"
		end

	frozen get_cached_soap_attribute (reflection_object: ANY): SYSTEM_RUNTIME_REMOTING_METADATA_SOAPATTRIBUTE is
		external
			"IL static signature (System.Object): System.Runtime.Remoting.Metadata.SoapAttribute use System.Runtime.Remoting.InternalRemotingServices"
		alias
			"GetCachedSoapAttribute"
		end

end -- class SYSTEM_RUNTIME_REMOTING_INTERNALREMOTINGSERVICES
