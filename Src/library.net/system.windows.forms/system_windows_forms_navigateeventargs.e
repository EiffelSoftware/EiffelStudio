indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NavigateEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_navigateeventargs

feature {NONE} -- Initialization

	frozen make_navigateeventargs (is_forward: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.Windows.Forms.NavigateEventArgs"
		end

feature -- Access

	frozen get_forward: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NavigateEventArgs"
		alias
			"get_Forward"
		end

end -- class SYSTEM_WINDOWS_FORMS_NAVIGATEEVENTARGS
