indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Hosting.IAppDomainFactory"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	WEB_IAPP_DOMAIN_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_ (module: SYSTEM_STRING; type_name: SYSTEM_STRING; app_id: SYSTEM_STRING; app_path: SYSTEM_STRING; str_url_of_app_origin: SYSTEM_STRING; i_zone: INTEGER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.Int32): System.Object use System.Web.Hosting.IAppDomainFactory"
		alias
			"Create"
		end

end -- class WEB_IAPP_DOMAIN_FACTORY
