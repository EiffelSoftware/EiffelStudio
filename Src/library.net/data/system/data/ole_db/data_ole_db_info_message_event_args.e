indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbInfoMessageEventArgs"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_INFO_MESSAGE_EVENT_ARGS

inherit
	EVENT_ARGS
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_errors: DATA_OLE_DB_ERROR_COLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbErrorCollection use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Errors"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Message"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_Source"
		end

	frozen get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"get_ErrorCode"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbInfoMessageEventArgs"
		alias
			"ToString"
		end

end -- class DATA_OLE_DB_INFO_MESSAGE_EVENT_ARGS
