indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.SessionState.StateRuntime"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_STATE_RUNTIME

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_ISTATE_RUNTIME

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.SessionState.StateRuntime"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.StateRuntime"
		alias
			"GetHashCode"
		end

	frozen stop_processing is
		external
			"IL signature (): System.Void use System.Web.SessionState.StateRuntime"
		alias
			"StopProcessing"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.StateRuntime"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.SessionState.StateRuntime"
		alias
			"Equals"
		end

	frozen process_request (tracker: POINTER; verb: INTEGER; uri: SYSTEM_STRING; exclusive: INTEGER; timeout: INTEGER; lock_cookie_exists: INTEGER; lock_cookie: INTEGER; content_length: INTEGER; content: POINTER) is
		external
			"IL signature (System.IntPtr, System.Int32, System.String, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.IntPtr): System.Void use System.Web.SessionState.StateRuntime"
		alias
			"ProcessRequest"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.SessionState.StateRuntime"
		alias
			"Finalize"
		end

end -- class WEB_STATE_RUNTIME
