indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlTruncateException"

external class
	SYSTEM_DATA_SQLTYPES_SQLTRUNCATEEXCEPTION

inherit
	SYSTEM_DATA_SQLTYPES_SQLTYPEEXCEPTION
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		select
			system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context
		end

create
	make_sqltruncateexception_1,
	make_sqltruncateexception

feature {NONE} -- Initialization

	frozen make_sqltruncateexception_1 (message: STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlTypes.SqlTruncateException"
		end

	frozen make_sqltruncateexception is
		external
			"IL creator use System.Data.SqlTypes.SqlTruncateException"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data_serialization_info_streaming_context (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.SqlTypes.SqlTruncateException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLTRUNCATEEXCEPTION
