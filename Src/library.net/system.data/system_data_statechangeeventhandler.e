indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.StateChangeEventHandler"

frozen external class
	SYSTEM_DATA_STATECHANGEEVENTHANDLER

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
	make_statechangeeventhandler

feature {NONE} -- Initialization

	frozen make_statechangeeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.StateChangeEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_STATECHANGEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.StateChangeEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.StateChangeEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.StateChangeEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_STATECHANGEEVENTARGS) is
		external
			"IL signature (System.Object, System.Data.StateChangeEventArgs): System.Void use System.Data.StateChangeEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_STATECHANGEEVENTHANDLER
