indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlConnection"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLCONNECTION

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
	make_sqlconnection,
	make_sqlconnection_1

feature {NONE} -- Initialization

	frozen make_sqlconnection is
		external
			"IL creator use System.Data.SqlClient.SqlConnection"
		end

	frozen make_sqlconnection_1 (connection_string: STRING) is
		external
			"IL creator signature (System.String) use System.Data.SqlClient.SqlConnection"
		end

feature -- Access

	frozen get_connection_string: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_ConnectionString"
		end

	frozen get_workstation_id: STRING is
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

	frozen get_data_source: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_DataSource"
		end

	frozen get_database: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_Database"
		end

	frozen get_state: SYSTEM_DATA_CONNECTIONSTATE is
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

	frozen get_server_version: STRING is
		external
			"IL signature (): System.String use System.Data.SqlClient.SqlConnection"
		alias
			"get_ServerVersion"
		end

feature -- Element Change

	frozen remove_info_message (value: SYSTEM_DATA_SQLCLIENT_SQLINFOMESSAGEEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlInfoMessageEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"remove_InfoMessage"
		end

	frozen remove_state_change (value: SYSTEM_DATA_STATECHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"remove_StateChange"
		end

	frozen add_state_change (value: SYSTEM_DATA_STATECHANGEEVENTHANDLER) is
		external
			"IL signature (System.Data.StateChangeEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"add_StateChange"
		end

	frozen set_connection_string (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"set_ConnectionString"
		end

	frozen add_info_message (value: SYSTEM_DATA_SQLCLIENT_SQLINFOMESSAGEEVENTHANDLER) is
		external
			"IL signature (System.Data.SqlClient.SqlInfoMessageEventHandler): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"add_InfoMessage"
		end

feature -- Basic Operations

	frozen change_database (database: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlConnection"
		alias
			"ChangeDatabase"
		end

	frozen begin_transaction: SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION is
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

	frozen begin_transaction_isolation_level_string (iso: SYSTEM_DATA_ISOLATIONLEVEL; transaction_name: STRING): SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel, System.String): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

	frozen begin_transaction_isolation_level2 (iso: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.SqlClient.SqlTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"BeginTransaction"
		end

	frozen create_command: SYSTEM_DATA_SQLCLIENT_SQLCOMMAND is
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

	frozen begin_transaction_string (transaction_name: STRING): SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION is
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

	frozen system_data_idb_connection_begin_transaction: SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL signature (): System.Data.IDbTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen begin_transaction_isolation_level (iso: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.BeginTransaction"
		end

	frozen system_data_idb_connection_create_command: SYSTEM_DATA_IDBCOMMAND is
		external
			"IL signature (): System.Data.IDbCommand use System.Data.SqlClient.SqlConnection"
		alias
			"System.Data.IDbConnection.CreateCommand"
		end

	frozen system_icloneable_clone: ANY is
		external
			"IL signature (): System.Object use System.Data.SqlClient.SqlConnection"
		alias
			"System.ICloneable.Clone"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLCONNECTION
