indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.TransactionIsolationLevel"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_TRANSACTION_ISOLATION_LEVEL

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen repeatable_read: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"3"
		end

	frozen read_uncommitted: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"1"
		end

	frozen serializable: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"4"
		end

	frozen any: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"0"
		end

	frozen read_committed: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"2"
		end

end -- class ENT_SERV_TRANSACTION_ISOLATION_LEVEL
