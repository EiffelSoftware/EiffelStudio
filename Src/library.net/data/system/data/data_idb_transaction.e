indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.IDbTransaction"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	DATA_IDB_TRANSACTION

inherit
	IDISPOSABLE

feature -- Access

	get_connection: DATA_IDB_CONNECTION is
		external
			"IL deferred signature (): System.Data.IDbConnection use System.Data.IDbTransaction"
		alias
			"get_Connection"
		end

	get_isolation_level: DATA_ISOLATION_LEVEL is
		external
			"IL deferred signature (): System.Data.IsolationLevel use System.Data.IDbTransaction"
		alias
			"get_IsolationLevel"
		end

feature -- Basic Operations

	commit is
		external
			"IL deferred signature (): System.Void use System.Data.IDbTransaction"
		alias
			"Commit"
		end

	rollback is
		external
			"IL deferred signature (): System.Void use System.Data.IDbTransaction"
		alias
			"Rollback"
		end

end -- class DATA_IDB_TRANSACTION
