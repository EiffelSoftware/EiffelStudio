indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.DesignerTransactionCloseEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_designer_transaction_close_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_designer_transaction_close_event_args (commit: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.Design.DesignerTransactionCloseEventArgs"
		end

feature -- Access

	frozen get_transaction_committed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.Design.DesignerTransactionCloseEventArgs"
		alias
			"get_TransactionCommitted"
		end

end -- class SYSTEM_DLL_DESIGNER_TRANSACTION_CLOSE_EVENT_ARGS
