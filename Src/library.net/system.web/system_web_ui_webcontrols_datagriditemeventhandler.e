indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridItemEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER

inherit
	SYSTEM_MULTICASTDELEGATE
	SYSTEM_ICLONEABLE
		rename
			equals as equals_object
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
		rename
			equals as equals_object
		end

create
	make_datagriditemeventhandler

feature {NONE} -- Initialization

	frozen make_datagriditemeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.DataGridItemEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridItemEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.DataGridItemEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.DataGridItemEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridItemEventArgs): System.Void use System.Web.UI.WebControls.DataGridItemEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDITEMEVENTHANDLER
