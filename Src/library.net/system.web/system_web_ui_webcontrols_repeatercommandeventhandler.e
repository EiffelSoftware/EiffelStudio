indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.RepeaterCommandEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTHANDLER

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
	make_repeatercommandeventhandler

feature {NONE} -- Initialization

	frozen make_repeatercommandeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.RepeaterCommandEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterCommandEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.RepeaterCommandEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.RepeaterCommandEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.RepeaterCommandEventArgs): System.Void use System.Web.UI.WebControls.RepeaterCommandEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_REPEATERCOMMANDEVENTHANDLER
