indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.IStateRuntime"

deferred external class
	SYSTEM_WEB_SESSIONSTATE_ISTATERUNTIME

inherit
	ANY
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

	process_request (tracker: POINTER; verb: INTEGER; uri: STRING; exclusive: INTEGER; timeout: INTEGER; lock_cookie_exists: INTEGER; lock_cookie: INTEGER; content_length: INTEGER; content: POINTER) is
		external
			"IL deferred signature (System.IntPtr, System.Int32, System.String, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.IntPtr): System.Void use System.Web.SessionState.IStateRuntime"
		alias
			"ProcessRequest"
		end

end -- class SYSTEM_WEB_SESSIONSTATE_ISTATERUNTIME
