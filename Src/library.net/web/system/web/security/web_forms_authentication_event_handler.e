indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Security.FormsAuthenticationEventHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_FORMS_AUTHENTICATION_EVENT_HANDLER

inherit
	MULTICAST_DELEGATE
	ICLONEABLE
	ISERIALIZABLE

create
	make_web_forms_authentication_event_handler

feature {NONE} -- Initialization

	frozen make_web_forms_authentication_event_handler (object: SYSTEM_OBJECT; method: POINTER) is
		external
			"IL creator signature (System.Object, System.IntPtr) use System.Web.Security.FormsAuthenticationEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: SYSTEM_OBJECT; e: WEB_FORMS_AUTHENTICATION_EVENT_ARGS; callback: ASYNC_CALLBACK; object: SYSTEM_OBJECT): IASYNC_RESULT is
		external
			"IL signature (System.Object, System.Web.Security.FormsAuthenticationEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: IASYNC_RESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: SYSTEM_OBJECT; e: WEB_FORMS_AUTHENTICATION_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Web.Security.FormsAuthenticationEventArgs): System.Void use System.Web.Security.FormsAuthenticationEventHandler"
		alias
			"Invoke"
		end

end -- class WEB_FORMS_AUTHENTICATION_EVENT_HANDLER
