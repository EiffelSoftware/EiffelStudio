indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.WarningException"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_WARNING_EXCEPTION

inherit
	SYSTEM_EXCEPTION
	ISERIALIZABLE

create
	make_system_dll_warning_exception,
	make_system_dll_warning_exception_2,
	make_system_dll_warning_exception_1

feature {NONE} -- Initialization

	frozen make_system_dll_warning_exception (message: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.WarningException"
		end

	frozen make_system_dll_warning_exception_2 (message: SYSTEM_STRING; help_url: SYSTEM_STRING; help_topic: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.ComponentModel.WarningException"
		end

	frozen make_system_dll_warning_exception_1 (message: SYSTEM_STRING; help_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.ComponentModel.WarningException"
		end

feature -- Access

	frozen get_help_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.WarningException"
		alias
			"get_HelpUrl"
		end

	frozen get_help_topic: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.WarningException"
		alias
			"get_HelpTopic"
		end

end -- class SYSTEM_DLL_WARNING_EXCEPTION
