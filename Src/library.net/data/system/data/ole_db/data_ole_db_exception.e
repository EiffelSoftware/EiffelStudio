indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_EXCEPTION

inherit
	EXTERNAL_EXCEPTION
		redefine
			get_error_code,
			get_object_data,
			get_source,
			get_message
		end
	ISERIALIZABLE

create {NONE}

feature -- Access

	get_message: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbException"
		alias
			"get_Message"
		end

	get_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbException"
		alias
			"get_Source"
		end

	frozen get_errors: DATA_OLE_DB_ERROR_COLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbErrorCollection use System.Data.OleDb.OleDbException"
		alias
			"get_Errors"
		end

	get_error_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbException"
		alias
			"get_ErrorCode"
		end

feature -- Basic Operations

	get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.OleDb.OleDbException"
		alias
			"GetObjectData"
		end

end -- class DATA_OLE_DB_EXCEPTION
