indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.HeaderHandler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	HEADER_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_header_handler

feature {NONE} -- Initialization

	frozen make_header_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.Remoting.Messaging.HeaderHandler"
		end

feature -- Basic Operations

	begin_invoke (headers: NATIVE_ARRAY [HEADER]; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[], System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): System.Object use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"EndInvoke"
		end

	invoke (headers: NATIVE_ARRAY [HEADER]): SYSTEM_OBJECT is
		external
			"IL signature (System.Runtime.Remoting.Messaging.Header[]): System.Object use System.Runtime.Remoting.Messaging.HeaderHandler"
		alias
			"Invoke"
		end

end -- class HEADER_HANDLER
