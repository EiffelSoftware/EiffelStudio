indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.TraceContext"

frozen external class
	SYSTEM_WEB_TRACECONTEXT

create
	make

feature {NONE} -- Initialization

	frozen make (context: SYSTEM_WEB_HTTPCONTEXT) is
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

	frozen get_trace_mode: SYSTEM_WEB_TRACEMODE is
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

	frozen set_trace_mode (value: SYSTEM_WEB_TRACEMODE) is
		external
			"IL signature (System.Web.TraceMode): System.Void use System.Web.TraceContext"
		alias
			"set_TraceMode"
		end

feature -- Basic Operations

	frozen write_string_string_exception (category: STRING; message: STRING; error_info: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.String, System.String, System.Exception): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

	frozen warn_string_string_exception (category: STRING; message: STRING; error_info: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.String, System.String, System.Exception): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen warn (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen warn_string_string (category: STRING; message: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.TraceContext"
		alias
			"Warn"
		end

	frozen write_string_string (category: STRING; message: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

	frozen write (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.TraceContext"
		alias
			"Write"
		end

end -- class SYSTEM_WEB_TRACECONTEXT
