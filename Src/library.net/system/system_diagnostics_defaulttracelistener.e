indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.DefaultTraceListener"

external class
	SYSTEM_DIAGNOSTICS_DEFAULTTRACELISTENER

inherit
	SYSTEM_IDISPOSABLE
	SYSTEM_DIAGNOSTICS_TRACELISTENER
		redefine
			fail_string_string,
			fail
		end

create
	make_defaulttracelistener

feature {NONE} -- Initialization

	frozen make_defaulttracelistener is
		external
			"IL creator use System.Diagnostics.DefaultTraceListener"
		end

feature -- Access

	frozen get_log_file_name: STRING is
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

	frozen set_log_file_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"set_LogFileName"
		end

feature -- Basic Operations

	fail_string_string (message: STRING; detail_message: STRING) is
		external
			"IL signature (System.String, System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Fail"
		end

	fail (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Fail"
		end

	write_line_string (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"WriteLine"
		end

	write_string (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.DefaultTraceListener"
		alias
			"Write"
		end

end -- class SYSTEM_DIAGNOSTICS_DEFAULTTRACELISTENER
