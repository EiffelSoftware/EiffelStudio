indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.SessionState.IStateRuntime"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_ISTATE_RUNTIME

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	stop_processing is
		external
			"IL deferred signature (): System.Void use System.Web.SessionState.IStateRuntime"
		alias
			"StopProcessing"
		end

	process_request (tracker: POINTER; verb: INTEGER; uri: SYSTEM_STRING; exclusive: INTEGER; timeout: INTEGER; lock_cookie_exists: INTEGER; lock_cookie: INTEGER; content_length: INTEGER; content: POINTER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32, System.String, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.IntPtr): System.Void use System.Web.SessionState.IStateRuntime"
		alias
			"ProcessRequest"
		end

end -- class WEB_ISTATE_RUNTIME
