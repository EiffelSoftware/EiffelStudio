indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.IHttpHandlerFactory"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IHTTP_HANDLER_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	release_handler (handler: WEB_IHTTP_HANDLER) is
		external
			"IL deferred signature (System.Web.IHttpHandler): System.Void use System.Web.IHttpHandlerFactory"
		alias
			"ReleaseHandler"
		end

	get_handler (context: WEB_HTTP_CONTEXT; request_type: SYSTEM_STRING; url: SYSTEM_STRING; path_translated: SYSTEM_STRING): WEB_IHTTP_HANDLER is
		external
			"IL deferred signature (System.Web.HttpContext, System.String, System.String, System.String): System.Web.IHttpHandler use System.Web.IHttpHandlerFactory"
		alias
			"GetHandler"
		end

end -- class WEB_IHTTP_HANDLER_FACTORY
