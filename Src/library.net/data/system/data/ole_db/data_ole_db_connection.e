indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbConnection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_CONNECTION

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
	DATA_IDB_CONNECTION
		rename
			create_command as system_data_idb_connection_create_command,
			begin_transaction as system_data_idb_connection_begin_transaction
		end

create
	make_data_ole_db_connection_1,
	make_data_ole_db_connection

feature {NONE} -- Initialization

	frozen make_data_ole_db_connection_1 (connection_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.OleDb.OleDbConnection"
		end

	frozen make_data_ole_db_connection is
		external
			"IL creator use System.Data.OleDb.OleDbConnection"
		end

feature -- Access

	frozen get_data_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_DataSource"
		end

	frozen get_connection_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_ConnectionString"
		end

	frozen get_database: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_Database"
		end

	frozen get_state: DATA_CONNECTION_STATE is
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

	frozen get_provider: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_Provider"
		end

	frozen get_server_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.OleDb.OleDbConnection"
		alias
			"get_ServerVersion"
		end

feature -- Element Change

	frozen remove_info_message (value: DATA_OLE_DB_INFO_MESSAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbInfoMessageEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"remove_InfoMessage"
		end

	frozen remove_state_change (value: DATA_STATE_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"remove_StateChange"
		end

	frozen add_state_change (value: DATA_STATE_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"add_StateChange"
		end

	frozen set_connection_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"set_ConnectionString"
		end

	frozen add_info_message (value: DATA_OLE_DB_INFO_MESSAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.OleDb.OleDbInfoMessageEventHandler): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"add_InfoMessage"
		end

feature -- Basic Operations

	frozen change_database (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.OleDb.OleDbConnection"
		alias
			"ChangeDatabase"
		end

	frozen get_ole_db_schema_table (schema: GUID; restrictions: NATIVE_ARRAY [SYSTEM_OBJECT]): DATA_DATA_TABLE is
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

	frozen begin_transaction_isolation_level2 (isolation_level: DATA_ISOLATION_LEVEL): DATA_OLE_DB_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"BeginTransaction"
		end

	frozen create_command: DATA_OLE_DB_COMMAND is
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

	frozen begin_transaction: DATA_OLE_DB_TRANSACTION is
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

	frozen system_data_idb_connection_begin_transaction: DATA_IDB_TRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen begin_transaction_isolation_level (isolation_level: DATA_ISOLATION_LEVEL): DATA_IDB_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen system_data_idb_connection_create_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.OleDb.OleDbConnection"
		alias
			"System.Data.IDbConnection.CreateCommand"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.OleDb.OleDbConnection"
		alias
			"System.ICloneable.Clone"
		end

end -- class DATA_OLE_DB_CONNECTION
