indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DateRangeEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_DATERANGEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_daterangeeventargs

feature {NONE} -- Initialization

	frozen make_daterangeeventargs (start: SYSTEM_DATETIME; end_: SYSTEM_DATETIME) is
		external
			"IL creator signature (System.DateTime, System.DateTime) use System.Windows.Forms.DateRangeEventArgs"
		end

feature -- Access

	frozen get_end: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.DateRangeEventArgs"
		alias
			"get_End"
		end

	frozen get_start: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.DateRangeEventArgs"
		alias
			"get_Start"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATERANGEEVENTARGS
