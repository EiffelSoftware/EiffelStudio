indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ResolveEventHandler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RESOLVE_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_resolve_event_handler

feature {NONE} -- Initialization

	frozen make_resolve_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.ResolveEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; args: RESOLVE_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.ResolveEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ResolveEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): ASSEMBLY is
		external
			"IL signature (System.IAsyncResult): System.Reflection.Assembly use System.ResolveEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; args: RESOLVE_EVENT_ARGS): ASSEMBLY is
		external
			"IL signature (System.Object, System.ResolveEventArgs): System.Reflection.Assembly use System.ResolveEventHandler"
		alias
			"Invoke"
		end

end -- class RESOLVE_EVENT_HANDLER
