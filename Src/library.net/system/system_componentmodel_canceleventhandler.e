indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.CancelEventHandler"

frozen external class
	SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER

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
	make_canceleventhandler

feature {NONE} -- Initialization

	frozen make_canceleventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.ComponentModel.CancelEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.ComponentModel.CancelEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.CancelEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.CancelEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_COMPONENTMODEL_CANCELEVENTARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.CancelEventArgs): System.Void use System.ComponentModel.CancelEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_COMPONENTMODEL_CANCELEVENTHANDLER
