indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.RenderMethod"

frozen external class
	SYSTEM_WEB_UI_RENDERMETHOD

inherit
	SYSTEM_MULTICASTDELEGATE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICLONEABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			is_equal as equals_object
		end

create
	make_rendermethod

feature {NONE} -- Initialization

	frozen make_rendermethod (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.RenderMethod"
		end

feature -- Basic Operations

	begin_invoke (output: SYSTEM_WEB_UI_HTMLTEXTWRITER; container: SYSTEM_WEB_UI_CONTROL; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.Control, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.RenderMethod"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.RenderMethod"
		alias
			"EndInvoke"
		end

	invoke (output: SYSTEM_WEB_UI_HTMLTEXTWRITER; container: SYSTEM_WEB_UI_CONTROL) is
		external
			"IL signature (System.Web.UI.HtmlTextWriter, System.Web.UI.Control): System.Void use System.Web.UI.RenderMethod"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_RENDERMETHOD
