indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.DataGridPageChangedEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTHANDLER

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
	make_datagridpagechangedeventhandler

feature {NONE} -- Initialization

	frozen make_datagridpagechangedeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.DataGridPageChangedEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridPageChangedEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.DataGridPageChangedEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.DataGridPageChangedEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; e: SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.DataGridPageChangedEventArgs): System.Void use System.Web.UI.WebControls.DataGridPageChangedEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_DATAGRIDPAGECHANGEDEVENTHANDLER
