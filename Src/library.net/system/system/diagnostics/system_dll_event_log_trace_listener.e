indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogTraceListener"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_EVENT_LOG_TRACE_LISTENER

inherit
	SYSTEM_DLL_TRACE_LISTENER
		redefine
			close,
			dispose_boolean,
			set_name,
			get_name
		end
	IDISPOSABLE

create
	make_system_dll_event_log_trace_listener_1,
	make_system_dll_event_log_trace_listener,
	make_system_dll_event_log_trace_listener_2

feature {NONE} -- Initialization

	frozen make_system_dll_event_log_trace_listener_1 (event_log: SYSTEM_DLL_EVENT_LOG) is
		external
			"IL creator signature (System.Diagnostics.EventLog) use System.Diagnostics.EventLogTraceListener"
		end

	frozen make_system_dll_event_log_trace_listener is
		external
			"IL creator use System.Diagnostics.EventLogTraceListener"
		end

	frozen make_system_dll_event_log_trace_listener_2 (source: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.EventLogTraceListener"
		end

feature -- Access

	frozen get_event_log: SYSTEM_DLL_EVENT_LOG is
		external
			"IL signature (): System.Diagnostics.EventLog use System.Diagnostics.EventLogTraceListener"
		alias
			"get_EventLog"
		end

	get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogTraceListener"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_event_log (value: SYSTEM_DLL_EVENT_LOG) is
		external
			"IL signature (System.Diagnostics.EventLog): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"set_EventLog"
		end

	set_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"set_Name"
		end

feature -- Basic Operations

	write_line_string (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"WriteLine"
		end

	write_string (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"Write"
		end

	close is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"Dispose"
		end

end -- class SYSTEM_DLL_EVENT_LOG_TRACE_LISTENER
