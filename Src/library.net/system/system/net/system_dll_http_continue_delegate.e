indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.HttpContinueDelegate"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_HTTP_CONTINUE_DELEGATE

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_system_dll_http_continue_delegate

feature {NONE} -- Initialization

	frozen make_system_dll_http_continue_delegate (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Net.HttpContinueDelegate"
		end

feature -- Basic Operations

	begin_invoke (status_code: INTEGER; http_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Int32, System.Net.WebHeaderCollection, System.AsyncCallback, System.Object): System.IAsyncResult use System.Net.HttpContinueDelegate"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Net.HttpContinueDelegate"
		alias
			"EndInvoke"
		end

	invoke (status_code: INTEGER; http_headers: SYSTEM_DLL_WEB_HEADER_COLLECTION) is
		external
			"IL signature (System.Int32, System.Net.WebHeaderCollection): System.Void use System.Net.HttpContinueDelegate"
		alias
			"Invoke"
		end

end -- class SYSTEM_DLL_HTTP_CONTINUE_DELEGATE
