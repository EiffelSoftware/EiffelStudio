indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.PropertyChangedEventHandler"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_PROPERTY_CHANGED_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_dll_property_changed_event_handler

feature {NONE} -- Initialization

	frozen make_system_dll_property_changed_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.ComponentModel.PropertyChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.ComponentModel.PropertyChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.ComponentModel.PropertyChangedEventArgs): System.Void use System.ComponentModel.PropertyChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_DLL_PROPERTY_CHANGED_EVENT_HANDLER
