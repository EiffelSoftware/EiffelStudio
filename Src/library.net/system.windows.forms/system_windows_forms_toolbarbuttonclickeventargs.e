indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ToolBarButtonClickEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_toolbarbuttonclickeventargs

feature {NONE} -- Initialization

	frozen make_toolbarbuttonclickeventargs (button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON) is
		external
			"IL creator signature (System.Windows.Forms.ToolBarButton) use System.Windows.Forms.ToolBarButtonClickEventArgs"
		end

feature -- Access

	frozen get_button: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON is
		external
			"IL signature (): System.Windows.Forms.ToolBarButton use System.Windows.Forms.ToolBarButtonClickEventArgs"
		alias
			"get_Button"
		end

feature -- Element Change

	frozen set_button (value: SYSTEM_WINDOWS_FORMS_TOOLBARBUTTON) is
		external
			"IL signature (System.Windows.Forms.ToolBarButton): System.Void use System.Windows.Forms.ToolBarButtonClickEventArgs"
		alias
			"set_Button"
		end

end -- class SYSTEM_WINDOWS_FORMS_TOOLBARBUTTONCLICKEVENTARGS
