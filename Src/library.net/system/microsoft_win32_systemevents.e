indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.SystemEvents"

frozen external class
	MICROSOFT_WIN32_SYSTEMEVENTS

create {NONE}

feature -- Element Change

	frozen add_timer_elapsed (value: MICROSOFT_WIN32_TIMERELAPSEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.TimerElapsedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_TimerElapsed"
		end

	frozen add_palette_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_PaletteChanged"
		end

	frozen add_installed_fonts_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_InstalledFontsChanged"
		end

	frozen add_session_ending (value: MICROSOFT_WIN32_SESSIONENDINGEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.SessionEndingEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_SessionEnding"
		end

	frozen remove_session_ended (value: MICROSOFT_WIN32_SESSIONENDEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.SessionEndedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_SessionEnded"
		end

	frozen add_time_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_TimeChanged"
		end

	frozen remove_display_settings_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_DisplaySettingsChanged"
		end

	frozen add_user_preference_changed (value: MICROSOFT_WIN32_USERPREFERENCECHANGEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.UserPreferenceChangedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_UserPreferenceChanged"
		end

	frozen remove_events_thread_shutdown (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_EventsThreadShutdown"
		end

	frozen remove_session_ending (value: MICROSOFT_WIN32_SESSIONENDINGEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.SessionEndingEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_SessionEnding"
		end

	frozen add_session_ended (value: MICROSOFT_WIN32_SESSIONENDEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.SessionEndedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_SessionEnded"
		end

	frozen add_events_thread_shutdown (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_EventsThreadShutdown"
		end

	frozen remove_timer_elapsed (value: MICROSOFT_WIN32_TIMERELAPSEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.TimerElapsedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_TimerElapsed"
		end

	frozen remove_time_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_TimeChanged"
		end

	frozen remove_power_mode_changed (value: MICROSOFT_WIN32_POWERMODECHANGEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.PowerModeChangedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_PowerModeChanged"
		end

	frozen add_low_memory (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_LowMemory"
		end

	frozen remove_user_preference_changed (value: MICROSOFT_WIN32_USERPREFERENCECHANGEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.UserPreferenceChangedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_UserPreferenceChanged"
		end

	frozen remove_palette_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_PaletteChanged"
		end

	frozen add_display_settings_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_DisplaySettingsChanged"
		end

	frozen remove_installed_fonts_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_InstalledFontsChanged"
		end

	frozen remove_low_memory (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"remove_LowMemory"
		end

	frozen add_power_mode_changed (value: MICROSOFT_WIN32_POWERMODECHANGEDEVENTHANDLER) is
		external
			"IL static signature (Microsoft.Win32.PowerModeChangedEventHandler): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"add_PowerModeChanged"
		end

feature -- Basic Operations

	frozen kill_timer (timer_id: POINTER) is
		external
			"IL static signature (System.IntPtr): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"KillTimer"
		end

	frozen invoke_on_events_thread (method: SYSTEM_DELEGATE) is
		external
			"IL static signature (System.Delegate): System.Void use Microsoft.Win32.SystemEvents"
		alias
			"InvokeOnEventsThread"
		end

	frozen create_timer (interval: INTEGER): POINTER is
		external
			"IL static signature (System.Int32): System.IntPtr use Microsoft.Win32.SystemEvents"
		alias
			"CreateTimer"
		end

end -- class MICROSOFT_WIN32_SYSTEMEVENTS
