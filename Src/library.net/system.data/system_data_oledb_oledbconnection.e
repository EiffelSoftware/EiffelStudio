indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbConnection"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBCONNECTION

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_ICLONEABLE
		rename
			clone as system_icloneable_clone
		end
	SYSTEM_DATA_IDBCONNECTION
		rename
			create_command as system_data_idb_connection_create_command,
			begin_transaction as system_data_idb_connection_begin_transaction
		end

create
	make_oledbconnection,
	make_oledbconnection_1

feature {NONE} -- Initialization

	frozen make_oledbconnection is
		external
			"IL creator use System.Data.OleDb.OleDbConnection"
		end

	frozen make_oledbconnection_1 (connection_string: STRING) is
		external
			"IL creator signature (System.String) use System.Data.OleDb.OleDbConnection"
		end

feature -- Access

	frozen get_data_source: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_DataSource"
		end

	frozen get_connection_string: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_ConnectionString"
		end

	frozen get_database: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_Database"
		end

	frozen get_state: SYSTEM_DATA_CONNECTIONSTATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.OleDb.OleDbConnection"
		alias
			"get_State"
		end

	frozen get_connection_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.OleDb.OleDbConnection"
		alias
			"get_ConnectionTimeout"
		end

	frozen get_provider: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_Provider"
		end

	frozen get_server_version: STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_ServerVersion"
		end

feature -- Element Change

	frozen remove_info_message (value: SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTHANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbInfoMessageEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"remove_InfoMessage"
		end

	frozen remove_state_change (value: SYSTEM_DATA_STATECHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"remove_StateChange"
		end

	frozen add_state_change (value: SYSTEM_DATA_STATECHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"add_StateChange"
		end

	frozen set_connection_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"set_ConnectionString"
		end

	frozen add_info_message (value: SYSTEM_DATA_OLEDB_OLEDBINFOMESSAGEEVENTHANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbInfoMessageEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"add_InfoMessage"
		end

feature -- Basic Operations

	frozen change_database (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"ChangeDatabase"
		end

	frozen get_ole_db_schema_table (schema: SYSTEM_GUID; restrictions: ARRAY [ANY]): SYSTEM_DATA_DATATABLE is
		external
			"IL signature (System.Guid, System.Object[]): System.Data.DataTable use System.Data.OleDb.OleDbConnection"
		alias
			"GetOleDbSchemaTable"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"Close"
		end

	frozen release_object_pool is
		external
			"IL static signature (): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"ReleaseObjectPool"
		end

	frozen begin_transaction_isolation_level2 (isolation_level: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_OLEDB_OLEDBTRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"BeginTransaction"
		end

	frozen create_command: SYSTEM_DATA_OLEDB_OLEDBCOMMAND is
		external
			"IL signature (): System.Data.OleDb.OleDbCommand use System.Data.OleDb.OleDbConnection"
		alias
			"CreateCommand"
		end

	frozen open is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"Open"
		end

	frozen begin_transaction: SYSTEM_DATA_OLEDB_OLEDBTRANSACTION is
		external
			"IL signature (): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"BeginTransaction"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"Dispose"
		end

	frozen system_data_idb_connection_begin_transaction: SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen begin_transaction_isolation_level (isolation_level: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen system_data_idb_connection_create_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.CreateCommand"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbConnection"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_DATA_OLEDB_OLEDBCONNECTION
