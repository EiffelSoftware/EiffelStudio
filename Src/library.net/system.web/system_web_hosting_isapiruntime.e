indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.ISAPIRuntime"

frozen external class
	SYSTEM_WEB_HOSTING_ISAPIRUNTIME

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_WEB_HOSTING_IISAPIRUNTIME

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Hosting.ISAPIRuntime"
		end

feature -- Basic Operations

	frozen do_gccollect is
		external
			"IL signature (): System.Void use System.Web.Hosting.ISAPIRuntime"
		alias
			"DoGCCollect"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Hosting.ISAPIRuntime"
		alias
			"GetHashCode"
		end

	frozen stop_processing is
		external
			"IL signature (): System.Void use System.Web.Hosting.ISAPIRuntime"
		alias
			"StopProcessing"
		end

	frozen start_processing is
		external
			"IL signature (): System.Void use System.Web.Hosting.ISAPIRuntime"
		alias
			"StartProcessing"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.ISAPIRuntime"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Hosting.ISAPIRuntime"
		alias
			"Equals"
		end

	frozen process_request (ecb: POINTER; i_wrtype: INTEGER): INTEGER is
		external
			"IL signature (System.IntPtr, System.Int32): System.Int32 use System.Web.Hosting.ISAPIRuntime"
		alias
			"ProcessRequest"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Hosting.ISAPIRuntime"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_HOSTING_ISAPIRUNTIME
