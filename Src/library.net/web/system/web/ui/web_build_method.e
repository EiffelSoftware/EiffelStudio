indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.BuildMethod"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_BUILD_METHOD

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_build_method

feature {NONE} -- Initialization

	frozen make_web_build_method (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.UI.BuildMethod"
		end

feature -- Basic Operations

	begin_invoke (callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.BuildMethod"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT): WEB_CONTROL is
		external
			"IL signature (System.IAsyncResult): System.Web.UI.Control use System.Web.UI.BuildMethod"
		alias
			"EndInvoke"
		end

	invoke: WEB_CONTROL is
		external
			"IL signature (): System.Web.UI.Control use System.Web.UI.BuildMethod"
		alias
			"Invoke"
		end

end -- class WEB_BUILD_METHOD
