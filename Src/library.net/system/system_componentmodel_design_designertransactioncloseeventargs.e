indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerTransactionCloseEventArgs"

external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_designertransactioncloseeventargs

feature {NONE} -- Initialization

	frozen make_designertransactioncloseeventargs (commit: BOOLEAN) is
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

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTARGS
