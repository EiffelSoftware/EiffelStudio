indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Configuration.AppSettingsReader"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_APP_SETTINGS_READER

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Configuration.AppSettingsReader"
		end

feature -- Basic Operations

	frozen get_value (key: SYSTEM_STRING; type: TYPE): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.Type): System.Object use System.Configuration.AppSettingsReader"
		alias
			"GetValue"
		end

end -- class SYSTEM_DLL_APP_SETTINGS_READER
