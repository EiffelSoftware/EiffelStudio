indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.TransactionAttribute"

frozen external class
	SYSTEM_ENTERPRISESERVICES_TRANSACTIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_transactionattribute,
	make_transactionattribute_1

feature {NONE} -- Initialization

	frozen make_transactionattribute is
		external
			"IL creator use System.EnterpriseServices.TransactionAttribute"
		end

	frozen make_transactionattribute_1 (val: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION) is
		external
			"IL creator signature (System.EnterpriseServices.TransactionOption) use System.EnterpriseServices.TransactionAttribute"
		end

feature -- Access

	frozen get_isolation: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL signature (): System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionAttribute"
		alias
			"get_Isolation"
		end

	frozen get_value: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
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

	frozen set_isolation (value: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL) is
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

end -- class SYSTEM_ENTERPRISESERVICES_TRANSACTIONATTRIBUTE
