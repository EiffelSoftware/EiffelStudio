indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.AppDomainFactory"

frozen external class
	SYSTEM_WEB_HOSTING_APPDOMAINFACTORY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_WEB_HOSTING_IAPPDOMAINFACTORY

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

	frozen Create_ (module: STRING; type_name: STRING; app_id: STRING; app_path: STRING; str_url_of_app_origin: STRING; i_zone: INTEGER): ANY is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.Int32): System.Object use System.Web.Hosting.AppDomainFactory"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.Hosting.AppDomainFactory"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_WEB_HOSTING_APPDOMAINFACTORY
