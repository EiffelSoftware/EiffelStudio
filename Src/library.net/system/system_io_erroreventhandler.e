indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.IO.ErrorEventHandler"

frozen external class
	SYSTEM_IO_ERROREVENTHANDLER

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
	make_erroreventhandler

feature {NONE} -- Initialization

	frozen make_erroreventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.IO.ErrorEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_IO_ERROREVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.IO.ErrorEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.IO.ErrorEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.IO.ErrorEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_IO_ERROREVENTARGS) is
		external
			"IL signature (System.Object, System.IO.ErrorEventArgs): System.Void use System.IO.ErrorEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_IO_ERROREVENTHANDLER
