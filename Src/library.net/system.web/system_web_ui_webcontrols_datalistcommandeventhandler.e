indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataListCommandEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER

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
	make_datalistcommandeventhandler

feature {NONE} -- Initialization

	frozen make_datalistcommandeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.DataListCommandEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataListCommandEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.DataListCommandEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.DataListCommandEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataListCommandEventArgs): System.Void use System.Web.UI.WebControls.DataListCommandEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATALISTCOMMANDEVENTHANDLER
