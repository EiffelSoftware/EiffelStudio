indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.IAppDomainFactory"

deferred external class
	SYSTEM_WEB_HOSTING_IAPPDOMAINFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	Create_ (module: STRING; type_name: STRING; app_id: STRING; app_path: STRING; str_url_of_app_origin: STRING; i_zone: INTEGER): ANY is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String, System.String, System.Int32): System.Object use System.Web.Hosting.IAppDomainFactory"
		alias
			"Create"
		end

end -- class SYSTEM_WEB_HOSTING_IAPPDOMAINFACTORY
