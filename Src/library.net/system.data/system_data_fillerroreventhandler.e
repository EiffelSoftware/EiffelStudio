indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.FillErrorEventHandler"

frozen external class
	SYSTEM_DATA_FILLERROREVENTHANDLER

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
	make_fillerroreventhandler

feature {NONE} -- Initialization

	frozen make_fillerroreventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Data.FillErrorEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_DATA_FILLERROREVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Data.FillErrorEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Data.FillErrorEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Data.FillErrorEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_DATA_FILLERROREVENTARGS) is
		external
			"IL signature (System.Object, System.Data.FillErrorEventArgs): System.Void use System.Data.FillErrorEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DATA_FILLERROREVENTHANDLER
