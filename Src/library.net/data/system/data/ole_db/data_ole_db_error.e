indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbError"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_ERROR

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_sqlstate: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"get_SQLState"
		end

	frozen get_native_error: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbError"
		alias
			"get_NativeError"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"get_Source"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"get_Message"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"ToString"
		end

end -- class DATA_OLE_DB_ERROR
