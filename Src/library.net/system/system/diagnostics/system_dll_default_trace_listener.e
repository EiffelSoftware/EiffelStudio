indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.DefaultTraceListener"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DEFAULT_TRACE_LISTENER

inherit
	SYSTEM_DLL_TRACE_LISTENER
		redefine
			fail_string_string,
			fail
		end
	IDISPOSABLE

create
	make_system_dll_default_trace_listener

feature {NONE} -- Initialization

	frozen make_system_dll_default_trace_listener is
		external
			"IL creator use System.Diagnostics.DefaultTraceListener"
		end

feature -- Access

	frozen get_log_file_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.DefaultTraceListener"
		alias
			"get_LogFileName"
		end

	frozen get_assert_ui_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.DefaultTraceListener"
		alias
			"get_AssertUiEnabled"
		end

feature -- Element Change

	frozen set_assert_ui_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"set_AssertUiEnabled"
		end

	frozen set_log_file_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"set_LogFileName"
		end

feature -- Basic Operations

	fail_string_string (message: SYSTEM_STRING; detail_message: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Fail"
		end

	fail (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Fail"
		end

	write_line_string (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"WriteLine"
		end

	write_string (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Write"
		end

end -- class SYSTEM_DLL_DEFAULT_TRACE_LISTENER
