indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.StateChangeEventArgs"

frozen external class
	SYSTEM_DATA_STATECHANGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_statechangeeventargs

feature {NONE} -- Initialization

	frozen make_statechangeeventargs (original_state: SYSTEM_DATA_CONNECTIONSTATE; current_state: SYSTEM_DATA_CONNECTIONSTATE) is
		external
			"IL creator signature (System.Data.ConnectionState, System.Data.ConnectionState) use System.Data.StateChangeEventArgs"
		end

feature -- Access

	frozen get_current_state: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.StateChangeEventArgs"
		alias
			"get_CurrentState"
		end

	frozen get_original_state: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.StateChangeEventArgs"
		alias
			"get_OriginalState"
		end

end -- class SYSTEM_DATA_STATECHANGEEVENTARGS
