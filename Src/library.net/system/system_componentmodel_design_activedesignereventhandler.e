indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.ActiveDesignerEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTHANDLER

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
	make_activedesignereventhandler

feature {NONE} -- Initialization

	frozen make_activedesignereventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.Design.ActiveDesignerEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ActiveDesignerEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.ActiveDesignerEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.Design.ActiveDesignerEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.Design.ActiveDesignerEventArgs): System.Void use System.ComponentModel.Design.ActiveDesignerEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_ACTIVEDESIGNEREVENTHANDLER
