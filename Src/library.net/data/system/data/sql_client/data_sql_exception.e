indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data,
			get_source,
			get_message
		end
	ISERIALIZABLE

create {NONE}

feature -- Access

	frozen get_server: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlException"
		alias
			"get_Server"
		end

	frozen get_class: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlException"
		alias
			"get_Class"
		end

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlException"
		alias
			"get_Message"
		end

	frozen get_state: INTEGER_8 is
		external
			"IL signature (): System.Byte use System.Data.SqlClient.SqlException"
		alias
			"get_State"
		end

	frozen get_errors: DATA_SQL_ERROR_COLLECTION is
		external
			"IL signature (): System.Data.SqlClient.SqlErrorCollection use System.Data.SqlClient.SqlException"
		alias
			"get_Errors"
		end

	frozen get_procedure: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlException"
		alias
			"get_Procedure"
		end

	frozen get_line_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlException"
		alias
			"get_LineNumber"
		end

	get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlException"
		alias
			"get_Source"
		end

	frozen get_number: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlException"
		alias
			"get_Number"
		end

feature -- Basic Operations

	get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.SqlClient.SqlException"
		alias
			"GetObjectData"
		end

end -- class DATA_SQL_EXCEPTION
