indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DateBoldEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DATE_BOLD_EVENT_ARGS

inherit
	EVENT_ARGS

create {NONE}

feature -- Access

	frozen get_days_to_bold: NATIVE_ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Windows.Forms.DateBoldEventArgs"
		alias
			"get_DaysToBold"
		end

	frozen get_start_date: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Windows.Forms.DateBoldEventArgs"
		alias
			"get_StartDate"
		end

	frozen get_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DateBoldEventArgs"
		alias
			"get_Size"
		end

feature -- Element Change

	frozen set_days_to_bold (value: NATIVE_ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Windows.Forms.DateBoldEventArgs"
		alias
			"set_DaysToBold"
		end

end -- class WINFORMS_DATE_BOLD_EVENT_ARGS
