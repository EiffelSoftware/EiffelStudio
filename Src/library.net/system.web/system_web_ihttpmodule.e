indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.IHttpModule"

deferred external class
	SYSTEM_WEB_IHTTPMODULE

inherit
	ANY
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

	init (context: SYSTEM_WEB_HTTPAPPLICATION) is
		external
			"IL deferred signature (System.Web.HttpApplication): System.Void use System.Web.IHttpModule"
		alias
			"Init"
		end

end -- class SYSTEM_WEB_IHTTPMODULE
