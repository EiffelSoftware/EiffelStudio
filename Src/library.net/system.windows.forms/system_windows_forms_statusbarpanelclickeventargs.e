indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.StatusBarPanelClickEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_STATUSBARPANELCLICKEVENTARGS

inherit
	SYSTEM_WINDOWS_FORMS_MOUSEEVENTARGS

create
	make_statusbarpanelclickeventargs

feature {NONE} -- Initialization

	frozen make_statusbarpanelclickeventargs (status_bar_panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL; button: SYSTEM_WINDOWS_FORMS_MOUSEBUTTONS; clicks: INTEGER; x: INTEGER; y: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.StatusBarPanel, System.Windows.Forms.MouseButtons, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.StatusBarPanelClickEventArgs"
		end

feature -- Access

	frozen get_status_bar_panel: SYSTEM_WINDOWS_FORMS_STATUSBARPANEL is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBarPanelClickEventArgs"
		alias
			"get_StatusBarPanel"
		end

end -- class SYSTEM_WINDOWS_FORMS_STATUSBARPANELCLICKEVENTARGS
