indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlError"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLERROR

inherit
	ANY
		redefine
			to_string
		end

create {NONE}

feature -- Access

	frozen get_server: STRING is
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

	frozen get_message: STRING is
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

	frozen get_procedure: STRING is
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

	frozen get_source: STRING is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlError"
		alias
			"ToString"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLERROR
