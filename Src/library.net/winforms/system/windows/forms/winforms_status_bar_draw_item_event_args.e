indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.StatusBarDrawItemEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_STATUS_BAR_DRAW_ITEM_EVENT_ARGS

inherit
	WINFORMS_DRAW_ITEM_EVENT_ARGS

create
	make_winforms_status_bar_draw_item_event_args

feature {NONE} -- Initialization

	frozen make_winforms_status_bar_draw_item_event_args (g: DRAWING_GRAPHICS; font: DRAWING_FONT; r: DRAWING_RECTANGLE; item_id: INTEGER; item_state: WINFORMS_DRAW_ITEM_STATE; panel: WINFORMS_STATUS_BAR_PANEL) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState, System.Windows.Forms.StatusBarPanel) use System.Windows.Forms.StatusBarDrawItemEventArgs"
		end

feature -- Access

	frozen get_panel: WINFORMS_STATUS_BAR_PANEL is
		external
			"IL signature (): System.Windows.Forms.StatusBarPanel use System.Windows.Forms.StatusBarDrawItemEventArgs"
		alias
			"get_Panel"
		end

end -- class WINFORMS_STATUS_BAR_DRAW_ITEM_EVENT_ARGS
