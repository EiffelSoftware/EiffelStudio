indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.EventLogEntry"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_EVENT_LOG_ENTRY

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create {NONE}

feature -- Access

	frozen get_time_generated: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.EventLogEntry"
		alias
			"get_TimeGenerated"
		end

	frozen get_time_written: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.EventLogEntry"
		alias
			"get_TimeWritten"
		end

	frozen get_category: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_Category"
		end

	frozen get_user_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_UserName"
		end

	frozen get_event_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.EventLogEntry"
		alias
			"get_EventID"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_Message"
		end

	frozen get_category_number: INTEGER_16 is
		external
			"IL signature (): System.Int16 use System.Diagnostics.EventLogEntry"
		alias
			"get_CategoryNumber"
		end

	frozen get_replacement_strings: NATIVE_ARRAY [SYSTEM_STRING] is
		external
			"IL signature (): System.String[] use System.Diagnostics.EventLogEntry"
		alias
			"get_ReplacementStrings"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_Source"
		end

	frozen get_entry_type: SYSTEM_DLL_EVENT_LOG_ENTRY_TYPE is
		external
			"IL signature (): System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntry"
		alias
			"get_EntryType"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.EventLogEntry"
		alias
			"get_Index"
		end

	frozen get_machine_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_MachineName"
		end

	frozen get_data: NATIVE_ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Diagnostics.EventLogEntry"
		alias
			"get_Data"
		end

feature -- Basic Operations

	frozen equals_event_log_entry (other_entry: SYSTEM_DLL_EVENT_LOG_ENTRY): BOOLEAN is
		external
			"IL signature (System.Diagnostics.EventLogEntry): System.Boolean use System.Diagnostics.EventLogEntry"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Diagnostics.EventLogEntry"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DLL_EVENT_LOG_ENTRY
