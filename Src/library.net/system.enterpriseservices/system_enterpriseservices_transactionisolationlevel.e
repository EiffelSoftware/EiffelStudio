indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.TransactionIsolationLevel"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL

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

	frozen repeatable_read: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"3"
		end

	frozen read_uncommitted: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"1"
		end

	frozen serializable: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"4"
		end

	frozen any: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"0"
		end

	frozen read_committed: SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL is
		external
			"IL enum signature :System.EnterpriseServices.TransactionIsolationLevel use System.EnterpriseServices.TransactionIsolationLevel"
		alias
			"2"
		end

end -- class SYSTEM_ENTERPRISESERVICES_TRANSACTIONISOLATIONLEVEL
