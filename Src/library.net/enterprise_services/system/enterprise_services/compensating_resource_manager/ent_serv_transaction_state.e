indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.TransactionState"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_TRANSACTION_STATE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen committed: ENT_SERV_TRANSACTION_STATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"1"
		end

	frozen indoubt: ENT_SERV_TRANSACTION_STATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"3"
		end

	frozen aborted: ENT_SERV_TRANSACTION_STATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"2"
		end

	frozen active: ENT_SERV_TRANSACTION_STATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"0"
		end

end -- class ENT_SERV_TRANSACTION_STATE
