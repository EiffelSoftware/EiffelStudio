indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbError"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBERROR

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_sqlstate: STRING is
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

	frozen get_source: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"get_Source"
		end

	frozen get_message: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"get_Message"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbError"
		alias
			"ToString"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBERROR
