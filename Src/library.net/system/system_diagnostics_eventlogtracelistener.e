indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogTraceListener"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOGTRACELISTENER

inherit
	SYSTEM_IDISPOSABLE
	SYSTEM_DIAGNOSTICS_TRACELISTENER
		redefine
			close,
			dispose_boolean,
			set_name,
			get_name
		end

create
	make_eventlogtracelistener_2,
	make_eventlogtracelistener_1,
	make_eventlogtracelistener

feature {NONE} -- Initialization

	frozen make_eventlogtracelistener_2 (source: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.EventLogTraceListener"
		end

	frozen make_eventlogtracelistener_1 (event_log: SYSTEM_DIAGNOSTICS_EVENTLOG) is
		external
			"IL creator signature (System.Diagnostics.EventLog) use System.Diagnostics.EventLogTraceListener"
		end

	frozen make_eventlogtracelistener is
		external
			"IL creator use System.Diagnostics.EventLogTraceListener"
		end

feature -- Access

	frozen get_event_log: SYSTEM_DIAGNOSTICS_EVENTLOG is
		external
			"IL signature (): System.Diagnostics.EventLog use System.Diagnostics.EventLogTraceListener"
		alias
			"get_EventLog"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogTraceListener"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_event_log (value: SYSTEM_DIAGNOSTICS_EVENTLOG) is
		external
			"IL signature (System.Diagnostics.EventLog): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"set_EventLog"
		end

	set_name (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"set_Name"
		end

feature -- Basic Operations

	write_line_string (message: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLogTraceListener"
		alias
			"WriteLine"
		end

	write_string (message: STRING) is
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

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGTRACELISTENER
