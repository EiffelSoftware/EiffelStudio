indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UpDownEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_UPDOWNEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_updowneventargs

feature {NONE} -- Initialization

	frozen make_updowneventargs (button_pushed: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.UpDownEventArgs"
		end

feature -- Access

	frozen get_button_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.UpDownEventArgs"
		alias
			"get_ButtonID"
		end

end -- class SYSTEM_WINDOWS_FORMS_UPDOWNEVENTARGS
