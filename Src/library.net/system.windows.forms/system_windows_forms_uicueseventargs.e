indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.UICuesEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_UICUESEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_uicueseventargs

feature {NONE} -- Initialization

	frozen make_uicueseventargs (uicues: SYSTEM_WINDOWS_FORMS_UICUES) is
		external
			"IL creator signature (System.Windows.Forms.UICues) use System.Windows.Forms.UICuesEventArgs"
		end

feature -- Access

	frozen get_changed: SYSTEM_WINDOWS_FORMS_UICUES is
		external
			"IL signature (): System.Windows.Forms.UICues use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_Changed"
		end

	frozen get_show_keyboard: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ShowKeyboard"
		end

	frozen get_show_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ShowFocus"
		end

	frozen get_change_keyboard: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ChangeKeyboard"
		end

	frozen get_change_focus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.UICuesEventArgs"
		alias
			"get_ChangeFocus"
		end

end -- class SYSTEM_WINDOWS_FORMS_UICUESEVENTARGS
