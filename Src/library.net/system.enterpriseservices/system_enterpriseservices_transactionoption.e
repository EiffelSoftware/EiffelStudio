indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.TransactionOption"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION

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

	frozen supported: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"2"
		end

	frozen requires_new: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"4"
		end

	frozen not_supported: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"1"
		end

	frozen required: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"3"
		end

	frozen disabled: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION is
		external
			"IL enum signature :System.EnterpriseServices.TransactionOption use System.EnterpriseServices.TransactionOption"
		alias
			"0"
		end

end -- class SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION
