indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.PowerModeChangedEventArgs"

external class
	MICROSOFT_WIN32_POWERMODECHANGEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_powermodechangedeventargs

feature {NONE} -- Initialization

	frozen make_powermodechangedeventargs (mode: MICROSOFT_WIN32_POWERMODES) is
		external
			"IL creator signature (Microsoft.Win32.PowerModes) use Microsoft.Win32.PowerModeChangedEventArgs"
		end

feature -- Access

	frozen get_mode: MICROSOFT_WIN32_POWERMODES is
		external
			"IL signature (): Microsoft.Win32.PowerModes use Microsoft.Win32.PowerModeChangedEventArgs"
		alias
			"get_Mode"
		end

end -- class MICROSOFT_WIN32_POWERMODECHANGEDEVENTARGS
