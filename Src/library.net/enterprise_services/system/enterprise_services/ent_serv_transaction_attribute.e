indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.TransactionAttribute"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	ENT_SERV_TRANSACTION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_ent_serv_transaction_attribute_1,
	make_ent_serv_transaction_attribute

feature {NONE} -- Initialization

	frozen make_ent_serv_transaction_attribute_1 (val: ENT_SERV_TRANSACTION_OPTION) is
		external
			"IL creator signature (System.EnterpriseServices.TransactionOption) use System.EnterpriseServices.TransactionAttribute"
		end

	frozen make_ent_serv_transaction_attribute is
		external
			"IL creator use System.EnterpriseServices.TransactionAttribute"
		end

feature -- Access

	frozen get_isolation: ENT_SERV_TRANSACTION_ISOLATION_LEVEL is
		external
			"IL signature (): System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionAttribute"
		alias
			"get_Isolation"
		end

	frozen get_value: ENT_SERV_TRANSACTION_OPTION is
		external
			"IL signature (): System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionAttribute"
		alias
			"get_Value"
		end

	frozen get_timeout: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.TransactionAttribute"
		alias
			"get_Timeout"
		end

feature -- Element Change

	frozen set_isolation (value: ENT_SERV_TRANSACTION_ISOLATION_LEVEL) is
		external
			"IL signature (System.EnterpriseServices.TransactionIsolationLevel): System.Void use System.EnterpriseServices.TransactionAttribute"
		alias
			"set_Isolation"
		end

	frozen set_timeout (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.EnterpriseServices.TransactionAttribute"
		alias
			"set_Timeout"
		end

end -- class ENT_SERV_TRANSACTION_ATTRIBUTE
