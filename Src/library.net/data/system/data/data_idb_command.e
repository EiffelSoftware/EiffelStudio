indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDbCommand"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDB_COMMAND

inherit
	IDISPOSABLE

feature -- Access

	get_command_type: DATA_COMMAND_TYPE is
		external
			"IL deferred signature (): System.Data.CommandType use System.Data.IDbCommand"
		alias
			"get_CommandType"
		end

	get_updated_row_source: DATA_UPDATE_ROW_SOURCE is
		external
			"IL deferred signature (): System.Data.UpdateRowSource use System.Data.IDbCommand"
		alias
			"get_UpdatedRowSource"
		end

	get_parameters: DATA_IDATA_PARAMETER_COLLECTION is
		external
			"IL deferred signature (): System.Data.IDataParameterCollection use System.Data.IDbCommand"
		alias
			"get_Parameters"
		end

	get_command_text: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbCommand"
		alias
			"get_CommandText"
		end

	get_command_timeout: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbCommand"
		alias
			"get_CommandTimeout"
		end

	get_connection: DATA_IDB_CONNECTION is
		external
			"IL deferred signature (): System.Data.IDbConnection use System.Data.IDbCommand"
		alias
			"get_Connection"
		end

	get_transaction: DATA_IDB_TRANSACTION is
		external
			"IL deferred signature (): System.Data.IDbTransaction use System.Data.IDbCommand"
		alias
			"get_Transaction"
		end

feature -- Element Change

	set_connection (value: DATA_IDB_CONNECTION) is
		external
			"IL deferred signature (System.Data.IDbConnection): System.Void use System.Data.IDbCommand"
		alias
			"set_Connection"
		end

	set_command_type (value: DATA_COMMAND_TYPE) is
		external
			"IL deferred signature (System.Data.CommandType): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandType"
		end

	set_command_timeout (value: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandTimeout"
		end

	set_command_text (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDbCommand"
		alias
			"set_CommandText"
		end

	set_transaction (value: DATA_IDB_TRANSACTION) is
		external
			"IL deferred signature (System.Data.IDbTransaction): System.Void use System.Data.IDbCommand"
		alias
			"set_Transaction"
		end

	set_updated_row_source (value: DATA_UPDATE_ROW_SOURCE) is
		external
			"IL deferred signature (System.Data.UpdateRowSource): System.Void use System.Data.IDbCommand"
		alias
			"set_UpdatedRowSource"
		end

feature -- Basic Operations

	cancel is
		external
			"IL deferred signature (): System.Void use System.Data.IDbCommand"
		alias
			"Cancel"
		end

	execute_non_query: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbCommand"
		alias
			"ExecuteNonQuery"
		end

	create_parameter: DATA_IDB_DATA_PARAMETER is
		external
			"IL deferred signature (): System.Data.IDbDataParameter use System.Data.IDbCommand"
		alias
			"CreateParameter"
		end

	execute_reader_command_behavior (behavior: DATA_COMMAND_BEHAVIOR): DATA_IDATA_READER is
		external
			"IL deferred signature (System.Data.CommandBehavior): System.Data.IDataReader use System.Data.IDbCommand"
		alias
			"ExecuteReader"
		end

	execute_reader: DATA_IDATA_READER is
		external
			"IL deferred signature (): System.Data.IDataReader use System.Data.IDbCommand"
		alias
			"ExecuteReader"
		end

	execute_scalar: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Data.IDbCommand"
		alias
			"ExecuteScalar"
		end

	prepare is
		external
			"IL deferred signature (): System.Void use System.Data.IDbCommand"
		alias
			"Prepare"
		end

end -- class DATA_IDB_COMMAND
