indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.RenderMethod"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_RENDER_METHOD

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_render_method

feature {NONE} -- Initialization

	frozen make_web_render_method (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.UI.RenderMethod"
		end

feature -- Basic Operations

	begin_invoke (output: WEB_HTML_TEXT_WRITER; container: WEB_CONTROL; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.Control, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.RenderMethod"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.RenderMethod"
		alias
			"EndInvoke"
		end

	invoke (output: WEB_HTML_TEXT_WRITER; container: WEB_CONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.Control): System.Void use System.Web.UI.RenderMethod"
		alias
			"Invoke"
		end

end -- class WEB_RENDER_METHOD
