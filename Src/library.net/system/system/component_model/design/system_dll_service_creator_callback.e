indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.ServiceCreatorCallback"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_SERVICE_CREATOR_CALLBACK

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_dll_service_creator_callback

feature {NONE} -- Initialization

	frozen make_system_dll_service_creator_callback (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.ComponentModel.Design.ServiceCreatorCallback"
		end

feature -- Basic Operations

	begin_invoke (container: SYSTEM_DLL_ISERVICE_CONTAINER; service_type: TYPE; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.ComponentModel.Design.IServiceContainer, System.Type, System.AsyncCallback, System.Object): System.IAsyncResult use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): SYSTEM_OBJECT is
		external
			"IL signature (System.IAsyncResult): System.Object use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"EndInvoke"
		end

	invoke (container: SYSTEM_DLL_ISERVICE_CONTAINER; service_type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.ComponentModel.Design.IServiceContainer, System.Type): System.Object use System.ComponentModel.Design.ServiceCreatorCallback"
		alias
			"Invoke"
		end

end -- class SYSTEM_DLL_SERVICE_CREATOR_CALLBACK
