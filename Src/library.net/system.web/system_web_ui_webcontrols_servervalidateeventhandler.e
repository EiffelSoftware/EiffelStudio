indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.WebControls.ServerValidateEventHandler"

frozen external class
	SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTHANDLER

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
	make_servervalidateeventhandler

feature {NONE} -- Initialization

	frozen make_servervalidateeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.UI.WebControls.ServerValidateEventHandler"
		end

feature -- Basic Operations

	begin_invoke (source: ANY; args: SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.ServerValidateEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.UI.WebControls.ServerValidateEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.UI.WebControls.ServerValidateEventHandler"
		alias
			"EndInvoke"
		end

	invoke (source: ANY; args: SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.UI.WebControls.ServerValidateEventArgs): System.Void use System.Web.UI.WebControls.ServerValidateEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_UI_WEBCONTROLS_SERVERVALIDATEEVENTHANDLER
