indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDbConnection"

deferred external class
	SYSTEM_DATA_IDBCONNECTION

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_connection_string: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbConnection"
		alias
			"get_ConnectionString"
		end

	get_database: STRING is
		external
			"IL deferred signature (): System.String use System.Data.IDbConnection"
		alias
			"get_Database"
		end

	get_state: SYSTEM_DATA_CONNECTIONSTATE is
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

	set_connection_string (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Data.IDbConnection"
		alias
			"set_ConnectionString"
		end

feature -- Basic Operations

	begin_transaction_isolation_level (il: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL deferred signature (System.Data.IsolationLevel): System.Data.IDbTransaction use System.Data.IDbConnection"
		alias
			"BeginTransaction"
		end

	begin_transaction: SYSTEM_DATA_IDBTRANSACTION is
		external
			"IL deferred signature (): System.Data.IDbTransaction use System.Data.IDbConnection"
		alias
			"BeginTransaction"
		end

	change_database (database_name: STRING) is
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

	create_command: SYSTEM_DATA_IDBCOMMAND is
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

end -- class SYSTEM_DATA_IDBCONNECTION
