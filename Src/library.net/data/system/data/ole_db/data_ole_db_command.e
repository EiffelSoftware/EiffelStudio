indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbCommand"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_COMMAND

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end
	DATA_IDB_COMMAND
		rename
			execute_reader as system_data_idb_command_execute_reader,
			create_parameter as system_data_idb_command_create_parameter,
			set_transaction as system_data_idb_command_set_transaction,
			get_transaction as system_data_idb_command_get_transaction,
			get_parameters as system_data_idb_command_get_parameters,
			set_connection as system_data_idb_command_set_connection,
			get_connection as system_data_idb_command_get_connection
		end

create
	make_data_ole_db_command_1,
	make_data_ole_db_command_2,
	make_data_ole_db_command_3,
	make_data_ole_db_command

feature {NONE} -- Initialization

	frozen make_data_ole_db_command_1 (cmd_text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.OleDb.OleDbCommand"
		end

	frozen make_data_ole_db_command_2 (cmd_text: SYSTEM_STRING; connection: DATA_OLE_DB_CONNECTION) is
		external
			"IL creator signature (System.String, System.Data.OleDb.OleDbConnection) use System.Data.OleDb.OleDbCommand"
		end

	frozen make_data_ole_db_command_3 (cmd_text: SYSTEM_STRING; connection: DATA_OLE_DB_CONNECTION; transaction: DATA_OLE_DB_TRANSACTION) is
		external
			"IL creator signature (System.String, System.Data.OleDb.OleDbConnection, System.Data.OleDb.OleDbTransaction) use System.Data.OleDb.OleDbCommand"
		end

	frozen make_data_ole_db_command is
		external
			"IL creator use System.Data.OleDb.OleDbCommand"
		end

feature -- Access

	frozen get_design_time_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbCommand"
		alias
			"get_DesignTimeVisible"
		end

	frozen get_parameters: DATA_OLE_DB_PARAMETER_COLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbParameterCollection use System.Data.OleDb.OleDbCommand"
		alias
			"get_Parameters"
		end

	frozen get_command_type: DATA_COMMAND_TYPE is
		external
			"IL signature (): System.Data.CommandType use System.Data.OleDb.OleDbCommand"
		alias
			"get_CommandType"
		end

	frozen get_command_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbCommand"
		alias
			"get_CommandTimeout"
		end

	frozen get_connection: DATA_OLE_DB_CONNECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbConnection use System.Data.OleDb.OleDbCommand"
		alias
			"get_Connection"
		end

	frozen get_updated_row_source: DATA_UPDATE_ROW_SOURCE is
		external
			"IL signature (): System.Data.UpdateRowSource use System.Data.OleDb.OleDbCommand"
		alias
			"get_UpdatedRowSource"
		end

	frozen get_transaction: DATA_OLE_DB_TRANSACTION is
		external
			"IL signature (): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbCommand"
		alias
			"get_Transaction"
		end

	frozen get_command_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbCommand"
		alias
			"get_CommandText"
		end

feature -- Element Change

	frozen set_design_time_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_DesignTimeVisible"
		end

	frozen set_command_type (value: DATA_COMMAND_TYPE) is
		external
			"IL signature (System.Data.CommandType): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_CommandType"
		end

	frozen set_transaction (value: DATA_OLE_DB_TRANSACTION) is
		external
			"IL signature (System.Data.OleDb.OleDbTransaction): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_Transaction"
		end

	frozen set_command_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_CommandTimeout"
		end

	frozen set_command_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_CommandText"
		end

	frozen set_connection (value: DATA_OLE_DB_CONNECTION) is
		external
			"IL signature (System.Data.OleDb.OleDbConnection): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_Connection"
		end

	frozen set_updated_row_source (value: DATA_UPDATE_ROW_SOURCE) is
		external
			"IL signature (System.Data.UpdateRowSource): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_UpdatedRowSource"
		end

feature -- Basic Operations

	frozen execute_non_query: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteNonQuery"
		end

	frozen reset_command_timeout is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"ResetCommandTimeout"
		end

	frozen execute_scalar: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteScalar"
		end

	frozen execute_reader_command_behavior2 (behavior: DATA_COMMAND_BEHAVIOR): DATA_OLE_DB_DATA_READER is
		external
			"IL signature (System.Data.CommandBehavior): System.Data.OleDb.OleDbDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteReader"
		end

	frozen execute_reader: DATA_OLE_DB_DATA_READER is
		external
			"IL signature (): System.Data.OleDb.OleDbDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteReader"
		end

	frozen create_parameter: DATA_OLE_DB_PARAMETER is
		external
			"IL signature (): System.Data.OleDb.OleDbParameter use System.Data.OleDb.OleDbCommand"
		alias
			"CreateParameter"
		end

	frozen prepare is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"Prepare"
		end

	frozen cancel is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"Cancel"
		end

feature {NONE} -- Implementation

	frozen system_data_idb_command_execute_reader: DATA_IDATA_READER is
		external
			"IL signature (): System.Data.IDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.ExecuteReader"
		end

	frozen execute_reader_command_behavior (behavior: DATA_COMMAND_BEHAVIOR): DATA_IDATA_READER is
		external
			"IL signature (System.Data.CommandBehavior): System.Data.IDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.ExecuteReader"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"Dispose"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbCommand"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_data_idb_command_set_connection (value: DATA_IDB_CONNECTION) is
		external
			"IL signature (System.Data.IDbConnection): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.set_Connection"
		end

	frozen system_data_idb_command_get_parameters: DATA_IDATA_PARAMETER_COLLECTION is
		external
			"IL signature (): System.Data.IDataParameterCollection use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Parameters"
		end

	frozen system_data_idb_command_get_connection: DATA_IDB_CONNECTION is
		external
			"IL signature (): System.Data.IDbConnection use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Connection"
		end

	frozen system_data_idb_command_create_parameter: DATA_IDB_DATA_PARAMETER is
		external
			"IL signature (): System.Data.IDbDataParameter use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.CreateParameter"
		end

	frozen system_data_idb_command_get_transaction: DATA_IDB_TRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Transaction"
		end

	frozen system_data_idb_command_set_transaction (value: DATA_IDB_TRANSACTION) is
		external
			"IL signature (System.Data.IDbTransaction): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.set_Transaction"
		end

end -- class DATA_OLE_DB_COMMAND
