indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeaterItemEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTHANDLER

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
	make_repeateritemeventhandler

feature {NONE} -- Initialization

	frozen make_repeateritemeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.RepeaterItemEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterItemEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterItemEventArgs): System.Void use System.Web.UI.WebControls.RepeaterItemEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATERITEMEVENTHANDLER
