indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.SessionEndingEventArgs"

external class
	MICROSOFT_WIN32_SESSIONENDINGEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_sessionendingeventargs

feature {NONE} -- Initialization

	frozen make_sessionendingeventargs (reason: MICROSOFT_WIN32_SESSIONENDREASONS) is
		external
			"IL creator signature (Microsoft.Win32.SessionEndReasons) use Microsoft.Win32.SessionEndingEventArgs"
		end

feature -- Access

	frozen get_reason: MICROSOFT_WIN32_SESSIONENDREASONS is
		external
			"IL signature (): Microsoft.Win32.SessionEndReasons use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"get_Reason"
		end

	frozen get_cancel: BOOLEAN is
		external
			"IL signature (): System.Boolean use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"get_Cancel"
		end

feature -- Element Change

	frozen set_cancel (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use Microsoft.Win32.SessionEndingEventArgs"
		alias
			"set_Cancel"
		end

end -- class MICROSOFT_WIN32_SESSIONENDINGEVENTARGS
