indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.StateChangeEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_STATE_CHANGE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_data_state_change_event_args

feature {NONE} -- Initialization

	frozen make_data_state_change_event_args (original_state: DATA_CONNECTION_STATE; current_state: DATA_CONNECTION_STATE) is
		external
			"IL creator signature (System.Data.ConnectionState, System.Data.ConnectionState) use System.Data.StateChangeEventArgs"
		end

feature -- Access

	frozen get_current_state: DATA_CONNECTION_STATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.StateChangeEventArgs"
		alias
			"get_CurrentState"
		end

	frozen get_original_state: DATA_CONNECTION_STATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.StateChangeEventArgs"
		alias
			"get_OriginalState"
		end

end -- class DATA_STATE_CHANGE_EVENT_ARGS
