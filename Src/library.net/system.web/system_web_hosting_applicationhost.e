indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.Hosting.ApplicationHost"

frozen external class
	SYSTEM_WEB_HOSTING_APPLICATIONHOST

create {NONE}

feature -- Basic Operations

	frozen create_application_host (host_type: SYSTEM_TYPE; virtual_dir: STRING; physical_dir: STRING): ANY is
		external
			"IL static signature (System.Type, System.String, System.String): System.Object use System.Web.Hosting.ApplicationHost"
		alias
			"CreateApplicationHost"
		end

end -- class SYSTEM_WEB_HOSTING_APPLICATIONHOST
