indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.IHttpHandler"

deferred external class
	SYSTEM_WEB_IHTTPHANDLER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

	process_request (context: SYSTEM_WEB_HTTPCONTEXT) is
		external
			"IL deferred signature (System.Web.HttpContext): System.Void use System.Web.IHttpHandler"
		alias
			"ProcessRequest"
		end

end -- class SYSTEM_WEB_IHTTPHANDLER
