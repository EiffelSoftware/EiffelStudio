indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.SessionState.SessionStateModule"

frozen external class
	SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODULE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_WEB_IHTTPMODULE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.SessionState.SessionStateModule"
		end

feature -- Element Change

	frozen add_end (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"add_End"
		end

	frozen remove_end (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"remove_End"
		end

	frozen remove_start (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"remove_Start"
		end

	frozen add_start (value: SYSTEM_EVENTHANDLER) is
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

	frozen init (app: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.SessionState.SessionStateModule"
		alias
			"Init"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.SessionState.SessionStateModule"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_WEB_SESSIONSTATE_SESSIONSTATEMODULE
