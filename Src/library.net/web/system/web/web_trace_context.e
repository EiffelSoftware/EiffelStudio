indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.TraceContext"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_TRACE_CONTEXT

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (context: WEB_HTTP_CONTEXT) is
		external
			"IL creator signature (System.Web.HttpContext) use System.Web.TraceContext"
		end

feature -- Access

	frozen get_is_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.TraceContext"
		alias
			"get_IsEnabled"
		end

	frozen get_trace_mode: WEB_TRACE_MODE is
		external
			"IL signature (): System.Web.TraceMode use System.Web.TraceContext"
		alias
			"get_TraceMode"
		end

feature -- Element Change

	frozen set_is_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.TraceContext"
		alias
			"set_IsEnabled"
		end

	frozen set_trace_mode (value: WEB_TRACE_MODE) is
		external
			"IL signature (System.Web.TraceMode): System.Void use System.Web.TraceContext"
		alias
			"set_TraceMode"
		end

feature -- Basic Operations

	frozen write_string_string_exception (category: SYSTEM_STRING; message: SYSTEM_STRING; error_info: EXCEPTION) is
		external
			"IL signature (System.String, System.String, System.Exception): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

	frozen warn_string_string_exception (category: SYSTEM_STRING; message: SYSTEM_STRING; error_info: EXCEPTION) is
		external
			"IL signature (System.String, System.String, System.Exception): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen warn (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen warn_string_string (category: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen write_string_string (category: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

	frozen write (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

end -- class WEB_TRACE_CONTEXT
