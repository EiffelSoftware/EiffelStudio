indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.IHttpHandler"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IHTTP_HANDLER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_is_reusable: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Web.IHttpHandler"
		alias
			"get_IsReusable"
		end

feature -- Basic Operations

	process_request (context: WEB_HTTP_CONTEXT) is
		external
			"IL deferred signature (System.Web.HttpContext): System.Void use System.Web.IHttpHandler"
		alias
			"ProcessRequest"
		end

end -- class WEB_IHTTP_HANDLER
