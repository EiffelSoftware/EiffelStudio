indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.TransactionVote"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_ENTERPRISESERVICES_TRANSACTIONVOTE

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

	frozen commit: SYSTEM_ENTERPRISESERVICES_TRANSACTIONVOTE is
		external
			"IL enum signature :System.EnterpriseServices.TransactionVote use System.EnterpriseServices.TransactionVote"
		alias
			"0"
		end

	frozen abort: SYSTEM_ENTERPRISESERVICES_TRANSACTIONVOTE is
		external
			"IL enum signature :System.EnterpriseServices.TransactionVote use System.EnterpriseServices.TransactionVote"
		alias
			"1"
		end

end -- class SYSTEM_ENTERPRISESERVICES_TRANSACTIONVOTE
