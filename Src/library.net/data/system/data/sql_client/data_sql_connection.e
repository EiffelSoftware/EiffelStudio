indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlConnection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_CONNECTION

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	DATA_IDB_CONNECTION
		rename
			create_command as system_data_idb_connection_create_command,
			begin_transaction as system_data_idb_connection_begin_transaction
		end
	ICLONEABLE
		rename
			clone_ as system_icloneable_clone
		end

create
	make_data_sql_connection_1,
	make_data_sql_connection

feature {NONE} -- Initialization

	frozen make_data_sql_connection_1 (connection_string: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlClient.SqlConnection"
		end

	frozen make_data_sql_connection is
		external
			"IL creator use System.Data.SqlClient.SqlConnection"
		end

feature -- Access

	frozen get_connection_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_ConnectionString"
		end

	frozen get_workstation_id: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_WorkstationId"
		end

	frozen get_packet_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlConnection"
		alias
			"get_PacketSize"
		end

	frozen get_data_source: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_DataSource"
		end

	frozen get_database: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_Database"
		end

	frozen get_state: DATA_CONNECTION_STATE is
		external
			"IL signature (): System.Data.ConnectionState use System.Data.SqlClient.SqlConnection"
		alias
			"get_State"
		end

	frozen get_connection_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.SqlClient.SqlConnection"
		alias
			"get_ConnectionTimeout"
		end

	frozen get_server_version: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_ServerVersion"
		end

feature -- Element Change

	frozen remove_info_message (value: DATA_SQL_INFO_MESSAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlInfoMessageEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"remove_InfoMessage"
		end

	frozen remove_state_change (value: DATA_STATE_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"remove_StateChange"
		end

	frozen add_state_change (value: DATA_STATE_CHANGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"add_StateChange"
		end

	frozen set_connection_string (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"set_ConnectionString"
		end

	frozen add_info_message (value: DATA_SQL_INFO_MESSAGE_EVENT_HANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlInfoMessageEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"add_InfoMessage"
		end

feature -- Basic Operations

	frozen change_database (database: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"ChangeDatabase"
		end

	frozen begin_transaction: DATA_SQL_TRANSACTION is
		external
			"IL signature (): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"Close"
		end

	frozen begin_transaction_isolation_level_string (iso: DATA_ISOLATION_LEVEL; transaction_name: SYSTEM_STRING): DATA_SQL_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel, System.String): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

	frozen begin_transaction_isolation_level2 (iso: DATA_ISOLATION_LEVEL): DATA_SQL_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

	frozen create_command: DATA_SQL_COMMAND is
		external
			"IL signature (): System.Data.SqlClient.SqlCommand use System.Data.SqlClient.SqlConnection"
		alias
			"CreateCommand"
		end

	frozen open is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"Open"
		end

	frozen begin_transaction_string (transaction_name: SYSTEM_STRING): DATA_SQL_TRANSACTION is
		external
			"IL signature (System.String): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"Dispose"
		end

	frozen system_data_idb_connection_begin_transaction: DATA_IDB_TRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen begin_transaction_isolation_level (iso: DATA_ISOLATION_LEVEL): DATA_IDB_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen system_data_idb_connection_create_command: DATA_IDB_COMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.CreateCommand"
		end

	frozen system_icloneable_clone: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlConnection"
		alias
			"System.ICloneable.Clone"
		end

end -- class DATA_SQL_CONNECTION
