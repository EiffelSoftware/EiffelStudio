indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DrawItemEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_drawitemeventargs,
	make_drawitemeventargs_1

feature {NONE} -- Initialization

	frozen make_drawitemeventargs (graphics: SYSTEM_DRAWING_GRAPHICS; font: SYSTEM_DRAWING_FONT; rect: SYSTEM_DRAWING_RECTANGLE; index: INTEGER; state: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState) use System.Windows.Forms.DrawItemEventArgs"
		end

	frozen make_drawitemeventargs_1 (graphics: SYSTEM_DRAWING_GRAPHICS; font: SYSTEM_DRAWING_FONT; rect: SYSTEM_DRAWING_RECTANGLE; index: INTEGER; state: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE; fore_color: SYSTEM_DRAWING_COLOR; back_color: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Graphics, System.Drawing.Font, System.Drawing.Rectangle, System.Int32, System.Windows.Forms.DrawItemState, System.Drawing.Color, System.Drawing.Color) use System.Windows.Forms.DrawItemEventArgs"
		end

feature -- Access

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
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

	frozen get_state: SYSTEM_WINDOWS_FORMS_DRAWITEMSTATE is
		external
			"IL signature (): System.Windows.Forms.DrawItemState use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_State"
		end

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Bounds"
		end

	frozen get_graphics: SYSTEM_DRAWING_GRAPHICS is
		external
			"IL signature (): System.Drawing.Graphics use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Graphics"
		end

	frozen get_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.DrawItemEventArgs"
		alias
			"get_Font"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
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

end -- class SYSTEM_WINDOWS_FORMS_DRAWITEMEVENTARGS
