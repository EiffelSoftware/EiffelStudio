indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.TransactionOption"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	ENT_SERV_TRANSACTION_OPTION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen supported: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"2"
		end

	frozen requires_new: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"4"
		end

	frozen not_supported: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"1"
		end

	frozen required: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"3"
		end

	frozen disabled: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"0"
		end

end -- class ENT_SERV_TRANSACTION_OPTION
