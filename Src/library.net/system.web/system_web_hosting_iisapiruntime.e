indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.IISAPIRuntime"

deferred external class
	SYSTEM_WEB_HOSTING_IISAPIRUNTIME

inherit
	ANY
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

end -- class SYSTEM_WEB_HOSTING_IISAPIRUNTIME
