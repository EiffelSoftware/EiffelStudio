indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlInfoMessageEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_INFO_MESSAGE_EVENT_ARGS

inherit
	EVENT_ARGS
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_errors: DATA_SQL_ERROR_COLLECTION is
		external
			"IL signature (): System.Data.SqlClient.SqlErrorCollection use System.Data.SqlClient.SqlInfoMessageEventArgs"
		alias
			"get_Errors"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlInfoMessageEventArgs"
		alias
			"get_Source"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlInfoMessageEventArgs"
		alias
			"get_Message"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlInfoMessageEventArgs"
		alias
			"ToString"
		end

end -- class DATA_SQL_INFO_MESSAGE_EVENT_ARGS
