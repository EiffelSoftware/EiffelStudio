indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.DBConcurrencyException"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_DBCONCURRENCY_EXCEPTION

inherit
	SYSTEM_EXCEPTION
		redefine
			get_object_data
		end
	ISERIALIZABLE

create
	make_data_dbconcurrency_exception,
	make_data_dbconcurrency_exception_1

feature {NONE} -- Initialization

	frozen make_data_dbconcurrency_exception (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.DBConcurrencyException"
		end

	frozen make_data_dbconcurrency_exception_1 (message: SYSTEM_STRING; inner: EXCEPTION) is
		external
			"IL creator signature (System.String, System.Exception) use System.Data.DBConcurrencyException"
		end

feature -- Access

	frozen get_row: DATA_DATA_ROW is
		external
			"IL signature (): System.Data.DataRow use System.Data.DBConcurrencyException"
		alias
			"get_Row"
		end

feature -- Element Change

	frozen set_row (value: DATA_DATA_ROW) is
		external
			"IL signature (System.Data.DataRow): System.Void use System.Data.DBConcurrencyException"
		alias
			"set_Row"
		end

feature -- Basic Operations

	get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Data.DBConcurrencyException"
		alias
			"GetObjectData"
		end

end -- class DATA_DBCONCURRENCY_EXCEPTION
