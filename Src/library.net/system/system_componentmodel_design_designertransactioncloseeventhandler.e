indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.DesignerTransactionCloseEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object	
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_designertransactioncloseeventhandler

feature {NONE} -- Initialization

	frozen make_designertransactioncloseeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.DesignerTransactionCloseEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.Design.DesignerTransactionCloseEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.DesignerTransactionCloseEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.Design.DesignerTransactionCloseEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.Design.DesignerTransactionCloseEventArgs): System.Void use System.ComponentModel.Design.DesignerTransactionCloseEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_DESIGNERTRANSACTIONCLOSEEVENTHANDLER
