indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.IHttpModule"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IHTTP_MODULE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	dispose is
		external
			"IL deferred signature (): System.Void use System.Web.IHttpModule"
		alias
			"Dispose"
		end

	init (context: WEB_HTTP_APPLICATION) is
		external
			"IL deferred signature (System.Web.HttpApplication): System.Void use System.Web.IHttpModule"
		alias
			"Init"
		end

end -- class WEB_IHTTP_MODULE
