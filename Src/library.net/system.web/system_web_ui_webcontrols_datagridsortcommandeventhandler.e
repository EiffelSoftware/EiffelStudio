indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridSortCommandEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTHANDLER

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
	make_datagridsortcommandeventhandler

feature {NONE} -- Initialization

	frozen make_datagridsortcommandeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.DataGridSortCommandEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridSortCommandEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.DataGridSortCommandEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.DataGridSortCommandEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridSortCommandEventArgs): System.Void use System.Web.UI.WebControls.DataGridSortCommandEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDSORTCOMMANDEVENTHANDLER
