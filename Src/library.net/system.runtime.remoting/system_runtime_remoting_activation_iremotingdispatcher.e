indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Activation.IRemotingDispatcher"

deferred external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_IREMOTINGDISPATCHER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	do_gccollect is
		external
			"IL deferred signature (): System.Void use System.Runtime.Remoting.Activation.IRemotingDispatcher"
		alias
			"DoGCCollect"
		end

	request_configure_remoting (full_config_file_name: STRING): INTEGER is
		external
			"IL deferred signature (System.String): System.Int32 use System.Runtime.Remoting.Activation.IRemotingDispatcher"
		alias
			"RequestConfigureRemoting"
		end

	stop_processing is
		external
			"IL deferred signature (): System.Void use System.Runtime.Remoting.Activation.IRemotingDispatcher"
		alias
			"StopProcessing"
		end

	start_processing is
		external
			"IL deferred signature (): System.Void use System.Runtime.Remoting.Activation.IRemotingDispatcher"
		alias
			"StartProcessing"
		end

	process_request (url: STRING; cb_request_hdr_data: INTEGER; request_headers_and_body: ARRAY [INTEGER_8]; cb_response_hdr_data: INTEGER; response_headers_and_body: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL deferred signature (System.String, System.Int32, System.Byte[], System.Int32&, System.Byte[]&): System.Int32 use System.Runtime.Remoting.Activation.IRemotingDispatcher"
		alias
			"ProcessRequest"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATION_IREMOTINGDISPATCHER
