indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Hosting.ApplicationHost"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_APPLICATION_HOST

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Basic Operations

	frozen create_application_host (host_type: TYPE; virtual_dir: SYSTEM_STRING; physical_dir: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.Type, System.String, System.String): System.Object use System.Web.Hosting.ApplicationHost"
		alias
			"CreateApplicationHost"
		end

end -- class WEB_APPLICATION_HOST
