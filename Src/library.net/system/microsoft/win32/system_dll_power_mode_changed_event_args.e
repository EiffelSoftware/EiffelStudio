indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "Microsoft.Win32.PowerModeChangedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_POWER_MODE_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_power_mode_changed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_power_mode_changed_event_args (mode: SYSTEM_DLL_POWER_MODES) is
		external
			"IL creator signature (Microsoft.Win32.PowerModes) use Microsoft.Win32.PowerModeChangedEventArgs"
		end

feature -- Access

	frozen get_mode: SYSTEM_DLL_POWER_MODES is
		external
			"IL signature (): Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModeChangedEventArgs"
		alias
			"get_Mode"
		end

end -- class SYSTEM_DLL_POWER_MODE_CHANGED_EVENT_ARGS
