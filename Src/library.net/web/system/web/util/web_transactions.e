indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Util.Transactions"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_TRANSACTIONS

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Util.Transactions"
		end

feature -- Basic Operations

	frozen invoke_transacted (callback: WEB_TRANSACTED_CALLBACK; mode: ENT_SERV_TRANSACTION_OPTION) is
		external
			"IL static signature (System.Web.Util.TransactedCallback, System.EnterpriseServices.TransactionOption): System.Void use System.Web.Util.Transactions"
		alias
			"InvokeTransacted"
		end

	frozen invoke_transacted_transacted_callback_transaction_option_boolean (callback: WEB_TRANSACTED_CALLBACK; mode: ENT_SERV_TRANSACTION_OPTION; transaction_aborted: BOOLEAN) is
		external
			"IL static signature (System.Web.Util.TransactedCallback, System.EnterpriseServices.TransactionOption, System.Boolean&): System.Void use System.Web.Util.Transactions"
		alias
			"InvokeTransacted"
		end

end -- class WEB_TRANSACTIONS
