indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Configuration.IConfigurationSystem"

deferred external class
	SYSTEM_CONFIGURATION_ICONFIGURATIONSYSTEM

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	init is
		external
			"IL deferred signature (): System.Void use System.Configuration.IConfigurationSystem"
		alias
			"Init"
		end

	get_config (config_key: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.Configuration.IConfigurationSystem"
		alias
			"GetConfig"
		end

end -- class SYSTEM_CONFIGURATION_ICONFIGURATIONSYSTEM
