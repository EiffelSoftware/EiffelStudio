indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ObjectCreationDelegate"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	OBJECT_CREATION_DELEGATE

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_object_creation_delegate

feature {NONE} -- Initialization

	frozen make_object_creation_delegate (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.InteropServices.ObjectCreationDelegate"
		end

feature -- Basic Operations

	begin_invoke (aggregator: POINTER; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.IntPtr, System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): POINTER is
		external
			"IL signature (System.IAsyncResult): System.IntPtr use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"EndInvoke"
		end

	invoke (aggregator: POINTER): POINTER is
		external
			"IL signature (System.IntPtr): System.IntPtr use System.Runtime.InteropServices.ObjectCreationDelegate"
		alias
			"Invoke"
		end

end -- class OBJECT_CREATION_DELEGATE
