indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDataReader"

deferred external class
	SYSTEM_DATA_IDATAREADER

inherit
	SYSTEM_DATA_IDATARECORD

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

	get_schema_table: SYSTEM_DATA_DATATABLE is
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

end -- class SYSTEM_DATA_IDATAREADER
