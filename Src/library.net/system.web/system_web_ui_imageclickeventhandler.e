indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ImageClickEventHandler"

frozen external class
	SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER

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
	make_imageclickeventhandler

feature {NONE} -- Initialization

	frozen make_imageclickeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.ImageClickEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WEB_UI_IMAGECLICKEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.ImageClickEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.ImageClickEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.ImageClickEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WEB_UI_IMAGECLICKEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.ImageClickEventArgs): System.Void use System.Web.UI.ImageClickEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_IMAGECLICKEVENTHANDLER
