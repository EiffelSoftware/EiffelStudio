indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.AsyncCallback"

frozen external class
	SYSTEM_ASYNCCALLBACK

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE

create
	make_async_callback

feature {NONE} -- Initialization

	frozen make_async_callback (object: ANY; method2: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.AsyncCallback"
		end

feature -- Basic Operations

	begin_invoke (ar: SYSTEM_IASYNCRESULT; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.IAsyncResult, System.AsyncCallback, System.Object): System.IAsyncResult use System.AsyncCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AsyncCallback"
		alias
			"EndInvoke"
		end

	invoke (ar: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AsyncCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_ASYNCCALLBACK
