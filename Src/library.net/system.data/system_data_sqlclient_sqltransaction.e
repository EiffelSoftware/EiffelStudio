indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlClient.SqlTransaction"

frozen external class
	SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION

inherit
	SYSTEM_DATA_IDBTRANSACTION
	SYSTEM_MARSHALBYREFOBJECT
	SYSTEM_IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_isolation_level: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL signature (): System.Data.IsolationLevel use System.Data.SqlClient.SqlTransaction"
		alias
			"get_IsolationLevel"
		end

feature -- Basic Operations

	frozen rollback_string (transaction_name: STRING) is
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

	frozen save (save_point_name: STRING) is
		external
			"IL signature (System.String): System.Void use System.Data.SqlClient.SqlTransaction"
		alias
			"Save"
		end

end -- class SYSTEM_DATA_SQLCLIENT_SQLTRANSACTION
