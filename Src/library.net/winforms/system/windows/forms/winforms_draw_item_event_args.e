indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DrawItemEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DRAW_ITEM_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_draw_item_event_args,
	make_winforms_draw_item_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_draw_item_event_args (graphics: DRAWING_GRAPHICS; font: DRAWING_FONT; rect: DRAWING_RECTANGLE; index: INTEGER; state: WINFORMS_DRAW_ITEM_STATE) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState) use System.Windows.Forms.DrawItemEventArgs"
		end

	frozen make_winforms_draw_item_event_args_1 (graphics: DRAWING_GRAPHICS; font: DRAWING_FONT; rect: DRAWING_RECTANGLE; index: INTEGER; state: WINFORMS_DRAW_ITEM_STATE; fore_color: DRAWING_COLOR; back_color: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState, System.Drawing.Color, System.Drawing.Color) use System.Windows.Forms.DrawItemEventArgs"
		end

feature -- Access

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_ForeColor"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Index"
		end

	frozen get_state: WINFORMS_DRAW_ITEM_STATE is
		external
			"IL signature (): System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_State"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Bounds"
		end

	frozen get_graphics: DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Font"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_BackColor"
		end

feature -- Basic Operations

	draw_background is
		external
			"IL signature (): System.Void use System.Windows.Forms.DrawItemEventArgs"
		alias
			"DrawBackground"
		end

	draw_focus_rectangle is
		external
			"IL signature (): System.Void use System.Windows.Forms.DrawItemEventArgs"
		alias
			"DrawFocusRectangle"
		end

end -- class WINFORMS_DRAW_ITEM_EVENT_ARGS
