indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbException"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBEXCEPTION

inherit
	SYSTEM_RUNTIME_INTEROPSERVICES_EXTERNALEXCEPTION
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

	frozen get_errors: SYSTEM_DATA_OLEDB_OLEDBERRORCOLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbErrorCollection use System.Data.OleDb.OleDbException"
		alias
			"get_Errors"
		end

	get_source: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbException"
		alias
			"get_Source"
		end

	get_message: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbException"
		alias
			"get_Message"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SYSTEM_RUNTIME_SERIALIZATION_SERIALIZATIONINFO; context: SYSTEM_RUNTIME_SERIALIZATION_STREAMINGCONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.OleDb.OleDbException"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBEXCEPTION
