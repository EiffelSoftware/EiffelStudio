indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Security.WindowsAuthenticationEventHandler"

frozen external class
	SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTHANDLER

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
	make_windowsauthenticationeventhandler

feature {NONE} -- Initialization

	frozen make_windowsauthenticationeventhandler (object: ANY; method: POINTER) is
		external
			"IL creator signature (System.Object, System.UIntPtr) use System.Web.Security.WindowsAuthenticationEventHandler"
		end

feature -- Basic Operations

	begin_invoke (sender: ANY; e: SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTARGS; callback: SYSTEM_ASYNCCALLBACK; object: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Object, System.Web.Security.WindowsAuthenticationEventArgs, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.Security.WindowsAuthenticationEventHandler"
		alias
			"BeginInvoke"
		end

	end_invoke (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.Security.WindowsAuthenticationEventHandler"
		alias
			"EndInvoke"
		end

	invoke (sender: ANY; e: SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTARGS) is
		external
			"IL signature (System.Object, System.Web.Security.WindowsAuthenticationEventArgs): System.Void use System.Web.Security.WindowsAuthenticationEventHandler"
		alias
			"Invoke"
		end

end -- class SYSTEM_WEB_SECURITY_WINDOWSAUTHENTICATIONEVENTHANDLER
