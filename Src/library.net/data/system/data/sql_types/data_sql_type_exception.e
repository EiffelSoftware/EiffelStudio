indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlTypes.SqlTypeException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_SQL_TYPE_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		redefine
			system_runtime_serialization_iserializable_get_object_data
		end
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_data_sql_type_exception

feature {NONE} -- Initialization

	frozen make_data_sql_type_exception (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlTypeException"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.SqlTypes.SqlTypeException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class DATA_SQL_TYPE_EXCEPTION
