indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Hosting.AppDomainFactory"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_APP_DOMAIN_FACTORY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	WEB_IAPP_DOMAIN_FACTORY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.Hosting.AppDomainFactory"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.Hosting.AppDomainFactory"
		alias
			"GetHashCode"
		end

	frozen create_ (module: SYSTEM_STRING; type_name: SYSTEM_STRING; app_id: SYSTEM_STRING; app_path: SYSTEM_STRING; str_url_of_app_origin: SYSTEM_STRING; i_zone: INTEGER): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.Int32): System.Object use System.Web.Hosting.AppDomainFactory"
		alias
			"Create"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.AppDomainFactory"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.Hosting.AppDomainFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.Hosting.AppDomainFactory"
		alias
			"Finalize"
		end

end -- class WEB_APP_DOMAIN_FACTORY
