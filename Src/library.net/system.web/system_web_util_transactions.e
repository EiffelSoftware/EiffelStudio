indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Util.Transactions"

external class
	SYSTEM_WEB_UTIL_TRANSACTIONS

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Util.Transactions"
		end

feature -- Basic Operations

	frozen invoke_transacted (callback: SYSTEM_WEB_UTIL_TRANSACTEDCALLBACK; mode: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION) is
		external
			"IL static signature (System.Web.Util.TransactedCallback, System.EnterpriseServices.TransactionOption): System.Void use System.Web.Util.Transactions"
		alias
			"InvokeTransacted"
		end

	frozen invoke_transacted_transacted_callback_transaction_option_boolean (callback: SYSTEM_WEB_UTIL_TRANSACTEDCALLBACK; mode: SYSTEM_ENTERPRISESERVICES_TRANSACTIONOPTION; transaction_aborted: BOOLEAN) is
		external
			"IL static signature (System.Web.Util.TransactedCallback, System.EnterpriseServices.TransactionOption, System.Boolean&): System.Void use System.Web.Util.Transactions"
		alias
			"InvokeTransacted"
		end

end -- class SYSTEM_WEB_UTIL_TRANSACTIONS
