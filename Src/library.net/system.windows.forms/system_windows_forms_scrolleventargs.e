indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ScrollEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_SCROLLEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_scrolleventargs

feature {NONE} -- Initialization

	frozen make_scrolleventargs (type: SYSTEM_WINDOWS_FORMS_SCROLLEVENTTYPE; new_value: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.ScrollEventType, System.Int32) use System.Windows.Forms.ScrollEventArgs"
		end

feature -- Access

	frozen get_type_scroll_event_type: SYSTEM_WINDOWS_FORMS_SCROLLEVENTTYPE is
		external
			"IL signature (): System.Windows.Forms.ScrollEventType use System.Windows.Forms.ScrollEventArgs"
		alias
			"get_Type"
		end

	frozen get_new_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ScrollEventArgs"
		alias
			"get_NewValue"
		end

feature -- Element Change

	frozen set_new_value (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ScrollEventArgs"
		alias
			"set_NewValue"
		end

end -- class SYSTEM_WINDOWS_FORMS_SCROLLEVENTARGS
