indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Contexts.CrossContextDelegate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CROSS_CONTEXT_DELEGATE

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_cross_context_delegate

feature {NONE} -- Initialization

	frozen make_cross_context_delegate (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"EndInvoke"
		end

	invoke is
		external
			"IL signature (): System.Void use System.Runtime.Remoting.Contexts.CrossContextDelegate"
		alias
			"Invoke"
		end

end -- class CROSS_CONTEXT_DELEGATE
