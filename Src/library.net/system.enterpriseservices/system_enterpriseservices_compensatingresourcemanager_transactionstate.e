indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.CompensatingResourceManager.TransactionState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen committed: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"1"
		end

	frozen indoubt: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"3"
		end

	frozen aborted: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"2"
		end

	frozen active: SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE is
		external
			"IL enum signature :System.EnterpriseServices.CompensatingResourceManager.TransactionState use System.EnterpriseServices.CompensatingResourceManager.TransactionState"
		alias
			"0"
		end

end -- class SYSTEM_ENTERPRISESERVICES_COMPENSATINGRESOURCEMANAGER_TRANSACTIONSTATE
