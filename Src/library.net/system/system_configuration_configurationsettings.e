indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.ConfigurationSettings"

frozen external class
	SYSTEM_CONFIGURATION_CONFIGURATIONSETTINGS

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Configuration.ConfigurationSettings"
		end

feature -- Access

	frozen get_app_settings: SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION is
		external
			"IL static signature (): System.Collections.Specialized.NameValueCollection use System.Configuration.ConfigurationSettings"
		alias
			"get_AppSettings"
		end

feature -- Basic Operations

	frozen get_config (section_name: STRING): ANY is
		external
			"IL static signature (System.String): System.Object use System.Configuration.ConfigurationSettings"
		alias
			"GetConfig"
		end

end -- class SYSTEM_CONFIGURATION_CONFIGURATIONSETTINGS
