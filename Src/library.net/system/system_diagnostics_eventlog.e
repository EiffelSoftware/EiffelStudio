indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLog"

external class
	SYSTEM_DIAGNOSTICS_EVENTLOG

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose,
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE

create
	make_eventlog,
	make_eventlog_1,
	make_eventlog_2,
	make_eventlog_3

feature {NONE} -- Initialization

	frozen make_eventlog is
		external
			"IL creator use System.Diagnostics.EventLog"
		end

	frozen make_eventlog_1 (log_name: STRING) is
		external
			"IL creator signature (System.String) use System.Diagnostics.EventLog"
		end

	frozen make_eventlog_2 (log_name: STRING; machine_name: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Diagnostics.EventLog"
		end

	frozen make_eventlog_3 (log_name: STRING; machine_name: STRING; source: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Diagnostics.EventLog"
		end

feature -- Access

	frozen get_synchronizing_object: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.Diagnostics.EventLog"
		alias
			"get_SynchronizingObject"
		end

	frozen get_log_display_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_LogDisplayName"
		end

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_Source"
		end

	frozen get_log: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_Log"
		end

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLog"
		alias
			"get_MachineName"
		end

	frozen get_entries: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYCOLLECTION is
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

	frozen set_synchronizing_object (value: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.Diagnostics.EventLog"
		alias
			"set_SynchronizingObject"
		end

	frozen set_source (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"set_Source"
		end

	frozen remove_entry_written (value: SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTHANDLER) is
		external
			"IL signature (System.Diagnostics.EntryWrittenEventHandler): System.Void use System.Diagnostics.EventLog"
		alias
			"remove_EntryWritten"
		end

	frozen set_machine_name (value: STRING) is
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

	frozen add_entry_written (value: SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTHANDLER) is
		external
			"IL signature (System.Diagnostics.EntryWrittenEventHandler): System.Void use System.Diagnostics.EventLog"
		alias
			"add_EntryWritten"
		end

	frozen set_log (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"set_Log"
		end

feature -- Basic Operations

	frozen get_event_logs: ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOG] is
		external
			"IL static signature (): System.Diagnostics.EventLog[] use System.Diagnostics.EventLog"
		alias
			"GetEventLogs"
		end

	frozen log_name_from_source_name (source: STRING; machine_name: STRING): STRING is
		external
			"IL static signature (System.String, System.String): System.String use System.Diagnostics.EventLog"
		alias
			"LogNameFromSourceName"
		end

	frozen write_entry_string_string_event_log_entry_type_int32_int16 (source: STRING; message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER; category: INTEGER_16) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_string (source: STRING; message: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry (message: STRING) is
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

	frozen write_entry_string_event_log_entry_type_int32 (message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_event_log_entry_type_int32_int16 (message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER; category: INTEGER_16) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen delete_string_string (log_name: STRING; machine_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"Delete"
		end

	frozen delete_event_source (source: STRING) is
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

	dispose is
		external
			"IL signature (): System.Void use System.Diagnostics.EventLog"
		alias
			"Dispose"
		end

	frozen source_exists_string_string (source: STRING; machine_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"SourceExists"
		end

	frozen write_entry_string_event_log_entry_type_int32_int16_array_byte (message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER; category: INTEGER_16; raw_data: ARRAY [INTEGER_8]) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType, System.Int32, System.Int16, System.Byte[]): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen delete (log_name: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"Delete"
		end

	frozen write_entry_string_string_event_log_entry_type_int32 (source: STRING; message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType, System.Int32): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_event_log_entry_type (message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE) is
		external
			"IL signature (System.String, System.Diagnostics.EventLogEntryType): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen write_entry_string_string_event_log_entry_type (source: STRING; message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE) is
		external
			"IL static signature (System.String, System.String, System.Diagnostics.EventLogEntryType): System.Void use System.Diagnostics.EventLog"
		alias
			"WriteEntry"
		end

	frozen exists (log_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"Exists"
		end

	frozen exists_string_string (log_name: STRING; machine_name: STRING): BOOLEAN is
		external
			"IL static signature (System.String, System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"Exists"
		end

	frozen create_event_source (source: STRING; log_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"CreateEventSource"
		end

	frozen get_event_logs_string (machine_name: STRING): ARRAY [SYSTEM_DIAGNOSTICS_EVENTLOG] is
		external
			"IL static signature (System.String): System.Diagnostics.EventLog[] use System.Diagnostics.EventLog"
		alias
			"GetEventLogs"
		end

	frozen delete_event_source_string_string (source: STRING; machine_name: STRING) is
		external
			"IL static signature (System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"DeleteEventSource"
		end

	frozen create_event_source_string_string_string (source: STRING; log_name: STRING; machine_name: STRING) is
		external
			"IL static signature (System.String, System.String, System.String): System.Void use System.Diagnostics.EventLog"
		alias
			"CreateEventSource"
		end

	frozen source_exists (source: STRING): BOOLEAN is
		external
			"IL static signature (System.String): System.Boolean use System.Diagnostics.EventLog"
		alias
			"SourceExists"
		end

	frozen write_entry_string_string_event_log_entry_type_int32_int16_array_byte (source: STRING; message: STRING; type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE; event_id: INTEGER; category: INTEGER_16; raw_data: ARRAY [INTEGER_8]) is
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

end -- class SYSTEM_DIAGNOSTICS_EVENTLOG
