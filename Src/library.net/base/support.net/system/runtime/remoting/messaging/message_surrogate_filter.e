indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MESSAGE_SURROGATE_FILTER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_message_surrogate_filter

feature {NONE} -- Initialization

	frozen make_message_surrogate_filter (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		end

feature -- Basic Operations

	begin_invoke (key: SYSTEM_STRING; value: SYSTEM_OBJECT; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.String, System.Object, System.AsyncCallback, System.Object): System.IAsyncResult use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): BOOLEAN is
		external
			"IL signature (System.IAsyncResult): System.Boolean use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"EndInvoke"
		end

	invoke (key: SYSTEM_STRING; value: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.String, System.Object): System.Boolean use System.Runtime.Remoting.Messaging.MessageSurrogateFilter"
		alias
			"Invoke"
		end

end -- class MESSAGE_SURROGATE_FILTER
