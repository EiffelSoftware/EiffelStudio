indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.OleDb.OleDbTransaction"

frozen external class
	SYSTEM_DATA_OLEDB_OLEDBTRANSACTION

inherit
	SYSTEM_DATA_IDBTRANSACTION
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create {NONE}

feature -- Access

	frozen get_isolation_level: SYSTEM_DATA_ISOLATIONLEVEL is
		external
			"IL signature (): System.Data.IsolationLevel use System.Data.OleDb.OleDbTransaction"
		alias
			"get_IsolationLevel"
		end

feature -- Basic Operations

	frozen begin: SYSTEM_DATA_OLEDB_OLEDBTRANSACTION is
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

	frozen begin_isolation_level (isolevel: SYSTEM_DATA_ISOLATIONLEVEL): SYSTEM_DATA_OLEDB_OLEDBTRANSACTION is
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

end -- class SYSTEM_DATA_OLEDB_OLEDBTRANSACTION
