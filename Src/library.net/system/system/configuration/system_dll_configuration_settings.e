indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.ConfigurationSettings"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_CONFIGURATION_SETTINGS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_app_settings: SYSTEM_DLL_NAME_VALUE_COLLECTION is
		external
			"IL static signature (): System.Collections.Specialized.NameValueCollection use System.Configuration.ConfigurationSettings"
		alias
			"get_AppSettings"
		end

feature -- Basic Operations

	frozen get_config (section_name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL static signature (System.String): System.Object use System.Configuration.ConfigurationSettings"
		alias
			"GetConfig"
		end

end -- class SYSTEM_DLL_CONFIGURATION_SETTINGS
