indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpContext"

frozen external class
	SYSTEM_WEB_HTTPCONTEXT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ISERVICEPROVIDER
		rename
			get_service as system_iservice_provider_get_service
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (request: SYSTEM_WEB_HTTPREQUEST; response: SYSTEM_WEB_HTTPRESPONSE) is
		external
			"IL creator signature (System.Web.HttpRequest, System.Web.HttpResponse) use System.Web.HttpContext"
		end

	frozen make_1 (wr: SYSTEM_WEB_HTTPWORKERREQUEST) is
		external
			"IL creator signature (System.Web.HttpWorkerRequest) use System.Web.HttpContext"
		end

feature -- Access

	frozen get_error: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Web.HttpContext"
		alias
			"get_Error"
		end

	frozen get_application_instance: SYSTEM_WEB_HTTPAPPLICATION is
		external
			"IL signature (): System.Web.HttpApplication use System.Web.HttpContext"
		alias
			"get_ApplicationInstance"
		end

	frozen get_is_debugging_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpContext"
		alias
			"get_IsDebuggingEnabled"
		end

	frozen get_is_custom_error_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpContext"
		alias
			"get_IsCustomErrorEnabled"
		end

	frozen get_server: SYSTEM_WEB_HTTPSERVERUTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.HttpContext"
		alias
			"get_Server"
		end

	frozen get_trace: SYSTEM_WEB_TRACECONTEXT is
		external
			"IL signature (): System.Web.TraceContext use System.Web.HttpContext"
		alias
			"get_Trace"
		end

	frozen get_cache: SYSTEM_WEB_CACHING_CACHE is
		external
			"IL signature (): System.Web.Caching.Cache use System.Web.HttpContext"
		alias
			"get_Cache"
		end

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.HttpContext"
		alias
			"get_User"
		end

	frozen get_session: SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.HttpContext"
		alias
			"get_Session"
		end

	frozen get_all_errors: ARRAY [SYSTEM_EXCEPTION] is
		external
			"IL signature (): System.Exception[] use System.Web.HttpContext"
		alias
			"get_AllErrors"
		end

	frozen get_timestamp: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpContext"
		alias
			"get_Timestamp"
		end

	frozen get_current: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL static signature (): System.Web.HttpContext use System.Web.HttpContext"
		alias
			"get_Current"
		end

	frozen get_items: SYSTEM_COLLECTIONS_IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.HttpContext"
		alias
			"get_Items"
		end

	frozen get_handler: SYSTEM_WEB_IHTTPHANDLER is
		external
			"IL signature (): System.Web.IHttpHandler use System.Web.HttpContext"
		alias
			"get_Handler"
		end

	frozen get_request: SYSTEM_WEB_HTTPREQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.HttpContext"
		alias
			"get_Request"
		end

	frozen get_response: SYSTEM_WEB_HTTPRESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.HttpContext"
		alias
			"get_Response"
		end

	frozen get_application: SYSTEM_WEB_HTTPAPPLICATIONSTATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.HttpContext"
		alias
			"get_Application"
		end

	frozen get_skip_authorization: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpContext"
		alias
			"get_SkipAuthorization"
		end

feature -- Element Change

	frozen set_user (value: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.HttpContext"
		alias
			"set_User"
		end

	frozen set_application_instance (value: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL signature (System.Web.HttpApplication): System.Void use System.Web.HttpContext"
		alias
			"set_ApplicationInstance"
		end

	frozen set_skip_authorization (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpContext"
		alias
			"set_SkipAuthorization"
		end

	frozen set_handler (value: SYSTEM_WEB_IHTTPHANDLER) is
		external
			"IL signature (System.Web.IHttpHandler): System.Void use System.Web.HttpContext"
		alias
			"set_Handler"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.HttpContext"
		alias
			"ToString"
		end

	frozen clear_error is
		external
			"IL signature (): System.Void use System.Web.HttpContext"
		alias
			"ClearError"
		end

	frozen get_app_config (name: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Web.HttpContext"
		alias
			"GetAppConfig"
		end

	frozen rewrite_path (path: STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpContext"
		alias
			"RewritePath"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.HttpContext"
		alias
			"Equals"
		end

	frozen add_error (error_info: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Web.HttpContext"
		alias
			"AddError"
		end

	frozen get_config (name: STRING): ANY is
		external
			"IL signature (System.String): System.Object use System.Web.HttpContext"
		alias
			"GetConfig"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpContext"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_iservice_provider_get_service (service: SYSTEM_TYPE): ANY is
		external
			"IL signature (System.Type): System.Object use System.Web.HttpContext"
		alias
			"System.IServiceProvider.GetService"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.HttpContext"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_HTTPCONTEXT
