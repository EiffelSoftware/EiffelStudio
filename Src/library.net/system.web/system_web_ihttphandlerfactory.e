indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.IHttpHandlerFactory"

deferred external class
	SYSTEM_WEB_IHTTPHANDLERFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	release_handler (handler: SYSTEM_WEB_IHTTPHANDLER) is
		external
			"IL deferred signature (System.Web.IHttpHandler): System.Void use System.Web.IHttpHandlerFactory"
		alias
			"ReleaseHandler"
		end

	get_handler (context: SYSTEM_WEB_HTTPCONTEXT; request_type: STRING; url: STRING; path_translated: STRING): SYSTEM_WEB_IHTTPHANDLER is
		external
			"IL deferred signature (System.Web.HttpContext, System.String, System.String, System.String): System.Web.IHttpHandler use System.Web.IHttpHandlerFactory"
		alias
			"GetHandler"
		end

end -- class SYSTEM_WEB_IHTTPHANDLERFACTORY
