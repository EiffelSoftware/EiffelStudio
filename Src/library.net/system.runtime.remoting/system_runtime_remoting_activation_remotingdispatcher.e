indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Activation.RemotingDispatcher"

frozen external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_REMOTINGDISPATCHER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RUNTIME_REMOTING_ACTIVATION_IREMOTINGDISPATCHER

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Runtime.Remoting.Activation.RemotingDispatcher"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"ToString"
		end

	frozen start_processing is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"StartProcessing"
		end

	frozen stop_processing is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"StopProcessing"
		end

	frozen request_configure_remoting (file_name: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"RequestConfigureRemoting"
		end

	frozen process_request (url: STRING; cb_req_hdr_data: INTEGER; req_hdrs_and_body: ARRAY [INTEGER_8]; cb_response_hdr_data: INTEGER; resp_hdrs_and_body: ARRAY [INTEGER_8]): INTEGER is
		external
			"IL signature (System.String, System.Int32, System.Byte[], System.Int32&, System.Byte[]&): System.Int32 use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"ProcessRequest"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"Equals"
		end

	frozen do_gccollect is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"DoGCCollect"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Activation.RemotingDispatcher"
		alias
			"Finalize"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATION_REMOTINGDISPATCHER
