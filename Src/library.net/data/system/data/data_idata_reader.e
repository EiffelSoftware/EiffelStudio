indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDataReader"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDATA_READER

inherit
	IDISPOSABLE
	DATA_IDATA_RECORD

feature -- Access

	get_records_affected: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDataReader"
		alias
			"get_RecordsAffected"
		end

	get_depth: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDataReader"
		alias
			"get_Depth"
		end

	get_is_closed: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.IDataReader"
		alias
			"get_IsClosed"
		end

feature -- Basic Operations

	next_result: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.IDataReader"
		alias
			"NextResult"
		end

	get_schema_table: DATA_DATA_TABLE is
		external
			"IL deferred signature (): System.Data.DataTable use System.Data.IDataReader"
		alias
			"GetSchemaTable"
		end

	read: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Data.IDataReader"
		alias
			"Read"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Data.IDataReader"
		alias
			"Close"
		end

end -- class DATA_IDATA_READER
