indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.Configuration.HttpConfigurationContext"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	WEB_HTTP_CONFIGURATION_CONTEXT

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_virtual_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.Configuration.HttpConfigurationContext"
		alias
			"get_VirtualPath"
		end

end -- class WEB_HTTP_CONFIGURATION_CONTEXT
