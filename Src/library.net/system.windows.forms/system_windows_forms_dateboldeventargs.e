indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DateBoldEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_DATEBOLDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create {NONE}

feature -- Access

	frozen get_days_to_bold: ARRAY [INTEGER] is
		external
			"IL signature (): System.Int32[] use System.Windows.Forms.DateBoldEventArgs"
		alias
			"get_DaysToBold"
		end

	frozen get_start_date: SYSTEM_DATETIME is
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

	frozen set_days_to_bold (value: ARRAY [INTEGER]) is
		external
			"IL signature (System.Int32[]): System.Void use System.Windows.Forms.DateBoldEventArgs"
		alias
			"set_DaysToBold"
		end

end -- class SYSTEM_WINDOWS_FORMS_DATEBOLDEVENTARGS
