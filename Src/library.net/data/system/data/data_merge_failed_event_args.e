indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.MergeFailedEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_MERGE_FAILED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_data_merge_failed_event_args

feature {NONE} -- Initialization

	frozen make_data_merge_failed_event_args (table: DATA_DATA_TABLE; conflict: SYSTEM_STRING) is
		external
			"IL creator signature (System.Data.DataTable, System.String) use System.Data.MergeFailedEventArgs"
		end

feature -- Access

	frozen get_table: DATA_DATA_TABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.MergeFailedEventArgs"
		alias
			"get_Table"
		end

	frozen get_conflict: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.MergeFailedEventArgs"
		alias
			"get_Conflict"
		end

end -- class DATA_MERGE_FAILED_EVENT_ARGS
