indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogEntry"

frozen external class
	SYSTEM_DIAGNOSTICS_EVENTLOGENTRY

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create {NONE}

feature -- Access

	frozen get_time_generated: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.EventLogEntry"
		alias
			"get_TimeGenerated"
		end

	frozen get_time_written: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Diagnostics.EventLogEntry"
		alias
			"get_TimeWritten"
		end

	frozen get_category: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_Category"
		end

	frozen get_user_name: STRING is
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

	frozen get_message: STRING is
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

	frozen get_replacement_strings: ARRAY [STRING] is
		external
			"IL signature (): System.String[] use System.Diagnostics.EventLogEntry"
		alias
			"get_ReplacementStrings"
		end

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_Source"
		end

	frozen get_entry_type: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
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

	frozen get_machine_name: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.EventLogEntry"
		alias
			"get_MachineName"
		end

	frozen get_data: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Diagnostics.EventLogEntry"
		alias
			"get_Data"
		end

feature -- Basic Operations

	frozen equals_event_log_entry (other_entry: SYSTEM_DIAGNOSTICS_EVENTLOGENTRY): BOOLEAN is
		external
			"IL signature (System.Diagnostics.EventLogEntry): System.Boolean use System.Diagnostics.EventLogEntry"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (info: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Diagnostics.EventLogEntry"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGENTRY
