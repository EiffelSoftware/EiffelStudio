indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.Services.RemotingService"

external class
	SYSTEM_RUNTIME_REMOTING_SERVICES_REMOTINGSERVICE

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

create
	make_remotingservice

feature {NONE} -- Initialization

	frozen make_remotingservice is
		external
			"IL creator use System.Runtime.Remoting.Services.RemotingService"
		end

feature -- Access

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_User"
		end

	frozen get_application: SYSTEM_WEB_HTTPAPPLICATIONSTATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Application"
		end

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Context"
		end

	frozen get_server: SYSTEM_WEB_HTTPSERVERUTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Server"
		end

	frozen get_session: SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Runtime.Remoting.Services.RemotingService"
		alias
			"get_Session"
		end

end -- class SYSTEM_RUNTIME_REMOTING_SERVICES_REMOTINGSERVICE
