indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlException"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLEXCEPTION

inherit
	SYSTEM_SYSTEMEXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data,
			get_source,
			get_message
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create {NONE}

feature -- Access

	frozen get_server: STRING is
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

	get_message: STRING is
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

	frozen get_errors: SYSTEM_DATA_SQLCLIENT_SQLERRORCOLLECTION is
		external
			"IL signature (): System.Data.SqlClient.SqlErrorCollection use System.Data.SqlClient.SqlException"
		alias
			"get_Errors"
		end

	frozen get_procedure: STRING is
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

	get_source: STRING is
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

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.SqlClient.SqlException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLEXCEPTION
