indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlError"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_ERROR

inherit
	SYSTEM_OBJECT
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_server: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"get_Server"
		end

	frozen get_class: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlError"
		alias
			"get_Class"
		end

	frozen get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"get_Message"
		end

	frozen get_state: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlError"
		alias
			"get_State"
		end

	frozen get_procedure: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"get_Procedure"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlError"
		alias
			"get_LineNumber"
		end

	frozen get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"get_Source"
		end

	frozen get_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlError"
		alias
			"get_Number"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"ToString"
		end

end -- class DATA_SQL_ERROR
