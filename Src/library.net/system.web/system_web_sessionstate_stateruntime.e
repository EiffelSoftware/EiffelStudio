indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.StateRuntime"

frozen external class
	SYSTEM_WEB_SESSIONSTATE_STATERUNTIME

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_WEB_SESSIONSTATE_ISTATERUNTIME

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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.StateRuntime"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.SessionState.StateRuntime"
		alias
			"Equals"
		end

	frozen process_request (tracker: POINTER; verb: INTEGER; uri: STRING; exclusive: INTEGER; timeout: INTEGER; lock_cookie_exists: INTEGER; lock_cookie: INTEGER; content_length: INTEGER; content: POINTER) is
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

end -- class SYSTEM_WEB_SESSIONSTATE_STATERUNTIME
