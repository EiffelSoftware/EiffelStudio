indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ControlEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_CONTROLEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_controleventargs

feature {NONE} -- Initialization

	frozen make_controleventargs (control: SYSTEM_WINDOWS_FORMS_CONTROL) is
		external
			"IL creator signature (System.Windows.Forms.Control) use System.Windows.Forms.ControlEventArgs"
		end

feature -- Access

	frozen get_control: SYSTEM_WINDOWS_FORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control use System.Windows.Forms.ControlEventArgs"
		alias
			"get_Control"
		end

end -- class SYSTEM_WINDOWS_FORMS_CONTROLEVENTARGS
