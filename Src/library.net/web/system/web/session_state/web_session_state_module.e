indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.SessionState.SessionStateModule"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_SESSION_STATE_MODULE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_IHTTP_MODULE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.SessionState.SessionStateModule"
		end

feature -- Element Change

	frozen add_end (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"add_End"
		end

	frozen remove_end (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"remove_End"
		end

	frozen remove_start (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"remove_Start"
		end

	frozen add_start (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"add_Start"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.SessionState.SessionStateModule"
		alias
			"GetHashCode"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"Dispose"
		end

	frozen init (app: WEB_HTTP_APPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"Init"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.SessionStateModule"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.SessionState.SessionStateModule"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"Finalize"
		end

end -- class WEB_SESSION_STATE_MODULE
