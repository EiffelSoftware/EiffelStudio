indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.DefaultAuthenticationEventArgs"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_DEFAULT_AUTHENTICATION_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_web_default_authentication_event_args

feature {NONE} -- Initialization

	frozen make_web_default_authentication_event_args (context: WEB_HTTP_CONTEXT) is
		external
			"IL creator signature (System.Web.HttpContext) use System.Web.Security.DefaultAuthenticationEventArgs"
		end

feature -- Access

	frozen get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.Security.DefaultAuthenticationEventArgs"
		alias
			"get_Context"
		end

end -- class WEB_DEFAULT_AUTHENTICATION_EVENT_ARGS
