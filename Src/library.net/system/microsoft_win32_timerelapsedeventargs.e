indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "Microsoft.Win32.TimerElapsedEventArgs"

external class
	MICROSOFT_WIN32_TIMERELAPSEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_timerelapsedeventargs

feature {NONE} -- Initialization

	frozen make_timerelapsedeventargs (timer_id: POINTER) is
		external
			"IL creator signature (System.IntPtr) use Microsoft.Win32.TimerElapsedEventArgs"
		end

feature -- Access

	frozen get_timer_id: POINTER is
		external
			"IL signature (): System.IntPtr use Microsoft.Win32.TimerElapsedEventArgs"
		alias
			"get_TimerId"
		end

end -- class MICROSOFT_WIN32_TIMERELAPSEDEVENTARGS
