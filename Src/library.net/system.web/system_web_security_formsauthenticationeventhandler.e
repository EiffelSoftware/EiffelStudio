indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.FormsAuthenticationEventHandler"

frozen external class
	SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTHANDLER

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
	make_formsauthenticationeventhandler

feature {NONE} -- Initialization

	frozen make_formsauthenticationeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.Security.FormsAuthenticationEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.Security.FormsAuthenticationEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.Security.FormsAuthenticationEventArgs): System.Void use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_SECURITY_FORMSAUTHENTICATIONEVENTHANDLER
