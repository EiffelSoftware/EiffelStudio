indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.OleDb.OleDbTransaction"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DATA_OLE_DB_TRANSACTION

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	DATA_IDB_TRANSACTION
		rename
			dispose as system_idisposable_dispose,
			get_connection as system_data_idb_transaction_get_connection
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create {NONE}

feature -- Access

	frozen get_connection: DATA_OLE_DB_CONNECTION is
		external
			"IL signature (): System.Data.OleDb.OleDbConnection use System.Data.OleDb.OleDbTransaction"
		alias
			"get_Connection"
		end

	frozen get_isolation_level: DATA_ISOLATION_LEVEL is
		external
			"IL signature (): System.Data.IsolationLevel use System.Data.OleDb.OleDbTransaction"
		alias
			"get_IsolationLevel"
		end

feature -- Basic Operations

	frozen begin: DATA_OLE_DB_TRANSACTION is
		external
			"IL signature (): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbTransaction"
		alias
			"Begin"
		end

	frozen commit is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbTransaction"
		alias
			"Commit"
		end

	frozen begin_isolation_level (isolevel: DATA_ISOLATION_LEVEL): DATA_OLE_DB_TRANSACTION is
		external
			"IL signature (System.Data.IsolationLevel): System.Data.OleDb.OleDbTransaction use System.Data.OleDb.OleDbTransaction"
		alias
			"Begin"
		end

	frozen rollback is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbTransaction"
		alias
			"Rollback"
		end

feature {NONE} -- Implementation

	frozen system_data_idb_transaction_get_connection: DATA_IDB_CONNECTION is
		external
			"IL signature (): System.Data.IDbConnection use System.Data.OleDb.OleDbTransaction"
		alias
			"System.Data.IDbTransaction.get_Connection"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbTransaction"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Data.OleDb.OleDbTransaction"
		alias
			"System.IDisposable.Dispose"
		end

end -- class DATA_OLE_DB_TRANSACTION
