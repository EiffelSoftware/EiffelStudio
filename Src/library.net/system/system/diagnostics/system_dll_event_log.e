indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLog"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_EVENT_LOG

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_system_dll_event_log_2,
	make_system_dll_event_log_3,
	make_system_dll_event_log_1,
	make_system_dll_event_log

feature {NONE} -- Initialization

	frozen make_system_dll_event_log_2 (log_name: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.EventLog"
		end

	frozen make_system_dll_event_log_3 (log_name: SYSTEM_STRING; machine_name: SYSTEM_STRING; source: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Diagnostics.EventLog"
		end

	frozen make_system_dll_event_log_1 (log_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.EventLog"
		end

	frozen make_system_dll_event_log is
		external
			"IL creator use System.Diagnostics.EventLog"
		end

feature -- Access

	frozen get_synchronizing_object: SYSTEM_DLL_ISYNCHRONIZE_INVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.Diagnostics.EventLog"
		alias
			"get_SynchronizingObject"
		end

	frozen get_log_display_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_LogDisplayName"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_Source"
		end

	frozen get_log: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_Log"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_MachineName"
		end

	frozen get_entries: SYSTEM_DLL_EVENT_LOG_ENTRY_COLLECTION is
		external
			"IL signature (): System.Diagnostics.EventLogEntryCollection use System.Diagnostics.EventLog"
		alias
			"get_Entries"
		end

	frozen get_enable_raising_events: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Diagnostics.EventLog"
		alias
			"get_EnableRaisingEvents"
		end

feature -- Element Change

	frozen set_synchronizing_object (value: SYSTEM_DLL_ISYNCHRONIZE_INVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.Diagnostics.EventLog"
		alias
			"set_SynchronizingObject"
		end

	frozen set_source (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"set_Source"
		end

	frozen remove_entry_written (value: SYSTEM_DLL_ENTRY_WRITTEN_EVENT_HANDLER) is
		external
			"IL signature (System.Diagnostics.EntryWrittenEventHandler): System.Void use System.Diagnostics.EventLog"
		alias
			"remove_EntryWritten"
		end

	frozen set_machine_name (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"set_MachineName"
		end

	frozen set_enable_raising_events (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.EventLog"
		alias
			"set_EnableRaisingEvents"
		end

	frozen add_entry_written (value: SYSTEM_DLL_ENTRY_WRITTEN_EVENT_HANDLER) is
		external
			"IL signature (System.Diagnostics.EntryWrittenEventHandler): System.Void use System.Diagnostics.EventLog"
		alias
			"add_EntryWritten"
		end

	frozen set_log (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"set_Log"
		end

feature -- Basic Operations

	frozen get_event_logs: NATIVE_ARRAY [SYSTEM_DLL_EVENT_LOG] is
		external
			"IL static signature (): System.Diagnostics.EventLog[] use System.Diagnostics.EventLog"
		alias
			"GetEventLogs"
		end

	frozen log_name_from_source_name (source: SYSTEM_STRING; machine_name: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Diagnostics.EventLog"
		alias
			"LogNameFromSourceName"
		end

	frozen write_entry_string_string_event_log_entry_type_int32_int16 (source: SYSTEM_STRING; message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER; category: INTEGER_16) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_string (source: SYSTEM_STRING; message: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry (message: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLog"
		alias
			"Clear"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLog"
		alias
			"Close"
		end

	frozen end_init is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLog"
		alias
			"EndInit"
		end

	frozen write_entry_string_event_log_entry_type_int32_int16 (message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER; category: INTEGER_16) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen delete_string_string (log_name: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"Delete"
		end

	frozen delete_event_source (source: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"DeleteEventSource"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLog"
		alias
			"BeginInit"
		end

	frozen write_entry_string_event_log_entry_type_int32 (message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen source_exists_string_string (source: SYSTEM_STRING; machine_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"SourceExists"
		end

	frozen write_entry_string_event_log_entry_type_int32_int16_array_byte (message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER; category: INTEGER_16; raw_data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16, System.Byte[]): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen delete (log_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"Delete"
		end

	frozen write_entry_string_string_event_log_entry_type_int32 (source: SYSTEM_STRING; message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType, System.Int32): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_event_log_entry_type (message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_string_event_log_entry_type (source: SYSTEM_STRING; message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen exists (log_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"Exists"
		end

	frozen exists_string_string (log_name: SYSTEM_STRING; machine_name: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"Exists"
		end

	frozen create_event_source (source: SYSTEM_STRING; log_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"CreateEventSource"
		end

	frozen get_event_logs_string (machine_name: SYSTEM_STRING): NATIVE_ARRAY [SYSTEM_DLL_EVENT_LOG] is
		external
			"IL static signature (System.String): System.Diagnostics.EventLog[] use System.Diagnostics.EventLog"
		alias
			"GetEventLogs"
		end

	frozen delete_event_source_string_string (source: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"DeleteEventSource"
		end

	frozen create_event_source_string_string_string (source: SYSTEM_STRING; log_name: SYSTEM_STRING; machine_name: SYSTEM_STRING) is
		external
			"IL static signature (System.String, System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"CreateEventSource"
		end

	frozen source_exists (source: SYSTEM_STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"SourceExists"
		end

	frozen write_entry_string_string_event_log_entry_type_int32_int16_array_byte (source: SYSTEM_STRING; message: SYSTEM_STRING; type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE; event_id: INTEGER; category: INTEGER_16; raw_data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16, System.Byte[]): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Diagnostics.EventLog"
		alias
			"Dispose"
		end

end -- class SYSTEM_DLL_EVENT_LOG
