indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpApplication"

external class
	SYSTEM_WEB_HTTPAPPLICATION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_IHTTPHANDLER
		rename
			get_is_reusable as system_web_ihttp_handler_get_is_reusable,
			process_request as system_web_ihttp_handler_process_request
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WEB_IHTTPASYNCHANDLER
		rename
			get_is_reusable as system_web_ihttp_handler_get_is_reusable,
			process_request as system_web_ihttp_handler_process_request,
			end_process_request as system_web_ihttp_async_handler_end_process_request,
			begin_process_request as system_web_ihttp_async_handler_begin_process_request
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.HttpApplication"
		end

feature -- Access

	frozen get_user: SYSTEM_SECURITY_PRINCIPAL_IPRINCIPAL is
		external
			"IL signature (): System.Security.Principal.IPrincipal use System.Web.HttpApplication"
		alias
			"get_User"
		end

	frozen get_server: SYSTEM_WEB_HTTPSERVERUTILITY is
		external
			"IL signature (): System.Web.HttpServerUtility use System.Web.HttpApplication"
		alias
			"get_Server"
		end

	frozen get_context: SYSTEM_WEB_HTTPCONTEXT is
		external
			"IL signature (): System.Web.HttpContext use System.Web.HttpApplication"
		alias
			"get_Context"
		end

	frozen get_modules: SYSTEM_WEB_HTTPMODULECOLLECTION is
		external
			"IL signature (): System.Web.HttpModuleCollection use System.Web.HttpApplication"
		alias
			"get_Modules"
		end

	frozen get_application: SYSTEM_WEB_HTTPAPPLICATIONSTATE is
		external
			"IL signature (): System.Web.HttpApplicationState use System.Web.HttpApplication"
		alias
			"get_Application"
		end

	frozen get_response: SYSTEM_WEB_HTTPRESPONSE is
		external
			"IL signature (): System.Web.HttpResponse use System.Web.HttpApplication"
		alias
			"get_Response"
		end

	frozen get_site: SYSTEM_COMPONENTMODEL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Web.HttpApplication"
		alias
			"get_Site"
		end

	frozen get_session: SYSTEM_WEB_SESSIONSTATE_HTTPSESSIONSTATE is
		external
			"IL signature (): System.Web.SessionState.HttpSessionState use System.Web.HttpApplication"
		alias
			"get_Session"
		end

	frozen get_request: SYSTEM_WEB_HTTPREQUEST is
		external
			"IL signature (): System.Web.HttpRequest use System.Web.HttpApplication"
		alias
			"get_Request"
		end

feature -- Element Change

	frozen remove_post_request_handler_execute (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_PostRequestHandlerExecute"
		end

	frozen remove_error (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_Error"
		end

	frozen remove_end_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_EndRequest"
		end

	frozen add_authenticate_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_AuthenticateRequest"
		end

	frozen remove_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_Disposed"
		end

	frozen add_begin_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_BeginRequest"
		end

	frozen remove_pre_send_request_content (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_PreSendRequestContent"
		end

	frozen add_pre_send_request_content (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_PreSendRequestContent"
		end

	frozen add_acquire_request_state (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_AcquireRequestState"
		end

	frozen add_disposed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_Disposed"
		end

	frozen remove_authorize_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_AuthorizeRequest"
		end

	frozen remove_update_request_cache (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_UpdateRequestCache"
		end

	frozen add_resolve_request_cache (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_ResolveRequestCache"
		end

	frozen add_release_request_state (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_ReleaseRequestState"
		end

	frozen add_update_request_cache (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_UpdateRequestCache"
		end

	frozen remove_pre_send_request_headers (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_PreSendRequestHeaders"
		end

	frozen set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Web.HttpApplication"
		alias
			"set_Site"
		end

	frozen remove_resolve_request_cache (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_ResolveRequestCache"
		end

	frozen remove_acquire_request_state (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_AcquireRequestState"
		end

	frozen remove_release_request_state (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_ReleaseRequestState"
		end

	frozen add_authorize_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_AuthorizeRequest"
		end

	frozen add_post_request_handler_execute (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_PostRequestHandlerExecute"
		end

	frozen remove_authenticate_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_AuthenticateRequest"
		end

	frozen remove_begin_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_BeginRequest"
		end

	frozen add_error (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_Error"
		end

	frozen remove_pre_request_handler_execute (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"remove_PreRequestHandlerExecute"
		end

	frozen add_pre_request_handler_execute (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_PreRequestHandlerExecute"
		end

	frozen add_pre_send_request_headers (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_PreSendRequestHeaders"
		end

	frozen add_end_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Web.HttpApplication"
		alias
			"add_EndRequest"
		end

feature -- Basic Operations

	frozen add_on_end_request_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnEndRequestAsync"
		end

	frozen add_on_begin_request_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnBeginRequestAsync"
		end

	frozen add_on_pre_request_handler_execute_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnPreRequestHandlerExecuteAsync"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.HttpApplication"
		alias
			"Equals"
		end

	frozen add_on_authenticate_request_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnAuthenticateRequestAsync"
		end

	frozen complete_request is
		external
			"IL signature (): System.Void use System.Web.HttpApplication"
		alias
			"CompleteRequest"
		end

	frozen add_on_post_request_handler_execute_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnPostRequestHandlerExecuteAsync"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpApplication"
		alias
			"GetHashCode"
		end

	init is
		external
			"IL signature (): System.Void use System.Web.HttpApplication"
		alias
			"Init"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Web.HttpApplication"
		alias
			"Dispose"
		end

	frozen add_on_resolve_request_cache_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnResolveRequestCacheAsync"
		end

	frozen add_on_authorize_request_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnAuthorizeRequestAsync"
		end

	frozen add_on_update_request_cache_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnUpdateRequestCacheAsync"
		end

	frozen add_on_release_request_state_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnReleaseRequestStateAsync"
		end

	get_vary_by_custom_string (context: SYSTEM_WEB_HTTPCONTEXT; custom: STRING): STRING is
		external
			"IL signature (System.Web.HttpContext, System.String): System.String use System.Web.HttpApplication"
		alias
			"GetVaryByCustomString"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.HttpApplication"
		alias
			"ToString"
		end

	frozen add_on_acquire_request_state_async (bh: SYSTEM_WEB_BEGINEVENTHANDLER; eh: SYSTEM_WEB_ENDEVENTHANDLER) is
		external
			"IL signature (System.Web.BeginEventHandler, System.Web.EndEventHandler): System.Void use System.Web.HttpApplication"
		alias
			"AddOnAcquireRequestStateAsync"
		end

feature {NONE} -- Implementation

	frozen get_events: SYSTEM_COMPONENTMODEL_EVENTHANDLERLIST is
		external
			"IL signature (): System.ComponentModel.EventHandlerList use System.Web.HttpApplication"
		alias
			"get_Events"
		end

	frozen system_web_ihttp_handler_process_request (context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL signature (System.Web.HttpContext): System.Void use System.Web.HttpApplication"
		alias
			"System.Web.IHttpHandler.ProcessRequest"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Web.HttpApplication"
		alias
			"Finalize"
		end

	frozen system_web_ihttp_async_handler_end_process_request (result_: SYSTEM_IASYNCRESULT) is
		external
			"IL signature (System.IAsyncResult): System.Void use System.Web.HttpApplication"
		alias
			"System.Web.IHttpAsyncHandler.EndProcessRequest"
		end

	frozen system_web_ihttp_handler_get_is_reusable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpApplication"
		alias
			"System.Web.IHttpHandler.get_IsReusable"
		end

	frozen system_web_ihttp_async_handler_begin_process_request (context: SYSTEM_WEB_HTTPCONTEXT; cb: SYSTEM_ASYNCCALLBACK; extra_data: ANY): SYSTEM_IASYNCRESULT is
		external
			"IL signature (System.Web.HttpContext, System.AsyncCallback, System.Object): System.IAsyncResult use System.Web.HttpApplication"
		alias
			"System.Web.IHttpAsyncHandler.BeginProcessRequest"
		end

end -- class SYSTEM_WEB_HTTPAPPLICATION
