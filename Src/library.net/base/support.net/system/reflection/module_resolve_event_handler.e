indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ModuleResolveEventHandler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MODULE_RESOLVE_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_module_resolve_event_handler

feature {NONE} -- Initialization

	frozen make_module_resolve_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Reflection.ModuleResolveEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: RESOLVE_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.ResolveEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Reflection.ModuleResolveEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): MODULE is
		external
			"IL signature (System.IAsyncResult): System.Reflection.Module use System.Reflection.ModuleResolveEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: RESOLVE_EVENT_ARGS): MODULE is
		external
			"IL signature (System.Object, System.ResolveEventArgs): System.Reflection.Module use System.Reflection.ModuleResolveEventHandler"
		alias
			"Invoke"
		end

end -- class MODULE_RESOLVE_EVENT_HANDLER
