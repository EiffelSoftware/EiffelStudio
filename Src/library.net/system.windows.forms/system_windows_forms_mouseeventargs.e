indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MouseEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_mouseeventargs

feature {NONE} -- Initialization

	frozen make_mouseeventargs (button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS; clicks: INTEGER; x: INTEGER; y: INTEGER; delta: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.MouseButtons, System.Int32, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.MouseEventArgs"
		end

feature -- Access

	frozen get_clicks: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Clicks"
		end

	frozen get_y: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Y"
		end

	frozen get_delta: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Delta"
		end

	frozen get_button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS is
		external
			"IL signature (): System.Windows.Forms.MouseButtons use System.Windows.Forms.MouseEventArgs"
		alias
			"get_Button"
		end

	frozen get_x: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MouseEventArgs"
		alias
			"get_X"
		end

end -- class SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS
