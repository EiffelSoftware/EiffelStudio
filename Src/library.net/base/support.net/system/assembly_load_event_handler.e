indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.AssemblyLoadEventHandler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	ASSEMBLY_LOAD_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_assembly_load_event_handler

feature {NONE} -- Initialization

	frozen make_assembly_load_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.AssemblyLoadEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; args: ASSEMBLY_LOAD_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.AssemblyLoadEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.AssemblyLoadEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.AssemblyLoadEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; args: ASSEMBLY_LOAD_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.AssemblyLoadEventArgs): System.Void use System.AssemblyLoadEventHandler"
		alias
			"Invoke"
		end

end -- class ASSEMBLY_LOAD_EVENT_HANDLER
