indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.SqlClient.SqlTransaction"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_SQL_TRANSACTION

inherit
	MARSHAL_BY_REF_OBJECT
	DATA_IDB_TRANSACTION
		rename
			get_connection as system_data_idb_transaction_get_connection
		end
	IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_connection: DATA_SQL_CONNECTION is
		external
			"IL signature (): System.Data.SqlClient.SqlConnection use System.Data.SqlClient.SqlTransaction"
		alias
			"get_Connection"
		end

	frozen get_isolation_level: DATA_ISOLATION_LEVEL is
		external
			"IL signature (): System.Data.IsolationLevel use System.Data.SqlClient.SqlTransaction"
		alias
			"get_IsolationLevel"
		end

feature -- Basic Operations

	frozen rollback_string (transaction_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Rollback"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Dispose"
		end

	frozen commit is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Commit"
		end

	frozen rollback is
		external
			"IL signature (): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Rollback"
		end

	frozen save (save_point_name: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Save"
		end

feature {NONE} -- Implementation

	frozen system_data_idb_transaction_get_connection: DATA_IDB_CONNECTION is
		external
			"IL signature (): System.Data.IDbConnection use System.Data.SqlClient.SqlTransaction"
		alias
			"System.Data.IDbTransaction.get_Connection"
		end

end -- class DATA_SQL_TRANSACTION
