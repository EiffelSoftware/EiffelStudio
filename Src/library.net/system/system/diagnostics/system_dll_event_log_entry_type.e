indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogEntryType"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen success_audit: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"8"
		end

	frozen information: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"4"
		end

	frozen error: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"1"
		end

	frozen warning: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"2"
		end

	frozen failure_audit: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"16"
		end

end -- class SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE
