indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpContext"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_CONTEXT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ISERVICE_PROVIDER
		rename
			get_service as system_iservice_provider_get_service
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (request: WEB_HTTP_REQUEST; response: WEB_HTTP_RESPONSE) is
		external
			"IL creator signature (System.Web.HttpRequest, System.Web.HttpResponse) use System.Web.HttpContext"
		end

	frozen make_1 (wr: WEB_HTTP_WORKER_REQUEST) is
		external
			"IL creator signature (System.Web.HttpWorkerRequest) use System.Web.HttpContext"
		end

feature -- Access

	frozen get_error: EXCEPTION is
		external
			"IL signature (): System.Exception use System.Web.HttpContext"
		alias
			"get_Error"
		end

	frozen get_application_instance: WEB_HTTP_APPLICATION is
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

	frozen get_server: WEB_HTTP_SERVER_UTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.HttpContext"
		alias
			"get_Server"
		end

	frozen get_trace: WEB_TRACE_CONTEXT is
		external
			"IL signature (): System.Web.TraceContext use System.Web.HttpContext"
		alias
			"get_Trace"
		end

	frozen get_cache: WEB_CACHE is
		external
			"IL signature (): System.Web.Caching.Cache use System.Web.HttpContext"
		alias
			"get_Cache"
		end

	frozen get_user: IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.HttpContext"
		alias
			"get_User"
		end

	frozen get_session: WEB_HTTP_SESSION_STATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.HttpContext"
		alias
			"get_Session"
		end

	frozen get_all_errors: NATIVE_ARRAY [EXCEPTION] is
		external
			"IL signature (): System.Exception[] use System.Web.HttpContext"
		alias
			"get_AllErrors"
		end

	frozen get_timestamp: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpContext"
		alias
			"get_Timestamp"
		end

	frozen get_current: WEB_HTTP_CONTEXT is
		external
			"IL static signature (): System.Web.HttpContext use System.Web.HttpContext"
		alias
			"get_Current"
		end

	frozen get_items: IDICTIONARY is
		external
			"IL signature (): System.Collections.IDictionary use System.Web.HttpContext"
		alias
			"get_Items"
		end

	frozen get_handler: WEB_IHTTP_HANDLER is
		external
			"IL signature (): System.Web.IHttpHandler use System.Web.HttpContext"
		alias
			"get_Handler"
		end

	frozen get_request: WEB_HTTP_REQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.HttpContext"
		alias
			"get_Request"
		end

	frozen get_response: WEB_HTTP_RESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.HttpContext"
		alias
			"get_Response"
		end

	frozen get_application: WEB_HTTP_APPLICATION_STATE is
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

	frozen set_user (value: IPRINCIPAL) is
		external
			"IL signature (System.Security.Principal.IPrincipal): System.Void use System.Web.HttpContext"
		alias
			"set_User"
		end

	frozen set_application_instance (value: WEB_HTTP_APPLICATION) is
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

	frozen set_handler (value: WEB_IHTTP_HANDLER) is
		external
			"IL signature (System.Web.IHttpHandler): System.Void use System.Web.HttpContext"
		alias
			"set_Handler"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
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

	frozen get_app_config (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Web.HttpContext"
		alias
			"GetAppConfig"
		end

	frozen rewrite_path (path: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpContext"
		alias
			"RewritePath"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.HttpContext"
		alias
			"Equals"
		end

	frozen add_error (error_info: EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Web.HttpContext"
		alias
			"AddError"
		end

	frozen get_config (name: SYSTEM_STRING): SYSTEM_OBJECT is
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

	frozen system_iservice_provider_get_service (service: TYPE): SYSTEM_OBJECT is
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

end -- class WEB_HTTP_CONTEXT
