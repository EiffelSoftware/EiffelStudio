indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.IDbTransaction"

deferred external class
	SYSTEM_DATA_IDBTRANSACTION

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_isolation_level: SYSTEM_DATA_ISOLATIONLEVEL is
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

end -- class SYSTEM_DATA_IDBTRANSACTION
