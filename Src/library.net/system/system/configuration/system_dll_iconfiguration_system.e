indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.IConfigurationSystem"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICONFIGURATION_SYSTEM

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	init is
		external
			"IL deferred signature (): System.Void use System.Configuration.IConfigurationSystem"
		alias
			"Init"
		end

	get_config (config_key: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.Configuration.IConfigurationSystem"
		alias
			"GetConfig"
		end

end -- class SYSTEM_DLL_ICONFIGURATION_SYSTEM
