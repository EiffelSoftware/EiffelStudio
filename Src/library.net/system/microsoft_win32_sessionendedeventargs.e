indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.SessionEndedEventArgs"

external class
	MICROSOFT_WIN32_SESSIONENDEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_sessionendedeventargs

feature {NONE} -- Initialization

	frozen make_sessionendedeventargs (reason: MICROSOFT_WIN32_SESSIONENDREASONS) is
		external
			"IL creator signature (Microsoft.Win32.SessionEndReasons) use Microsoft.Win32.SessionEndedEventArgs"
		end

feature -- Access

	frozen get_reason: MICROSOFT_WIN32_SESSIONENDREASONS is
		external
			"IL signature (): Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndedEventArgs"
		alias
			"get_Reason"
		end

end -- class MICROSOFT_WIN32_SESSIONENDEDEVENTARGS
