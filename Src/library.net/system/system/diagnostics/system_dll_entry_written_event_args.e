indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EntryWrittenEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ENTRY_WRITTEN_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_entry_written_event_args_1,
	make_system_dll_entry_written_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_entry_written_event_args_1 (entry: SYSTEM_DLL_EVENT_LOG_ENTRY) is
		external
			"IL creator signature (System.Diagnostics.EventLogEntry) use System.Diagnostics.EntryWrittenEventArgs"
		end

	frozen make_system_dll_entry_written_event_args is
		external
			"IL creator use System.Diagnostics.EntryWrittenEventArgs"
		end

feature -- Access

	frozen get_entry: SYSTEM_DLL_EVENT_LOG_ENTRY is
		external
			"IL signature (): System.Diagnostics.EventLogEntry use System.Diagnostics.EntryWrittenEventArgs"
		alias
			"get_Entry"
		end

end -- class SYSTEM_DLL_ENTRY_WRITTEN_EVENT_ARGS
