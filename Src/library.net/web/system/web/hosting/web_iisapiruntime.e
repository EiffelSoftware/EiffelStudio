indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Hosting.IISAPIRuntime"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IISAPIRUNTIME

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	do_gccollect is
		external
			"IL deferred signature (): System.Void use System.Web.Hosting.IISAPIRuntime"
		alias
			"DoGCCollect"
		end

	stop_processing is
		external
			"IL deferred signature (): System.Void use System.Web.Hosting.IISAPIRuntime"
		alias
			"StopProcessing"
		end

	start_processing is
		external
			"IL deferred signature (): System.Void use System.Web.Hosting.IISAPIRuntime"
		alias
			"StartProcessing"
		end

	process_request (ecb: POINTER; use_process_model: INTEGER): INTEGER is
		external
			"IL deferred signature (System.IntPtr, System.Int32): System.Int32 use System.Web.Hosting.IISAPIRuntime"
		alias
			"ProcessRequest"
		end

end -- class WEB_IISAPIRUNTIME
