indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbCommand"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBCOMMAND

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DATA_IDBCOMMAND
		rename
			execute_reader as system_data_idb_command_execute_reader,
			create_parameter as system_data_idb_command_create_parameter,
			set_transaction as system_data_idb_command_set_transaction,
			get_transaction as system_data_idb_command_get_transaction,
			get_parameters as system_data_idb_command_get_parameters,
			set_connection as system_data_idb_command_set_connection,
			get_connection as system_data_idb_command_get_connection
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end

create
	make_oledbcommand,
	make_oledbcommand_3,
	make_oledbcommand_2,
	make_oledbcommand_1

feature {NONE} -- Initialization

	frozen make_oledbcommand is
		external
			"IL creator use System.Data.OleDb.OleDbCommand"
		end

	frozen make_oledbcommand_3 (cmd_text: STRING; connection: SYSTEM_DATA_OLEDB_OLEDBCONNECTION; transaction: SYSTEM_DATA_OLEDB_OLEDBTRANSACTION) is
		external
			"IL creator signature (System.String, System.Data.OleDb.OleDbConnection, System.Data.OleDb.OleDbTransaction) use System.Data.OleDb.OleDbCommand"
		end

	frozen make_oledbcommand_2 (cmd_text: STRING; connection: SYSTEM_DATA_OLEDB_OLEDBCONNECTION) is
		external
			"IL creator signature (System.String, System.Data.OleDb.OleDbConnection) use System.Data.OleDb.OleDbCommand"
		end

	frozen make_oledbcommand_1 (cmd_text: STRING) is
		external
			"IL creator signature (System.String) use System.Data.OleDb.OleDbCommand"
		end

feature -- Access

	frozen get_design_time_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.OleDb.OleDbCommand"
		alias
			"get_DesignTimeVisible"
		end

	frozen get_parameters: SYSTEM_DATA_OLEDB_OLEDBPARAMETERCOLLECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbParameterCollection use System.Data.OleDb.OleDbCommand"
		alias
			"get_Parameters"
		end

	frozen get_command_type: SYSTEM_DATA_COMMANDTYPE is
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

	frozen get_connection: SYSTEM_DATA_OLEDB_OLEDBCONNECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbConnection use System.Data.OleDb.OleDbCommand"
		alias
			"get_Connection"
		end

	frozen get_updated_row_source: SYSTEM_DATA_UPDATEROWSOURCE is
		external
			"IL signature (): System.Data.UpdateRowSource use System.Data.OleDb.OleDbCommand"
		alias
			"get_UpdatedRowSource"
		end

	frozen get_transaction: SYSTEM_DATA_OLEDB_OLEDBTRANSACTION is
		external
			"IL signature (): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbCommand"
		alias
			"get_Transaction"
		end

	frozen get_command_text: STRING is
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

	frozen set_command_type (value: SYSTEM_DATA_COMMANDTYPE) is
		external
			"IL signature (System.Data.CommandType): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_CommandType"
		end

	frozen set_transaction (value: SYSTEM_DATA_OLEDB_OLEDBTRANSACTION) is
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

	frozen set_command_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_CommandText"
		end

	frozen set_connection (value: SYSTEM_DATA_OLEDB_OLEDBCONNECTION) is
		external
			"IL signature (System.Data.OleDb.OleDbConnection): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"set_Connection"
		end

	frozen set_updated_row_source (value: SYSTEM_DATA_UPDATEROWSOURCE) is
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

	frozen execute_scalar: ANY is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteScalar"
		end

	frozen execute_reader_command_behavior2 (behavior: SYSTEM_DATA_COMMANDBEHAVIOR): SYSTEM_DATA_OLEDB_OLEDBDATAREADER is
		external
			"IL signature (System.Data.CommandBehavior): System.Data.OleDb.OleDbDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteReader"
		end

	frozen execute_reader: SYSTEM_DATA_OLEDB_OLEDBDATAREADER is
		external
			"IL signature (): System.Data.OleDb.OleDbDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"ExecuteReader"
		end

	frozen create_parameter: SYSTEM_DATA_OLEDB_OLEDBPARAMETER is
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

	frozen system_data_idb_command_execute_reader: SYSTEM_DATA_IDATAREADER is
		external
			"IL signature (): System.Data.IDataReader use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.ExecuteReader"
		end

	frozen execute_reader_command_behavior (behavior: SYSTEM_DATA_COMMANDBEHAVIOR): SYSTEM_DATA_IDATAREADER is
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

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbCommand"
		alias
			"System.ICloneable.Clone"
		end

	frozen system_data_idb_command_set_connection (value: SYSTEM_DATA_IDBCONNECTION) is
		external
			"IL signature (System.Data.IDbConnection): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.set_Connection"
		end

	frozen system_data_idb_command_get_parameters: SYSTEM_DATA_IDATAPARAMETERCOLLECTION is
		external
			"IL signature (): System.Data.IDataParameterCollection use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Parameters"
		end

	frozen system_data_idb_command_get_connection: SYSTEM_DATA_IDBCONNECTION is
		external
			"IL signature (): System.Data.IDbConnection use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Connection"
		end

	frozen system_data_idb_command_create_parameter: SYSTEM_DATA_IDATAPARAMETER is
		external
			"IL signature (): System.Data.IDataParameter use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.CreateParameter"
		end

	frozen system_data_idb_command_get_transaction: SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.get_Transaction"
		end

	frozen system_data_idb_command_set_transaction (value: SYSTEM_DATA_IDBTRANSACTION) is
		external
			"IL signature (System.Data.IDbTransaction): System.Void use System.Data.OleDb.OleDbCommand"
		alias
			"System.Data.IDbCommand.set_Transaction"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBCOMMAND
