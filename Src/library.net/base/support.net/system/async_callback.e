indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AsyncCallback"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASYNC_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_async_callback

feature {NONE} -- Initialization

	frozen make_async_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.AsyncCallback"
		end

feature -- Basic Operations

	begin_invoke (ar: IASYNC_RESULT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.IAsyncResult, System.AsyncCallback, System.Object): System.IAsyncResult use System.AsyncCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AsyncCallback"
		alias
			"EndInvoke"
		end

	invoke (ar: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AsyncCallback"
		alias
			"Invoke"
		end

end -- class ASYNC_CALLBACK
