indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.GiveFeedbackEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_givefeedbackeventargs

feature {NONE} -- Initialization

	frozen make_givefeedbackeventargs (effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS; use_default_cursors: BOOLEAN) is
		external
			"IL creator signature (System.Windows.Forms.DragDropEffects, System.Boolean) use System.Windows.Forms.GiveFeedbackEventArgs"
		end

feature -- Access

	frozen get_use_default_cursors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"get_UseDefaultCursors"
		end

	frozen get_effect: SYSTEM_WINDOWS_FORMS_DRAGDROPEFFECTS is
		external
			"IL signature (): System.Windows.Forms.DragDropEffects use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"get_Effect"
		end

feature -- Element Change

	frozen set_use_default_cursors (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GiveFeedbackEventArgs"
		alias
			"set_UseDefaultCursors"
		end

end -- class SYSTEM_WINDOWS_FORMS_GIVEFEEDBACKEVENTARGS
