indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.HelpEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_HELPEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_helpeventargs

feature {NONE} -- Initialization

	frozen make_helpeventargs (mouse_pos: SYSTEM_DRAWING_POINT) is
		external
			"IL creator signature (System.Drawing.Point) use System.Windows.Forms.HelpEventArgs"
		end

feature -- Access

	frozen get_mouse_pos: SYSTEM_DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.HelpEventArgs"
		alias
			"get_MousePos"
		end

	frozen get_handled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.HelpEventArgs"
		alias
			"get_Handled"
		end

feature -- Element Change

	frozen set_handled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.HelpEventArgs"
		alias
			"set_Handled"
		end

end -- class SYSTEM_WINDOWS_FORMS_HELPEVENTARGS
