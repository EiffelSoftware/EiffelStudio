indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Threading.ThreadExceptionEventHandler"

frozen external class
	SYSTEM_THREADING_THREADEXCEPTIONEVENTHANDLER

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
	make_threadexceptioneventhandler

feature {NONE} -- Initialization

	frozen make_threadexceptioneventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Threading.ThreadExceptionEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_THREADING_THREADEXCEPTIONEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Threading.ThreadExceptionEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Threading.ThreadExceptionEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Threading.ThreadExceptionEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_THREADING_THREADEXCEPTIONEVENTARGS) is
		external
			"IL signature (System.Object, System.Threading.ThreadExceptionEventArgs): System.Void use System.Threading.ThreadExceptionEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_THREADING_THREADEXCEPTIONEVENTHANDLER
