indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.Services.RemotingService"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_REMOTING_SERVICE

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_rt_remoting_remoting_service

feature {NONE} -- Initialization

	frozen make_rt_remoting_remoting_service is
		external
			"IL creator use System.Runtime.Remoting.Services.RemotingService"
		end

feature -- Access

	frozen get_user: IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_User"
		end

	frozen get_application: WEB_HTTP_APPLICATION_STATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Application"
		end

	frozen get_context: WEB_HTTP_CONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Context"
		end

	frozen get_server: WEB_HTTP_SERVER_UTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Server"
		end

	frozen get_session: WEB_HTTP_SESSION_STATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Session"
		end

end -- class RT_REMOTING_REMOTING_SERVICE
