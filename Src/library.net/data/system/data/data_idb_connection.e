indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDbConnection"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDB_CONNECTION

inherit
	IDISPOSABLE

feature -- Access

	get_connection_string: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbConnection"
		alias
			"get_ConnectionString"
		end

	get_database: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbConnection"
		alias
			"get_Database"
		end

	get_state: DATA_CONNECTION_STATE is
		external
			"IL deferred signature (): System.Data.ConnectionState use System.Data.IDbConnection"
		alias
			"get_State"
		end

	get_connection_timeout: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Data.IDbConnection"
		alias
			"get_ConnectionTimeout"
		end

feature -- Element Change

	set_connection_string (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDbConnection"
		alias
			"set_ConnectionString"
		end

feature -- Basic Operations

	begin_transaction_isolation_level (il: DATA_ISOLATION_LEVEL): DATA_IDB_TRANSACTION is
		external
			"IL deferred signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.IDbConnection"
		alias
			"BeginTransaction"
		end

	begin_transaction: DATA_IDB_TRANSACTION is
		external
			"IL deferred signature (): System.Data.IDbTransaction use System.Data.IDbConnection"
		alias
			"BeginTransaction"
		end

	change_database (database_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDbConnection"
		alias
			"ChangeDatabase"
		end

	open is
		external
			"IL deferred signature (): System.Void use System.Data.IDbConnection"
		alias
			"Open"
		end

	create_command: DATA_IDB_COMMAND is
		external
			"IL deferred signature (): System.Data.IDbCommand use System.Data.IDbConnection"
		alias
			"CreateCommand"
		end

	close is
		external
			"IL deferred signature (): System.Void use System.Data.IDbConnection"
		alias
			"Close"
		end

end -- class DATA_IDB_CONNECTION
