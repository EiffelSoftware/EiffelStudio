indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.StatusBarPanelClickEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATUS_BAR_PANEL_CLICK_EVENT_ARGS

inherit
	WINFORMS_MOUSE_EVENT_ARGS

create
	make_winforms_status_bar_panel_click_event_args

feature {NONE} -- Initialization

	frozen make_winforms_status_bar_panel_click_event_args (status_bar_panel: WINFORMS_STATUS_BAR_PANEL; button: WINFORMS_MOUSE_BUTTONS; clicks: INTEGER; x: INTEGER; y: INTEGER) is
		external
			"IL creator signature (System.Windows.Forms.StatusBarPanel, System.Windows.Forms.MouseButtons, System.Int32, System.Int32, System.Int32) use System.Windows.Forms.StatusBarPanelClickEventArgs"
		end

feature -- Access

	frozen get_status_bar_panel: WINFORMS_STATUS_BAR_PANEL is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBarPanelClickEventArgs"
		alias
			"get_StatusBarPanel"
		end

end -- class WINFORMS_STATUS_BAR_PANEL_CLICK_EVENT_ARGS
